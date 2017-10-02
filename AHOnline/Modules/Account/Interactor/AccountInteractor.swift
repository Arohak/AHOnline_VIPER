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
    
    internal let dict = ["English" : "en", "Русский" : "ru", "Հայերեն" : "hy"]
    internal let languages = ["English", "Русский", "Հայերեն"]

    var user: User? {
        return DBHelper.getUser()
    }
}

//MARK: - extension for AccountInteractorInput -
extension AccountInteractor: AccountInteractorInput {
    
    func getUserData() {
        if let user = user { output.userDataIsReady(user: user) }
    }
    
    func manageSettings() {
        let actionSheet = UIAlertController(title: "settings".localizedString, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "close".localizedString, style: .cancel, handler: nil))
        
        actionSheet.addAction(UIAlertAction(title: "manage_address".localizedString, style: .default, handler: { _ in
            let vc = ManageAddressViewController()
            _ = ManageAddressModuleInitializer(viewController: vc)
            self.output.modalPresentViewController(vc: UINavigationController(rootViewController: vc))
        }))
        
        actionSheet.addAction(UIAlertAction(title: "manage_number".localizedString, style: .default, handler: { _ in
            let vc = VerifyPhoneNumberViewController()
            if let user = self.user , !user.phone.isEmpty {
               vc.mobileNumber = user.phone
            }
            _ = VerifyPhoneNumberModuleInitializer(viewController: vc)
            self.output.modalPresentViewController(vc: UINavigationController(rootViewController: vc))
        }))
        
        output.presentViewController(vc: actionSheet)
    }
    
    func manageLanguage() {
        var selectedLanguage = (dict as NSDictionary).allKeys(for: Preferences.getAppLanguage()).first! as! String
        
        let actionSheet = LanguageActionSheetPickerViewController(languages: languages) { language, index in
            selectedLanguage = language
            Preferences.saveAppLanguage(lng: self.dict[language]!)
            
            self.output.changeLanguageIsReady()
        }
        actionSheet.pickerView.selectRow(languages.index(of: selectedLanguage)!, inComponent: 0, animated: true)
        
        output.presentViewController(vc: actionSheet)
    }
}
