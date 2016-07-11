//
//  ActionSheetPickerViewController.swift
//  AHMusic
//
//  Created by Ara Hakobyan on 5/19/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ActionSheetPickerViewController: UIAlertController {
    
    var pickerView: DUPickerView!
    
    init(values: [String], callback: PickerCallback) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = "\n\n\n\n\n\n"
        addAction(UIAlertAction(title: "cancel".localizedString, style: .Cancel) { _ in })
        
        pickerView = DUPickerView(values: values, callback: callback)
    }
    
    init(dictionary: [String : String], keys: [String], callback: PickerCallback) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = "\n\n\n\n\n\n"
        addAction(UIAlertAction(title: "cancel".localizedString, style: .Cancel) { _ in })
        
        pickerView = DUPickerView(dictionary: dictionary, keys: keys, callback: callback)
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

class ACActionSheetPickerViewController: UIAlertController {
    
    var pickerView: ACPickerView!
    
    init(values: [String], callback: ACPickerCallback) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = "\n\n\n\n\n\n"
        addAction(UIAlertAction(title: "cancel".localizedString, style: .Cancel) { _ in })
        
        pickerView = ACPickerView(values: values, callback: callback)
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