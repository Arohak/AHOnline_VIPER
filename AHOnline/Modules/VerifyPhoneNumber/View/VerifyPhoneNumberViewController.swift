//
//  VerifyPhoneNumberViewController.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class VerifyPhoneNumberViewController -
class VerifyPhoneNumberViewController: UIViewController {

    var output: VerifyPhoneNumberViewOutput!
    
    internal var verifyPhoneNumberView = VerifyPhoneNumberView()
    internal var tuple: ([String:String], [String])!
    internal var selectedCountry        = "Armenia"
    internal var countryCode            = "+374"
    internal var code                   = "_AM"
    internal var mobileNumber           = "+374"

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "verify".localizedString
        navigationItem.setRightBarButton(UIBarButtonItem(title: "close".localizedString, style: .plain, target: self, action: #selector(closeAction)), animated: true)

        baseConfig()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        verifyPhoneNumberView.phoneTextField.becomeFirstResponder()
    }
    
    // MARK: - Private Method -
    private func baseConfig() {
        self.view = verifyPhoneNumberView
        
        verifyPhoneNumberView.phoneTextField.text = mobileNumber
        verifyPhoneNumberView.countryCodeButton.setBackgroundImage(UIImage(named: code), for: .normal)

        verifyPhoneNumberView.phoneTextField.delegate = self
        verifyPhoneNumberView.pinTextField.delegate = self
        verifyPhoneNumberView.countryCodeButton.addTarget(self, action: #selector(countryCodeButtonAction), for: .touchUpInside)
        verifyPhoneNumberView.sendButton.addTarget(self, action: #selector(sendButtonAction), for: .touchUpInside)
        verifyPhoneNumberView.acceptButton.addTarget(self, action: #selector(acceptButtonAction), for: .touchUpInside)
        
        tuple = getCountriesFromNSLocale(phone: countryCode)
        
        selectedCountry = Utils.countryFromLocale()
    }
    
    private func getCountriesFromNSLocale(phone: String) -> ([String:String], [String]) {
        var dictionary = Dictionary<String,String>()
        for countryCode in Locale.isoRegionCodes {
            let identifier = Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue : countryCode])
            if let country = (Locale.current as NSLocale).displayName(forKey: NSLocale.Key.identifier, value: identifier) {
                dictionary[country] = identifier
            }
        }

        let keys = Array(dictionary.keys).sorted(by: <)
        
        return (dictionary, keys)
    }

    //MARK: - Actions -
    func closeAction() {
       output.closeButtonClicked()
    }
    
    func countryCodeButtonAction() {
        let actionSheet = ContryCodeActionSheetPickerViewController(dictionary: tuple.0, keys: tuple.1) { value in
            self.verifyPhoneNumberView.countryCodeButton.setBackgroundImage(UIImage(named: self.tuple.0[value]!), for: .normal)
            self.verifyPhoneNumberView.phoneTextField.text = codes[self.tuple.0[value]!]
            self.selectedCountry = value
        }
        actionSheet.pickerView.selectRow(tuple.1.index(of: selectedCountry)!, inComponent: 0, animated: true)
        
        output.presentViewController(vc: actionSheet)
    }
    
    func sendButtonAction() {
        if UIHelper.isValidPhoneTextField(field: verifyPhoneNumberView.phoneTextField) {
            output.sendButtonClicked(number: verifyPhoneNumberView.phoneTextField.text!)
        }
    }
    
    func acceptButtonAction() {
        if UIHelper.isValidTextField(field: verifyPhoneNumberView.pinTextField) {
            output.acceptButtonClicked(pin: verifyPhoneNumberView.pinTextField.text!)
        }
    }
}

//MARK: - extension for VerifyPhoneNumberViewInput -
extension VerifyPhoneNumberViewController: VerifyPhoneNumberViewInput {

    func enableSendButton() {
        verifyPhoneNumberView.phoneTextField.isEnabled = false
        verifyPhoneNumberView.sendButton.isEnabled = false
        verifyPhoneNumberView.pinTextField.isEnabled = true
        verifyPhoneNumberView.acceptButton.isEnabled = true
    }
}

//MARK: - extension for UITextFieldDelegate -
extension VerifyPhoneNumberViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case verifyPhoneNumberView.phoneTextField:
            let phoneCode = textField.text! + string
            let phone = phoneCode.hasPrefix("00") ? phoneCode.replacingOccurrences(of: "00", with: "+") : phoneCode
            if let identifier = (codes as NSDictionary).allKeys(for: phone).first as? String {
                verifyPhoneNumberView.countryCodeButton.setBackgroundImage(UIImage(named: identifier), for: .normal)
                if let tuple = tuple {
                    let value = (tuple.0 as NSDictionary).allKeys(for: identifier).first as! String
                    selectedCountry = value
                }
            }
            
        default:
            break
        }
        
        return true
    }
}
