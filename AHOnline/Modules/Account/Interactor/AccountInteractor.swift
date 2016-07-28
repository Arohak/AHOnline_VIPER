//
//  AccountInteractor.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class AccountInteractor -
class AccountInteractor {
    
    weak var output: AccountInteractorOutput!
    
    private let languages = ["english".localizedString, "russian".localizedString, "armenian".localizedString]
    private var selectedLanguage = "english".localizedString

    func getUser() -> User {
        return DBManager.getUser()
    }
}

//MARK: - extension for AccountInteractorInput -
extension AccountInteractor: AccountInteractorInput {
    
    func getUserData() {
        let user = getUser()
        output.userDataIsReady(user)
    }
    
    func manageSettings() {
        let actionSheet = UIAlertController(title: "Settings".localizedString, message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel".localizedString, style: .Cancel, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "Manage Delivery Address".localizedString, style: .Default, handler: { _ in
            let vc = ManageAddressViewController()
            _ = ManageAddressModuleInitializer(viewController: vc)
            self.output.modalPresentViewController(UINavigationController(rootViewController: vc))
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Manage Phone Number".localizedString, style: .Default, handler: { _ in
            let user = self.getUser()
            let vc = VerifyPhoneNumberViewController()
            if !user.phone.isEmpty {
               vc.verifyPhoneNumberView.phoneTextField.text = user.phone
            }
            _ = VerifyPhoneNumberModuleInitializer(viewController: vc)
            self.output.modalPresentViewController(UINavigationController(rootViewController: vc))
        }))
        
        output.presentViewController(actionSheet)
    }
    
    func manageLanguage() {
        let actionSheet = LanguageActionSheetPickerViewController(languages: languages) { language, index in
            self.selectedLanguage = language
        }
        actionSheet.pickerView.selectRow(languages.indexOf(selectedLanguage)!, inComponent: 0, animated: true)
        
        output.presentViewController(actionSheet)
    }
}