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
    
    private let dict = ["English" : "eu", "Русский" : "ru", "Հայերեն" : "hy"]
    private let languages = ["English", "Русский", "Հայերեն"]

    var user: User? {
        return DBManager.getUser()
    }
}

//MARK: - extension for AccountInteractorInput -
extension AccountInteractor: AccountInteractorInput {
    
    func getUserData() {
        if let user = user { output.userDataIsReady(user) }
    }
    
    func manageSettings() {
        let actionSheet = UIAlertController(title: "settings".localizedString, message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "cancel".localizedString, style: .Cancel, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "manage_address".localizedString, style: .Default, handler: { _ in
            let vc = ManageAddressViewController()
            _ = ManageAddressModuleInitializer(viewController: vc)
            self.output.modalPresentViewController(UINavigationController(rootViewController: vc))
        }))
        
        actionSheet.addAction(UIAlertAction(title: "manage_number".localizedString, style: .Default, handler: { _ in
            let vc = VerifyPhoneNumberViewController()
            if let user = self.user where !user.phone.isEmpty {
               vc.mobileNumber = user.phone
            }
            _ = VerifyPhoneNumberModuleInitializer(viewController: vc)
            self.output.modalPresentViewController(UINavigationController(rootViewController: vc))
        }))
        
        output.presentViewController(actionSheet)
    }
    
    func manageLanguage() {
        var selectedLanguage = (dict as NSDictionary).allKeysForObject(Preferences.getAppLanguage()).first! as! String
        
        let actionSheet = LanguageActionSheetPickerViewController(languages: languages) { language, index in
            selectedLanguage = language
            Preferences.saveAppLanguage(self.dict[language]!)
            
            self.output.changeLanguageIsReady()
        }
        actionSheet.pickerView.selectRow(languages.indexOf(selectedLanguage)!, inComponent: 0, animated: true)
        
        output.presentViewController(actionSheet)
    }
}