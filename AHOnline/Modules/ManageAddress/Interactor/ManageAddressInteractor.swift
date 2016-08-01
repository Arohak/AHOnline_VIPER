//
//  ManageAddressInteractor.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class ManageAddressInteractor -
class ManageAddressInteractor {

    weak var output: ManageAddressInteractorOutput!
    
    var user: User {
        return DBManager.getUser()!
    }
    
    // MARK: - Private Method -
    private func getCountriesFromNSLocale() -> [String] {
        var dictionary = Dictionary<String,String>()
        for countryCode in NSLocale.ISOCountryCodes() {
            let identifier = NSLocale.localeIdentifierFromComponents([NSLocaleCountryCode : countryCode])
            if let country = NSLocale.currentLocale().displayNameForKey(NSLocaleIdentifier, value: identifier) {
                dictionary[country] = identifier
            }
        }
        let keys = Array(dictionary.keys).sort(<)
        
        return keys
    }
    
    private func getCitiesFromDelivery(deliveries: [Delivery]) -> [String] {
        var cities: [String] = []
        for delivery in deliveries {
            cities.append(delivery.city)
        }
        
        return cities
    }
}

//MARK: - extension for ManageAddressInteractorInput -
extension ManageAddressInteractor: ManageAddressInteractorInput {
    
    func getDeliveries() {
        _ = APIManager.getDeliveries()
            .subscribe(onNext: { result in
                if result != nil {
                    var deliveries: [Delivery] = []
                    for item in result["data"].arrayValue {
                        deliveries.append(Delivery(data: item))
                    }
                    DBManager.storeDeliveries(deliveries)
                    self.output.dataIsReady(self.user, countries: self.getCountriesFromNSLocale(), cities: self.getCitiesFromDelivery(deliveries))
                }
                }, onError: { error in
                    let deliveries = DBManager.getDeliveries()
                    self.output.dataIsReady(self.user, countries: self.getCountriesFromNSLocale(), cities: self.getCitiesFromDelivery(Array(deliveries)))
            })
    }
    
    func saveDeliveryAddressData(json: JSON) {
        if let address = user.address {
            let json = JSON([
                "user_id"   : user.id,
                "country"   : json["country"].stringValue,
                "city"      : json["city"].stringValue,
                "address"   : json["address"].stringValue,
                "def"       : json["def"].boolValue])
            
            _ = APIManager.updateDeliveryAddress("\(address.id)", json: json)
                .subscribe(onNext: { result in
                    if result != nil {
                        let info = DeliveryAddressInfo(data: result["data"])
                        DBManager.updateDeliveryAddress(info)
                        
                        self.output.saveAddressIsReady()
                    }
                })
        } else {
            let json = JSON([
                "user_id"   : user.id,
                "country"   : json["country"].stringValue,
                "city"      : json["city"].stringValue,
                "address"   : json["address"].stringValue])
            
            _ = APIManager.createDeliveryAddress(json)
                .subscribe(onNext: { result in
                    if result != nil {
                        let address = DeliveryAddress(data: result["data"])
                        DBManager.storeDeliveryAddress(address)
                        
                        self.output.saveAddressIsReady()
                    }
                })
        }
    }
}