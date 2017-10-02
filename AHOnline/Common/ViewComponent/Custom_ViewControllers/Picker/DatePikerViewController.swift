//
//  DatePikerViewController.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

typealias DatePickerCallback = (_ date: Date) -> Void

class DatePickerViewController: UIAlertController {
    
    var pickerView: DatePickerView!
    
    init(date: Date, callback: DatePickerCallback?) {
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
        pickerView.autoPinEdge(toSuperviewEdge: .top)
        pickerView.autoPinEdge(toSuperviewEdge: .bottom)
        pickerView.autoAlignAxis(toSuperviewAxis: .vertical)
        pickerView.autoSetDimension(.height, toSize: Screen.height*0.4)
    }
}
