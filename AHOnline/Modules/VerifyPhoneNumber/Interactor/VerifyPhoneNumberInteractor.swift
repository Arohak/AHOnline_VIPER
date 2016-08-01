//
//  VerifyPhoneNumberInteractor.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class VerifyPhoneNumberInteractor -
class VerifyPhoneNumberInteractor {

    weak var output: VerifyPhoneNumberInteractorOutput!
    
    var user: User {
        return DBManager.getUser()!
    }
}

//MARK: - extension for VerifyPhoneNumberInteractorInput -
extension VerifyPhoneNumberInteractor: VerifyPhoneNumberInteractorInput {
    
    func send(number: String) {
        let json = JSON([
            "id"            : user.id,
            "mobile_number" : number])
        
        _ = APIManager.sendMobileNumber(json)
            .subscribe(onNext: { result in
                if result != nil {
                   self.output.sendPhoneIsReady()
                }
            })
    }
    
    func accept(pin: String) {
        _ = APIManager.verifyMobileNumber(pin)
            .subscribe(onNext: { result in
                if result != nil {
                    let userInfo = UserInfo(data: result["data"])
                    DBManager.updateUser(userInfo)
                    
                    self.output.acceptDataIsReady()
                }
            })
    }
}