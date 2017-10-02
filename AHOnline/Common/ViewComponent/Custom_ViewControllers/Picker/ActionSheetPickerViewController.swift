//
//  ActionSheetPickerViewController.swift
//  AHMusic
//
//  Created by Ara Hakobyan on 5/19/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - ActionSheetPickerViewController -
class ActionSheetPickerViewController: UIAlertController {
    
    var pickerView: ManagePickerView!
    
    init(values: [String], callback: @escaping PickerCallback) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = "\n\n\n\n\n\n"
        addAction(UIAlertAction(title: "close".localizedString, style: .cancel) { _ in })
        
        pickerView = ManagePickerView(values: values, callback: callback)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pickerView)
        pickerView.autoPinEdge(toSuperviewEdge: .top)
        pickerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 60)
        pickerView.autoAlignAxis(toSuperviewAxis: .vertical)
        pickerView.autoSetDimension(.height, toSize: Screen.height*0.25)
    }
}

//MARK: - ManageAddressActionSheetPickerViewController -
class ManageAddressActionSheetPickerViewController: UIAlertController {
    
    var pickerView: ManageAddressPickerView!
    
    init(values: [(String, String)], callback: @escaping ManageAddressPickerCallback) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = "\n\n\n\n\n\n"
        addAction(UIAlertAction(title: "close".localizedString, style: .cancel) { _ in })
        
        pickerView = ManageAddressPickerView(values: values, callback: callback)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pickerView)
        pickerView.autoPinEdge(toSuperviewEdge: .top)
        pickerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 60)
        pickerView.autoAlignAxis(toSuperviewAxis: .vertical)
        pickerView.autoSetDimension(.height, toSize: Screen.height*0.25)
    }
}

//MARK: - ContryCodeActionSheetPickerViewController -
class ContryCodeActionSheetPickerViewController: UIAlertController {

    var pickerView: ContryCodePickerView!
    
    init(values: [String], callback: @escaping PickerCallback) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = "\n\n\n\n\n\n"
        addAction(UIAlertAction(title: "close".localizedString, style: .cancel) { _ in })
        
        pickerView = ContryCodePickerView(values: values, callback: callback)
    }
    
    init(dictionary: [String : String], keys: [String], callback: @escaping PickerCallback) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = "\n\n\n\n\n\n"
        addAction(UIAlertAction(title: "close".localizedString, style: .cancel) { _ in })
        
        pickerView = ContryCodePickerView(dictionary: dictionary, keys: keys, callback: callback)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pickerView)
        pickerView.autoPinEdge(toSuperviewEdge: .top)
        pickerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 60)
        pickerView.autoAlignAxis(toSuperviewAxis: .vertical)
        pickerView.autoSetDimension(.height, toSize: Screen.height*0.25)
    }
}

//MARK: - DeliveryActionSheetPickerViewController -
class DeliveryActionSheetPickerViewController: UIAlertController {
    
    var pickerView: DeliveryPickerView!
    
    init(deliveries: [Delivery], callback: @escaping DeliveryPickerCallback) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = "\n\n\n\n\n\n"
        addAction(UIAlertAction(title: "close".localizedString, style: .cancel) { _ in })
        
        pickerView = DeliveryPickerView(deliveries: deliveries, callback: callback)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pickerView)
        pickerView.autoPinEdge(toSuperviewEdge: .top)
        pickerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 60)
        pickerView.autoAlignAxis(toSuperviewAxis: .vertical)
        pickerView.autoSetDimension(.height, toSize: Screen.height*0.25)
    }
}

//MARK: - DistanceActionSheetPickerViewController -
class DistanceActionSheetPickerViewController: UIAlertController {
    
    var pickerView: DistancePickerView!
    
    init(distances: [Double], callback: @escaping DistancePickerCallback) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = "\n\n\n\n\n\n"
        addAction(UIAlertAction(title: "close".localizedString, style: .cancel) { _ in })
        
        pickerView = DistancePickerView(distances: distances, callback: callback)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pickerView)
        pickerView.autoPinEdge(toSuperviewEdge: .top)
        pickerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 60)
        pickerView.autoAlignAxis(toSuperviewAxis: .vertical)
        pickerView.autoSetDimension(.height, toSize: Screen.height*0.25)
    }
}

//MARK: - LanguageActionSheetPickerViewController -
class LanguageActionSheetPickerViewController: UIAlertController {
    
    var callback: LanguagePickerCallback?
    var pickerView: LanguagePickerView!
    
    init(languages: [String], callback: @escaping LanguagePickerCallback) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = "\n\n\n\n\n\n\n\n"
        self.callback = callback
        
        addAction(UIAlertAction(title: "cancel".localizedString, style: .cancel) { _ in })
        addAction(UIAlertAction(title: "save".localizedString, style: .destructive) { _ in
            let index = self.pickerView.selectedRow(inComponent: 0)
            let language = languages[index]
            callback(language, index)
            })
        
        pickerView = LanguagePickerView(languages: languages)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pickerView)
        pickerView.autoPinEdge(toSuperviewEdge: .top)
        pickerView.autoPinEdge(toSuperviewEdge: .bottom, withInset: 120)
        pickerView.autoAlignAxis(toSuperviewAxis: .vertical)
        pickerView.autoSetDimension(.height, toSize: Screen.height*0.25)
    }
}
