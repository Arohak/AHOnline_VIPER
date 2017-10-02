//
//  APIHelper.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import Foundation
import Alamofire

typealias TupleRequest = (HTTPMethod, String, [String: Any]?, Bool)

//let kPath       = "http://buyonline-arohak.c9users.io/"
//let kPath       = "https://ahonline.herokuapp.com/"
let kPath       = "http://localhost:3000/api/"
let kVersion    = "v1"
let kURL        = kPath + kVersion

struct APIHelper {
    
    static var poolRequests = Array<TupleRequest>()
    static let network      = NetworkReachabilityManager()
    
    //MARK: - API Config -
    static let baseURL      = Config.getApiBaseUrl()
    static let key          = Config.getApiKey()
    
    //MARK: - Public Methods -
    static func startListeningNetwork() {
        network?.startListening()
        
        network?.listener = { status in
            switch status {
            case .notReachable:
                showAlertWithSettingsAndRetry()
                break
                
            case .reachable(.ethernetOrWiFi), .reachable(.wwan):
                hideAlertWithSettingsRetry()
                _ = retryRequests()
                break

            case .unknown:
                break
            }
        }
    }
    
    static func request(_ method: HTTPMethod,
                        _ url: String,
                        _ parameters: [String: Any]? = nil,
                        _ showProgress: Bool = true) -> Observable<JSON?>
    {
        return Observable.create { observer in
            
            // check internate connection
            guard NetworkReachabilityManager()!.isReachable else {
                if poolRequests.filter({ $0.1 == url }).count == 0 {
                    poolRequests.append(method, url, parameters, showProgress)
                }
                
                showAlertWithSettingsAndRetry()
                
                return Disposables.create { }
            }
            
            if poolRequests.count > 0 {
                poolRequests.removeAll()
            }
            
            if showProgress { UIHelper.showSpinner() }
            
            let URL = kURL + url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            Alamofire.request(URL, method: method,
                              parameters: parameters,
                              encoding: URLEncoding.default,
                              headers: ["locale" : Preferences.getAppLanguage() == "en" ? "eu" : Preferences.getAppLanguage()])
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(self.handleResponse(response: data))
                    case .failure(let error):
                        UIHelper.showHUD(message: error.localizedDescription)
                        observer.onError(error)
                    }
                    
                    if showProgress { UIHelper.hideSpinner() }
            }
            
            return Disposables.create { }
        }
    }
    
    //MARK: - Private Methods -
    private static func handleResponse(response: Any) -> JSON? {
        let data = JSON(response)
        let result = Result(data: data["result"])
        
        switch result.status {
        case "SUCCESS":
            if !result.message.isEmpty { UIHelper.showHUD(message: result.message) }
            return data
             
        default:
            UIHelper.showHUD(message: result.message)
            return nil
        }
    }
    
    private static func showAlertWithSettingsAndRetry() {
        let alertController = UIAlertController(title: "oops".localizedString, message: "no_internet".localizedString, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "settings".localizedString, style: .default) { _ in
            guard let settingsUrl = NSURL(string:UIApplicationOpenSettingsURLString) as URL? else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, options: [:]) { _ in }
                } else {
                    // Fallback on earlier versions
                }
            }
        })
        alertController.addAction(UIAlertAction(title: "retry".localizedString, style: .default) { _ in
            _ = self.retryRequests()
            if poolRequests.count == 0 && !NetworkReachabilityManager()!.isReachable {
                showAlertWithSettingsAndRetry()
            }
        })
        Wireframe.present(alertController)
    }
    
    private static func hideAlertWithSettingsRetry() {
        Wireframe.dismiss()
    }
    
    private static func retryRequests() -> (Observable<JSON?>)? {
        for tuple in poolRequests {
            return self.request(tuple.0, tuple.1, tuple.2, tuple.3)
        }
        
        return nil
    }
}
