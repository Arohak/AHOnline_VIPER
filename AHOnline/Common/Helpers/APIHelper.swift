//
//  APIHelper.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import Alamofire

let apiHelper = APIHelper.sharedInstance

let HTTPS   = "http://"
let IP      = "localhost"
let PORT    = ":3000/"
let AHO     = "api/v1/"
let baseURL = HTTPS + IP + PORT + AHO
//let baseURL = "http://buyonline-arohak.c9users.io/api/v1/"

class APIHelper {
    
    static let sharedInstance = APIHelper()
    
    //MARK: - Request -
    func request(method: HTTPMethod,
                        url: String,
                        parameters: [String: Any]? = nil,
                        showProgress: Bool = true)
                        -> Observable<JSON>
    {
        return Observable.create { observer in
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            if showProgress { UIHelper.showSpinner() }
            
            let URL = baseURL + url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            Alamofire.request(URL, method: method, parameters: parameters, encoding: URLEncoding.default, headers: ["locale" : Preferences.getAppLanguage()])
                .responseJSON { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(self.handleResponse(response: data))
                    case .failure(let error):
                        UIHelper.showHUD(message: error.localizedDescription)
                        observer.onError(error)
                    }
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if showProgress { UIHelper.hideSpinner() }
            }
            
            return Disposables.create { }
        }
    }
    
    func requestNSData(method: HTTPMethod,
                    url: String,
                    parameters: [String: Any]? = nil,
                    showProgress: Bool = true)
        -> Observable<Data>
    {
        return Observable.create { observer in
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            if showProgress { UIHelper.showSpinner() }
            
            let URL = baseURL + url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            Alamofire.request(URL, method: method, parameters: parameters, encoding: URLEncoding.default)
                .responseData { response in
                    observer.onNext(response.data!)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    if showProgress { UIHelper.hideSpinner() }
            }
            
            return Disposables.create { }
        }
    }
    
    //MARK: - Private Methods -
    private func handleResponse(response: Any) -> JSON {
        let data = JSON(response)
        let result = Result(data: data["result"])
        
        switch result.status {
        case "SUCCESS":
            if !result.message.isEmpty { UIHelper.showHUD(message: result.message) }
            return data
            
        case "USER_SESSION_EXPIRED", "USER_SESSION_NOT_FOUND":
            if !result.message.isEmpty { UIHelper.showHUD(message: result.message) }
            Wireframe.start()
            return JSON.null
            
        case "CERTIFICATE_NOT_FOUND":
            if !result.message.isEmpty { UIHelper.showHUD(message: result.message) }
            return JSON.null
            
        default:
            UIHelper.showHUD(message: result.message)
            return JSON.null
        }
    }
    
    private func handleError(response: AnyObject) {
        let data = JSON(response)
        let number = data.intValue
        var error = "Error"
        switch number {
        case -1:
            error = ""
        case -2:
            error = ""
        case -3:
            error = ""
        default:
            break
        }
        UIHelper.showHUD(message: error)
    }
}
