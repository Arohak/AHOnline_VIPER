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
    
    private var manageAddressView = ManageAddressView()
    private var countries: [String] = []
    private var selectedCountry = "Armenia"
    private var cities: [String] = []
    private var selectedCity = ""

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "manage_address".localizedString
        navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "close".localizedString, style: .Plain, target: self, action: #selector(closeAction)), animated: true)
        
        output.viewIsReady()
        baseConfig()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        manageAddressView.addressTextField.becomeFirstResponder()
    }
    
    // MARK: - Private Method -
    private func baseConfig() {
        self.view = manageAddressView
        
        manageAddressView.countryButton.setTitle("Armenia", forState: .Normal)
        manageAddressView.saveButton.setTitle("save".localizedString, forState: .Normal)

        manageAddressView.addressTextField.delegate = self
        manageAddressView.countryButton.addTarget(self, action: #selector(countryButtonAction), forControlEvents: .TouchUpInside)
        manageAddressView.cityButton.addTarget(self, action: #selector(cityButtonAction), forControlEvents: .TouchUpInside)
        manageAddressView.saveButton.addTarget(self, action: #selector(saveButtonAction), forControlEvents: .TouchUpInside)
        
        updateView()
    }
    
    private func updateView() {
        manageAddressView.cityButton.hidden = !(selectedCountry == "Armenia")
        manageAddressView.cityTextField.hidden = !manageAddressView.cityButton.hidden
        manageAddressView.cityTextField.text = ""
    }
    
    //MARK: - Actions -
    func closeAction() {
        output.closeButtonClicked()
    }
    
    func countryButtonAction() {
        let actionSheet = ActionSheetPickerViewController(values: countries) { value in
            self.manageAddressView.countryButton.setTitle(value, forState: .Normal)
            self.selectedCountry = value
            self.updateView()
        }
        actionSheet.pickerView.selectRow(countries.indexOf(selectedCountry)!, inComponent: 0, animated: true)
        
        output.presentViewController(actionSheet)
    }
    
    func cityButtonAction() {
        let actionSheet = ActionSheetPickerViewController(values: cities) { value in
            self.manageAddressView.cityButton.setTitle(value, forState: .Normal)
            self.selectedCity = value
        }
        actionSheet.pickerView.selectRow(cities.indexOf(selectedCity)!, inComponent: 0, animated: true)
        
        output.presentViewController(actionSheet)
    }
    
    func saveButtonAction() {
        
    }
}

//MARK: - extension for ManageAddressViewInput -
extension ManageAddressViewController: ManageAddressViewInput {
    
    func setupInitialState(countries: [String], cities: [String]) {
        self.countries = countries
        self.cities = cities
        
        selectedCity = cities[0]
        manageAddressView.cityButton.setTitle(selectedCity, forState: .Normal)
    }
}

//MARK: - extension for UITextFieldDelegate -
extension ManageAddressViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

