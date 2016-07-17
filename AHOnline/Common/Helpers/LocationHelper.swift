//
//  LocationHelper.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

let locationHelper = LocationHelper.sharedInstance

class LocationHelper: NSObject, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var handler: ((CLLocation?, String?) -> Void)?
    var locationRecieved: Bool = false
    
    static let sharedInstance = LocationHelper()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation(callback: (CLLocation?, String?) -> Void) {
        UIHelper.showSpinner()
        locationRecieved = false
        handler = callback
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            let status = CLLocationManager.authorizationStatus()
            if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
                locationManager.startUpdatingLocation()
            } else {
                UIHelper.hideSpinner()
                handler!(nil, "recstricted_location_services".localizedString)
            }
        } else {
            UIHelper.hideSpinner()
            handler!(nil, "location_services_disabled".localizedString)
        }
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            UIHelper.hideSpinner()
            handler!(nil, "recstricted_location_services".localizedString)
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if  locations.last != nil && locationRecieved == false {
            UIHelper.hideSpinner()
            locationRecieved = true
            locationManager.stopUpdatingLocation()
            handler!(locations.last!, nil)
        }
    }
    
    // MARK: - Geocode Address
    func geocodeAddress(location: CLLocationCoordinate2D!, withCompletionHandler completionHandler: ((status: String?, address: String, success: Bool) -> Void)) {
        UIHelper.showSpinner()
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(location) { (response, error) -> Void in
            if response != nil && error == nil {
                let address = response!.firstResult()! as GMSAddress
                let array = address.lines! 
                completionHandler(status: nil, address: array.joinWithSeparator(","), success: true)
            } else {
                completionHandler(status: error!.localizedDescription, address: "", success: false)
            }
            
            UIHelper.hideSpinner()
        }
    }
    
    // MARK: - DrawRoute
    func getDirections(origin: String!, destination: String!, waypoints: Array<String>!, travelMode: AnyObject!, completionHandler: ((status: String?, polyline: GMSPolyline?, success: Bool) -> Void)) {
        UIHelper.hideSpinner()
        if let originLocation = origin {
            if let destinationLocation = destination {
                let baseURLDirections = "https://maps.googleapis.com/maps/api/directions/json?"
                var directionsURLString = baseURLDirections + "origin=" + originLocation + "&destination=" + destinationLocation + "&mode=walking"
                
                directionsURLString = directionsURLString.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                
                Alamofire.request(.GET, directionsURLString, parameters: nil, encoding: ParameterEncoding.URL, headers: ["Accept" : "application/json"])
                    .responseJSON { response in
                        switch response.result {
                        case .Success(let data):
                            let data = JSON(data)
                            if data != nil {
                                let status = data["status"].stringValue
                                
                                if status == "OK" {
                                    let selectedRoute = data["routes"].arrayValue
                                    let overviewPolyline = selectedRoute[0]["overview_polyline"]
                                    let route = overviewPolyline["points"].stringValue
                                    let path: GMSPath = GMSPath(fromEncodedPath: route)!
                                    let polyline = GMSPolyline(path: path)
                                    
                                    UIHelper.hideSpinner()
                                    completionHandler(status: status, polyline: polyline, success: true)
                                }
                                else {
                                    completionHandler(status: status, polyline: nil, success: false)
                                }
                            } else {
                                completionHandler(status: "", polyline: nil, success: false)
                            }
                        case .Failure(let error):
                            completionHandler(status: error.localizedDescription, polyline: nil, success: false)
                        }
                        UIHelper.hideSpinner()
                }
            } else {
                UIHelper.hideSpinner()
                completionHandler(status: "Destination is nil.", polyline: nil, success: false)
            }
        } else {
            UIHelper.hideSpinner()
            completionHandler(status: "Origin is nil", polyline: nil, success: false)
        }
    }
}
