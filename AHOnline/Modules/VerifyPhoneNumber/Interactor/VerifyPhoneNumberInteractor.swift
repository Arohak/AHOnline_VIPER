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
        return DBHelper.getUser()!
    }
}

//MARK: - extension for VerifyPhoneNumberInteractorInput -
extension VerifyPhoneNumberInteractor: VerifyPhoneNumberInteractorInput {
    
    func send(number: String) {
        _ = UserEndpoint.sendPhone("\(user.id)", number: number)
            .subscribe(onNext: { result in
                if result != nil {
                   self.output.sendPhoneIsReady()
                }
            })
    }
    
    func accept(pin: String) {
        _ = UserEndpoint.verifyPhone(pin)
            .subscribe(onNext: { result in
                if let result = result {
                    let userInfo = UserInfo(data: result["data"])
                    DBHelper.updateUser(userInfo: userInfo)
                    
                    self.output.acceptDataIsReady()
                }
            })
    }
}
