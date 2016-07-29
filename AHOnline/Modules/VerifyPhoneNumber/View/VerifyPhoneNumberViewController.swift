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
    
    var verifyPhoneNumberView = VerifyPhoneNumberView()
    private var tuple: ([String:String], [String])!
    private var selectedCountry = "Armenia"
    private var countryCode     = "+374"
    private var code            = "_AM"
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "verify".localizedString
        navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "close".localizedString, style: .Plain, target: self, action: #selector(closeAction)), animated: true)

        output.viewIsReady()
        baseConfig()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        verifyPhoneNumberView.phoneTextField.becomeFirstResponder()
    }
    
    // MARK: - Private Method -
    private func baseConfig() {
        self.view = verifyPhoneNumberView
        
        verifyPhoneNumberView.phoneTextField.text = countryCode
        verifyPhoneNumberView.countryCodeButton.setBackgroundImage(UIImage(named: code), forState: .Normal)

        verifyPhoneNumberView.phoneTextField.delegate = self
        verifyPhoneNumberView.pinTextField.delegate = self
        verifyPhoneNumberView.countryCodeButton.addTarget(self, action: #selector(countryCodeButtonAction), forControlEvents: .TouchUpInside)
        verifyPhoneNumberView.sendButton.addTarget(self, action: #selector(sendButtonAction), forControlEvents: .TouchUpInside)
        verifyPhoneNumberView.acceptButton.addTarget(self, action: #selector(acceptButtonAction), forControlEvents: .TouchUpInside)
        
        self.tuple = getCountriesFromNSLocale(countryCode)
    }
    
    private func getCountriesFromNSLocale(phone: String) -> ([String:String], [String]) {
        var dictionary = Dictionary<String,String>()
        for countryCode in NSLocale.ISOCountryCodes() {
            let identifier = NSLocale.localeIdentifierFromComponents([NSLocaleCountryCode : countryCode])
            if let country = NSLocale.currentLocale().displayNameForKey(NSLocaleIdentifier, value: identifier) {
                dictionary[country] = identifier
            }
        }
        let keys = Array(dictionary.keys).sort(<)
        
        return (dictionary, keys)
    }
    
    //MARK: - Actions -
    func closeAction() {
       output.closeButtonClicked()
    }
    
    func countryCodeButtonAction() {
        let actionSheet = ContryCodeActionSheetPickerViewController(dictionary: tuple.0, keys: tuple.1) { value in
            self.verifyPhoneNumberView.countryCodeButton.setBackgroundImage(UIImage(named: self.tuple.0[value]!), forState: .Normal)
            self.verifyPhoneNumberView.phoneTextField.text = codes[self.tuple.0[value]!]
            self.selectedCountry = value
        }
        actionSheet.pickerView.selectRow(tuple.1.indexOf(selectedCountry)!, inComponent: 0, animated: true)
        
        output.presentViewController(actionSheet)
    }
    
    func sendButtonAction() {
        if UIHelper.isValidTextField(verifyPhoneNumberView.phoneTextField) {
            output.sendButtonClicked(verifyPhoneNumberView.phoneTextField.text!)
        }
    }
    
    func acceptButtonAction() {
        if UIHelper.isValidTextField(verifyPhoneNumberView.pinTextField) {
            output.acceptButtonClicked(verifyPhoneNumberView.pinTextField.text!)
        }
    }
}

//MARK: - extension for VerifyPhoneNumberViewInput -
extension VerifyPhoneNumberViewController: VerifyPhoneNumberViewInput {
    
    func setupInitialState() {

    }
}

//MARK: - extension for UITextFieldDelegate -
extension VerifyPhoneNumberViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case verifyPhoneNumberView.phoneTextField:
            let phoneCode = textField.text! + string
            let phone = phoneCode.hasPrefix("00") ? phoneCode.stringByReplacingOccurrencesOfString("00", withString: "+") : phoneCode
            if let identifier = (codes as NSDictionary).allKeysForObject(phone).first as? String {
                verifyPhoneNumberView.countryCodeButton.setBackgroundImage(UIImage(named: identifier), forState: .Normal)
                if let tuple = tuple {
                    let value = (tuple.0 as NSDictionary).allKeysForObject(identifier).first as! String
                    selectedCountry = value
                }
            }
            
        default:
            break
        }
        
        return true
    }
}