//
//  MapViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import AlamofireImage

class MapViewController: BaseViewController {
    
    var output: MapViewOutput!

    internal let cellIdentifire      = "cellIdentifire"
    internal var location: CLLocation!
    internal var locationAddress: String!
    internal var myMarker: GMSMarker!
    internal var drewPolyline: GMSPolyline!
    internal var allGMSMarkers: [GMSMarker] = []
    internal var selectedGMSMarker: GMSMarker?
    internal var objects: [AHObject] = []
    internal var addresses: [Address] = []
    internal var myUserData = 1000000
    internal var callback: ((CLLocation?, String?) -> Void)?
    internal var distance = 5.0
    internal var distances: [Double] = [1, 2, 5, 10, 20, 50, 100]
    
    internal let imageDownloader = ImageDownloader(
        configuration: ImageDownloader.defaultURLSessionConfiguration(),
        downloadPrioritization: .fifo,
        maximumActiveDownloads: 4,
        imageCache: AutoPurgingImageCache()
    )
    
    //MARK: - Create UIElements
    internal let mapView = MapView()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startUpdatingLocation { _ in }
        getNearestObjects()
//        getObjects()
    }
    
    // MARK: - Internal Method -
     override func baseConfig() {
        self.view = mapView

        mapView.tableView.dataSource = self
        mapView.tableView.delegate = self
        mapView.tableView.register(MapObjectsCell.self, forCellReuseIdentifier: cellIdentifire)
        
        mapView.map.delegate = self
        mapView.bottomView.closeRoutButton.addTarget(self, action: #selector(clearPolyline(sender:)), for: .touchUpInside)
        mapView.bottomView.locationButton.addTarget(self, action: #selector(goToMyLocation(sender:)), for: .touchUpInside)
    }
    
    override func updateLocalizedStrings() {
        
        navigationItem.title = "map".localizedString
        navigationItem.setRightBarButton(UIBarButtonItem(title: "close".localizedString, style: .plain, target: self, action: #selector(closeAction)), animated: true)
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "distance".localizedString, style: .plain, target: self, action: #selector(chooseDistanceAction)), animated: true)
    }
    
    //MARK: - Actions -
    func closeAction() {
        output.closeButtonClicked()
    }

    func clearPolyline(sender: UIButton) {
        drewPolyline.map = nil
        mapView.bottomView.closeRoutButton.isHidden = true
    }
    
    func goToMyLocation(sender: UIButton) {
        startUpdatingLocation { (location, error) -> Void in
            self.mapView.map.animate(to: GMSCameraPosition.camera(withLatitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude, zoom: 17))
            if let myMarker = self.myMarker { myMarker.map = nil }
            self.showMyMarkerInMap(location: location)
        }
    }
    
    func chooseDistanceAction() {
        let actionSheet = DistanceActionSheetPickerViewController(distances: distances) { distance, index in
            self.distance = distance
            self.getNearestObjects()
        }
        actionSheet.pickerView.selectRow(distances.index(of: distance)!, inComponent: 0, animated: true)
        
        output.presentViewController(vc: actionSheet)
    }
    
    func getNearestObjects() {
        startUpdatingLocation { (location, error) -> Void in
            if let location = location {
                let json = JSON([
                    "latitude"  : "\(location.coordinate.latitude)",
                    "longitude" : "\(location.coordinate.longitude)",
                    "km"        : "\(self.distance)"])
                
                self.output.getNearestObjects(json: json)
            }
        }
    }
    
    func getObjects() {
        let params = JSON([
            "limit"             : "5",
            "offset"            : "0",
            "type"              : "all"])
        
        output.getObjects(json: params)
    }
    
    //MARK: - Internal Methods -
    internal func showMyMarkerInMap(location: CLLocation?) {
        if let location = location {
            myMarker = GMSMarker()
            myMarker.position = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            myMarker.icon = UIImage(named: "img_mapview_mypin")
            myMarker.map = mapView.map
            allGMSMarkers.append(myMarker)
            myMarker.userData = myUserData
        }
    }
    
    internal func onLocationRecieved(location: CLLocation) {
        if location.coordinate.latitude != 0.0 && location.coordinate.longitude != 0.0 {
            self.location = location
            locationHelper.geocodeAddress(location: location.coordinate, withCompletionHandler: { (status, address, success) -> Void in
                if success { self.locationAddress =  address}
            })
        }
    }
    
    internal func drawRoute(address: Address) {
        startUpdatingLocation { (location, error) -> Void in
            let markerLocation = String(format: "%f,%f", address.latitude, address.longitude)
            let originLocation = String(format: "%f,%f", location!.coordinate.latitude, location!.coordinate.longitude)
            
            locationHelper.getDirections(origin: originLocation, destination: markerLocation, waypoints: nil, travelMode: nil, completionHandler: { (status, polyline, success) in
                if success {
                    polyline!.strokeColor = .red_
                    polyline!.strokeWidth = Device.ipad ? 5 : 3
                    polyline!.map = self.mapView.map
                    if let drewPolyline = self.drewPolyline { drewPolyline.map = nil }
                    if self.myMarker == nil { self.showMyMarkerInMap(location: location) }
                    
                    self.drewPolyline = polyline
                    self.mapView.bottomView.closeRoutButton.isHidden = false
                } else {
                    UIHelper.showHUD(message: error ?? "location_services_disabled".localizedString)
                }
            })
        }
    }
    
    internal func focusMapToShowAllMarkers() {
        let myLocation = allGMSMarkers.first!.position
        var bounds = GMSCoordinateBounds(coordinate: myLocation, coordinate: myLocation)
        for marker in allGMSMarkers {
            bounds = bounds.includingCoordinate(marker.position)
        }
        if allGMSMarkers.count == 1 {
            mapView.map.animate(to: GMSCameraPosition.camera(withLatitude: allGMSMarkers[0].position.latitude, longitude: allGMSMarkers[0].position.longitude, zoom: 17))
        } else if  allGMSMarkers.count > 1 {
            mapView.map.animate(with: GMSCameraUpdate.fit(bounds, withPadding: Device.ipad ? 100 : 70))
        }
    }
    
    internal func focusMapToShowMarkers(objects: [AHObject]) {
        let myLocation = myMarker.position
        var bounds = GMSCoordinateBounds(coordinate: myLocation, coordinate: myLocation)
        for object in objects {
            for address in object.addresses {
                let position = CLLocationCoordinate2D(latitude: address.latitude, longitude: address.longitude)
                bounds = bounds.includingCoordinate(position)
            }
        }
        mapView.map.animate(with: GMSCameraUpdate.fit(bounds, withPadding: Device.ipad ? 100 : 50))
    }
    
    internal func showMarkersInMap(pins: [Address]) {
        for (index, value) in pins.enumerated() {
            let marker = GMSMarker()
            let object = objects.filter { $0.id == value.restaurant_id }.first!
            loadMarkerImage(marker: marker, url: object.src)
            marker.position = CLLocationCoordinate2DMake(value.latitude, value.longitude)
            marker.map = mapView.map
            marker.userData = index
            allGMSMarkers.append(marker)
        }
        addresses = pins
    }
    
    internal func loadMarkerImage(marker: GMSMarker, url: String) {
        let imgString = "img_mapview_pinplaceholder"
        let pinImage = UIImage(named: imgString)
        marker.icon = pinImage
        
        let urlRequest = URLRequest(url: URL(string: url)!)
        imageDownloader.download(urlRequest) { response in
            if let image = response.result.value {
                marker.icon = Utils.maskImage(image: UIImage(named: imgString)!, withMask: image)
            }
        }
    }
    
    internal func startUpdatingLocation(callback: @escaping (CLLocation?, String?) -> Void) {
        locationHelper.startUpdatingLocation { (location, error) -> Void in
            if error == nil && location != nil {
                self.onLocationRecieved(location: location!)
                callback(location, error)
            } else {
                UIHelper.showHUD(message: error ?? "location_services_disabled".localizedString)
            }
        }
    }
    
    //MARK: - Public Methods
    func setMarkersInMap(pins: [Address]) {
        self.mapView.map.clear()
        allGMSMarkers.removeAll()
        addresses.removeAll()
        mapView.bottomView.closeRoutButton.isHidden = true
        
        self.showMyMarkerInMap(location: location)
        self.showMarkersInMap(pins: pins)
        self.focusMapToShowAllMarkers()
    }
    
    func setMarkerInMap(pin: Address) {
        mapView.map.clear()
        allGMSMarkers.removeAll()
        addresses.removeAll()
        mapView.bottomView.closeRoutButton.isHidden = true
        
        self.showMyMarkerInMap(location: location)
        self.showMarkersInMap(pins: [pin])
        self.focusMapToShowAllMarkers()
    }
}

//MARK: - extension for MapViewInput -
extension MapViewController: MapViewInput {
    
    func setupInitialState(objects: [AHObject]) {
        addresses.removeAll()
        self.objects = objects
        
        for object in objects {
            for address in object.addresses {
                addresses.append(address)
            }
        }
        
        addresses = addresses.sorted { $0.0.distance < $0.1.distance }
        
        setMarkersInMap(pins: addresses)
        mapView.tableView.reloadData()
    }
}

//MARK: - extension for GMSMapViewDelegate -
extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let tag = marker.userData as! Int
        
        let customInfoWindow = MPInfoWindow(frame: CGRect(x: 0, y: 0, width: MP_INFOWINDOW_SIZE*4, height: MP_INFOWINDOW_SIZE + MP_INSET/2))
        if tag != myUserData {
            let selectedMarker = addresses[marker.userData as! Int]
            let object = objects.filter { $0.id == selectedMarker.restaurant_id }.first!
            customInfoWindow.drawRoutButton.tag = marker.userData as! Int
            customInfoWindow.titleLabel.text = object.label
            customInfoWindow.descLabel.text = selectedMarker.name
        } else {
            customInfoWindow.titleLabel.numberOfLines = 2
            customInfoWindow.widthRoutConstraints.constant = 0
            customInfoWindow.titleCenterConstraints.constant = MP_INSET/2
            customInfoWindow.titleLabel.text = locationAddress
        }
        
        customInfoWindow.layoutIfNeeded()
        return customInfoWindow
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        let tag = marker.userData as! Int
        if tag != myUserData {
            let address = addresses[marker.userData as! Int]
            drawRoute(address: address)
//            let object = objects.filter { $0.id == address.restaurant_id }.first!
//            output.didSelectObject(object)
        }
    }
}

//MARK: - extension for UITableView -
extension MapViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let address = addresses[indexPath.row]
        let object = objects.filter { $0.id == address.restaurant_id }.first!

        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire) as! MapObjectsCell
        cell.setValues(imageURL: URL(string: object.src)!, name: object.label, address: address.name, distance: String(format: "%.2f km", address.distance/1000))

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let address = addresses[indexPath.row]
        let object = objects.filter { $0.id == address.restaurant_id }.first!
        output.didSelectObject(object: object)
    }
}
