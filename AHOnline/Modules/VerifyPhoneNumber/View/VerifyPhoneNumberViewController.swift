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
    
    private var verifyPhoneNumberView = VerifyPhoneNumberView()

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "verify".localizedString
        navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "skip".localizedString, style: .Plain, target: self, action: #selector(skipAction)), animated: true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name:UIKeyboardWillChangeFrameNotification, object: nil)

        output.viewIsReady()
        baseConfig()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(UIKeyboardWillChangeFrameNotification)
    }
    
    // MARK: - Private Method -
    private func baseConfig() {
        self.view = verifyPhoneNumberView
        
//        verifyPhoneNumberView.phoneTextField.becomeFirstResponder()
        verifyPhoneNumberView.phoneTextField.text = "+374"
        verifyPhoneNumberView.countryCodeButton.setBackgroundImage(UIImage(named: "_AM.png"), forState: .Normal)
        
        verifyPhoneNumberView.phoneTextField.delegate = self
        verifyPhoneNumberView.pinTextField.delegate = self
        verifyPhoneNumberView.countryCodeButton.addTarget(self, action: #selector(countryCodeButtonAction), forControlEvents: .TouchUpInside)
        verifyPhoneNumberView.sendButton.addTarget(self, action: #selector(sendButtonAction), forControlEvents: .TouchUpInside)
        verifyPhoneNumberView.acceptButton.addTarget(self, action: #selector(acceptButtonAction), forControlEvents: .TouchUpInside)
    }
    
    private func updateLocalizedStrings() {
        verifyPhoneNumberView.phoneTextField.placeholder =    "phone".localizedString
        verifyPhoneNumberView.pinTextField.placeholder =      "pin".localizedString
        verifyPhoneNumberView.sendButton.setTitle("send".localizedString, forState: .Normal)
        verifyPhoneNumberView.acceptButton.setTitle("accept".localizedString, forState: .Normal)
    }
    
    private func configNSLocale(phone: String) -> ([String:String], [String], Int) {
        var dictionary = Dictionary<String,String>()
        for countryCode in NSLocale.ISOCountryCodes() {
            let identifier = NSLocale.localeIdentifierFromComponents([NSLocaleCountryCode : countryCode])
            if let country = NSLocale.currentLocale().displayNameForKey(NSLocaleIdentifier, value: identifier) {
                dictionary[country] = identifier
            }
        }
        let keys = Array(dictionary.keys).sort(<)
        
        var row = 0
        let phoneCode = phone.hasPrefix("00") ? phone.stringByReplacingOccurrencesOfString("00", withString: "+") : phone
        if let identifier = (codes as NSDictionary).allKeysForObject(phoneCode).first as? String {
            if let country = (dictionary as NSDictionary).allKeysForObject(identifier).first as? String {
                if let index = keys.indexOf(country) { row = index }
            }
        }
        
        return (dictionary, keys, row)
    }
    
    //MARK: - Actions -
    func skipAction() {
       output.dismissViewController()
    }
    
    func countryCodeButtonAction() {
        let tuple = configNSLocale(verifyPhoneNumberView.phoneTextField.text!)
        
        let actionSheet = ContryCodeActionSheetPickerViewController(dictionary: tuple.0, keys: tuple.1) { value in
            self.verifyPhoneNumberView.countryCodeButton.setBackgroundImage(UIImage(named: value), forState: .Normal)
            self.verifyPhoneNumberView.phoneTextField.text = codes[value]
        }
        
        actionSheet.pickerView.selectRow(tuple.2, inComponent: 0, animated: true)
        
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
    
    //MARK: - Keyboard notifications -
    func keyboardWillChangeFrame(notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
            let animationDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber) as! NSTimeInterval
            let y = keyboardFrame.origin.y
            
            UIView.animateWithDuration(animationDuration, animations: { _ in
//                self.verifyPhoneNumberView.heightScrollViewConstraint.constant = y - 64
//                let point = CGPoint(x: 0, y: CGRectGetMaxY(self.verifyPhoneNumberView.pinTextField.frame) + VE_OFFSET)
//                self.verifyPhoneNumberView.scrollView.setContentOffset(point, animated: true)
                self.view.layoutIfNeeded()
            })
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
            }
            
        default:
            break
        }
        
        return true
    }
}