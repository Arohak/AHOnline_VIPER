//
//  DatePikerViewController.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

typealias DatePickerCallback = (date: NSDate) -> Void

class DatePickerViewController: UIAlertController {
    
    var pickerView: DatePickerView!
    
    init(date: NSDate, callback: DatePickerCallback?) {
        super.init(nibName: nil, bundle: nil)
        
        title = nil
        message = ""
        
        pickerView = DatePickerView(date: date, callback: callback)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(pickerView)
        pickerView.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        pickerView.autoPinEdgeToSuperviewEdge(ALEdge.Bottom)
        pickerView.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        pickerView.autoSetDimension(.Height, toSize: ScreenSize.HEIGHT*0.4)
    }
}