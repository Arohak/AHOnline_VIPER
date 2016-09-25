//
//  LocationHelper.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import Alamofire

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
    
    func startUpdatingLocation(callback: @escaping (CLLocation?, String?) -> Void) {
        UIHelper.showSpinner()
        locationRecieved = false
        handler = callback
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            let status = CLLocationManager.authorizationStatus()
            if status == .authorizedAlways || status == .authorizedWhenInUse {
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
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        } else {
            UIHelper.hideSpinner()
            handler!(nil, "recstricted_location_services".localizedString)
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if  locations.last != nil && locationRecieved == false {
            UIHelper.hideSpinner()
            locationRecieved = true
            locationManager.stopUpdatingLocation()
            handler!(locations.last!, nil)
        }
    }
    
    // MARK: - Geocode Address
    func geocodeAddress(location: CLLocationCoordinate2D!, withCompletionHandler completionHandler: @escaping ((_ status: String?, _ address: String, _ success: Bool) -> Void)) {
        UIHelper.showSpinner()
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(location) { (response, error) -> Void in
            if response != nil && error == nil {
                let address = response!.firstResult()! as GMSAddress
                let array = address.lines!
                completionHandler(nil, array.joined(separator: ","), true)
            } else {
                completionHandler("", "", false)
            }
            
            UIHelper.hideSpinner()
        }
    }
    
    // MARK: - DrawRoute
    func getDirections(origin: String!, destination: String!, waypoints: Array<String>!, travelMode: AnyObject!, completionHandler: @escaping ((_ status: String?, _ polyline: GMSPolyline?, _ success: Bool) -> Void)) {
        UIHelper.hideSpinner()
        if let originLocation = origin {
            if let destinationLocation = destination {
                let baseURLDirections = "https://maps.googleapis.com/maps/api/directions/json?"
                var directionsURLString = baseURLDirections + "origin=" + originLocation + "&destination=" + destinationLocation + "&mode=walking"
                
                directionsURLString = directionsURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                Alamofire.request(directionsURLString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["Accept" : "application/json"])
                    .responseJSON { response in
                        switch response.result {
                        case .success(let data):
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
                                    completionHandler(status, polyline, true)
                                }
                                else {
                                    completionHandler(status, nil, false)
                                }
                            } else {
                                completionHandler("", nil, false)
                            }
                        case .failure(let error):
                            completionHandler(error.localizedDescription, nil, false)
                        }
                        UIHelper.hideSpinner()
                }
            } else {
                UIHelper.hideSpinner()
                completionHandler("Destination is nil.", nil, false)
            }
        } else {
            UIHelper.hideSpinner()
            completionHandler("Origin is nil", nil, false)
        }
    }
}
