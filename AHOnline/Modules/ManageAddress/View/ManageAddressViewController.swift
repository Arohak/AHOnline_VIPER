//
//  ManageAddressViewController.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class ManageAddressViewController -
class ManageAddressViewController: UIViewController {

    var output: ManageAddressViewOutput!
    
    internal var manageAddressView                   = ManageAddressView()
    internal var countries: [String]                 = []
    internal var citiesTuple: [(String, String)]     = []
    internal var selectedCountry                     = ""
    internal var selectedCity                        = ""
    internal var selectedAlias                       = ""
    internal var selectedAddress                     = ""
    internal var user: User?
    internal var cities: [String] {
        var temp = [String]()
        for item in citiesTuple { temp.append(item.0) }
        
        return temp
    }

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "delivery_address".localizedString
        navigationItem.setRightBarButton(UIBarButtonItem(title: "close".localizedString, style: .plain, target: self, action: #selector(closeAction)), animated: true)
        
        output.viewIsReady()
        baseConfig()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manageAddressView.addressFieldView.textField.becomeFirstResponder()
    }
    
    // MARK: - internal Method -
    internal func baseConfig() {
        self.view = manageAddressView
        
        manageAddressView.cityFieldView.textField.delegate = self
        manageAddressView.addressFieldView.textField.delegate = self
        manageAddressView.countryView.button.addTarget(self, action: #selector(countryButtonAction), for: .touchUpInside)
        manageAddressView.cityView.button.addTarget(self, action: #selector(cityButtonAction), for: .touchUpInside)
        manageAddressView.saveButton.addTarget(self, action: #selector(saveButtonAction), for: .touchUpInside)
    }
    
    internal func updateView() {
        manageAddressView.cityView.isHidden = !(selectedCountry == "Armenia" && cities.count > 0)
        manageAddressView.cityFieldView.isHidden = !manageAddressView.cityView.isHidden
        manageAddressView.cityFieldView.setValue(title: "")
    }
    
    internal func isValidInputParams() -> Bool {
        var isValid = true
        if manageAddressView.cityView.isHidden {
            if !UIHelper.isValidTextField(field: manageAddressView.cityFieldView.textField) { isValid = false }
        }
        if !UIHelper.isValidTextField(field: manageAddressView.addressFieldView.textField) { isValid = false }
        
        return isValid
    }
    
    //MARK: - Actions -
    func closeAction() {
        output.closeButtonClicked()
    }
    
    func countryButtonAction() {
        let actionSheet = ActionSheetPickerViewController(values: countries) { value in
            self.manageAddressView.countryView.setValue(title: value)
            self.selectedCountry = value
            self.updateView()
        }
        actionSheet.pickerView.selectRow(countries.index(of: selectedCountry)!, inComponent: 0, animated: true)
        
        output.presentViewController(vc: actionSheet)
    }
    
    func cityButtonAction() {
        let actionSheet = ManageAddressActionSheetPickerViewController(values: citiesTuple) { value in
            self.manageAddressView.cityView.setValue(title: value.0)
            self.selectedCity = value.0
            self.selectedAlias = value.1
        }
        if cities.count > 0 {
            let index = cities.index(of: selectedCity) != nil ? cities.index(of: selectedCity)! : 0
            actionSheet.pickerView.selectRow(index, inComponent: 0, animated: true)
        }
        output.presentViewController(vc: actionSheet)
    }
    
    func saveButtonAction() {
        if isValidInputParams() {
            let json = JSON([
                "country"   : manageAddressView.countryView.titleLabel.text!,
                "city"      : manageAddressView.cityView.isHidden ? manageAddressView.cityFieldView.textField.text! : manageAddressView.cityView.titleLabel.text!,
                "alias"     : manageAddressView.cityView.isHidden ? "" : selectedAlias,
                "address"   : manageAddressView.addressFieldView.textField.text!]
            )
            
            output.saveButtonClicked(json: json)
        }
    }
}

//MARK: - extension for ManageAddressViewInput -
extension ManageAddressViewController: ManageAddressViewInput {
    
    func setupInitialState(user: User?, countries: [String], citiesTuple: [(String, String)]) {
        self.user = user
        self.countries = countries
        self.citiesTuple = citiesTuple
        
        if let address = user?.address {
            selectedCountry = address.country
            selectedCity = address.city
            selectedAlias = address.alias
            selectedAddress = address.add
        } else {
            selectedCountry = "Armenia"
          if cities.count > 0 {
            selectedCity = citiesTuple.first!.0
            selectedAlias = citiesTuple.first!.1
            }
        }
        
        manageAddressView.countryView.setValue(title: selectedCountry)
        manageAddressView.cityView.setValue(title: selectedCity)
        manageAddressView.addressFieldView.setValue(title: selectedAddress)
        
        updateView()
    }
}

//MARK: - extension for UITextFieldDelegate -
extension ManageAddressViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case manageAddressView.cityFieldView.textField:
            manageAddressView.addressFieldView.textField.becomeFirstResponder()
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
}

