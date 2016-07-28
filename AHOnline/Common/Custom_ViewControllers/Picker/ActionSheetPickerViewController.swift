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
    
    init(values: [String], callback: PickerCallback) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = "\n\n\n\n\n\n"
        addAction(UIAlertAction(title: "cancel".localizedString, style: .Cancel) { _ in })
        
        pickerView = ManagePickerView(values: values, callback: callback)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pickerView)
        pickerView.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        pickerView.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 60)
        pickerView.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        pickerView.autoSetDimension(.Height, toSize: ScreenSize.HEIGHT*0.25)
    }
}

//MARK: - ContryCodeActionSheetPickerViewController -
class ContryCodeActionSheetPickerViewController: UIAlertController {

    var pickerView: ContryCodePickerView!
    
    init(values: [String], callback: PickerCallback) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = "\n\n\n\n\n\n"
        addAction(UIAlertAction(title: "cancel".localizedString, style: .Cancel) { _ in })
        
        pickerView = ContryCodePickerView(values: values, callback: callback)
    }
    
    init(dictionary: [String : String], keys: [String], callback: PickerCallback) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = "\n\n\n\n\n\n"
        addAction(UIAlertAction(title: "close".localizedString, style: .Cancel) { _ in })
        
        pickerView = ContryCodePickerView(dictionary: dictionary, keys: keys, callback: callback)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pickerView)
        pickerView.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        pickerView.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 60)
        pickerView.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        pickerView.autoSetDimension(.Height, toSize: ScreenSize.HEIGHT*0.25)
    }
}

//MARK: - DeliveryActionSheetPickerViewController -
class DeliveryActionSheetPickerViewController: UIAlertController {
    
    var pickerView: DeliveryPickerView!
    
    init(deliveries: [Delivery], callback: DeliveryPickerCallback) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = "\n\n\n\n\n\n"
        addAction(UIAlertAction(title: "close".localizedString, style: .Cancel) { _ in })
        
        pickerView = DeliveryPickerView(deliveries: deliveries, callback: callback)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pickerView)
        pickerView.autoPinEdgeToSuperviewEdge(.Left, withInset: SE_OFFSET)
        pickerView.autoPinEdgeToSuperviewEdge(.Right, withInset: SE_OFFSET)
        pickerView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 60)
        pickerView.autoSetDimension(.Height, toSize: ScreenSize.HEIGHT*0.25)
    }
}

//MARK: - DistanceActionSheetPickerViewController -
class DistanceActionSheetPickerViewController: UIAlertController {
    
    var pickerView: DistancePickerView!
    
    init(distances: [Double], callback: DistancePickerCallback) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = "\n\n\n\n\n\n"
        addAction(UIAlertAction(title: "close".localizedString, style: .Cancel) { _ in })
        
        pickerView = DistancePickerView(distances: distances, callback: callback)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pickerView)
        pickerView.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        pickerView.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 60)
        pickerView.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        pickerView.autoSetDimension(.Height, toSize: ScreenSize.HEIGHT*0.25)
    }
}

//MARK: - LanguageActionSheetPickerViewController -
class LanguageActionSheetPickerViewController: UIAlertController {
    
    var callback: LanguagePickerCallback?
    var pickerView: LanguagePickerView!
    
    init(languages: [String], callback: LanguagePickerCallback) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = "\n\n\n\n\n\n"
        self.callback = callback
        
        addAction(UIAlertAction(title: "cancel".localizedString, style: .Cancel) { _ in })
        addAction(UIAlertAction(title: "save".localizedString, style: .Destructive) { _ in
            let index = self.pickerView.selectedRowInComponent(0)
            let language = languages[index]
            callback(value: language, index: index)
            })
        
        pickerView = LanguagePickerView(languages: languages)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pickerView)
        pickerView.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        pickerView.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 120)
        pickerView.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        pickerView.autoSetDimension(.Height, toSize: ScreenSize.HEIGHT*0.25)
    }
}