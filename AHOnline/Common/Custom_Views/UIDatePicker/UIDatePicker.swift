//
//  UIDatePicker.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class DatePickerView: UIView {
    
    private var callback:       DatePickerCallback?
    var date = NSDate()
    
    //MARK: - Create UIElements -
    lazy var headerView: UIView = {
        let view = UIView.newAutoLayoutView()
        view.backgroundColor = GREEN
        
        return view
    }()
    
    lazy var picker: UIDatePicker = {
        let view = UIDatePicker.newAutoLayoutView()
//        view.backgroundColor = WHITE
        view.locale = NSLocale(localeIdentifier: "en_GB")
//        view.setValue(BLACK, forKey: "textColor")
        view.date = self.date
        view.minimumDate = NSDate()
//        view.datePickerMode = .Date
//        view.datePickerMode = .CountDownTimer
        
        return view
    }()
    
    lazy var saveButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.setTitle("save".localizedString, forState: .Normal)
        view.addTarget(self, action: #selector(save), forControlEvents: .TouchUpInside)
        
        return view
    }()
    
    lazy var cancelButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.setTitle("Cancel".localizedString, forState: .Normal)
        view.addTarget(self, action: #selector(cancel), forControlEvents: .TouchUpInside)
        
        return view
    }()
    
    //MARK: - Initilize -
    init(date: NSDate, callback: DatePickerCallback?) {
        super.init(frame: CGRectZero)
        
        self.callback = callback
        self.date = date
        addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Method -
    private func addAllUIElements() {
        addSubview(picker)
        addSubview(headerView)
        headerView.addSubview(saveButton)
        headerView.addSubview(cancelButton)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        
        picker.autoPinEdge(.Top, toEdge: .Bottom, ofView: headerView)
        picker.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: .Top)
        
        headerView.autoPinEdgeToSuperviewEdge(.Top)
        headerView.autoPinEdgeToSuperviewEdge(.Right)
        headerView.autoPinEdgeToSuperviewEdge(.Left)
        headerView.autoSetDimension(.Height, toSize: CA_CELL_HEIGHT)
        
        saveButton.autoPinEdgeToSuperviewEdge(.Right)
        saveButton.autoPinEdgeToSuperviewEdge(.Top)
        saveButton.autoSetDimensionsToSize(CGSize(width: CA_CELL_HEIGHT*2, height: CA_CELL_HEIGHT))
        
        cancelButton.autoPinEdgeToSuperviewEdge(.Left)
        cancelButton.autoPinEdgeToSuperviewEdge(.Top)
        cancelButton.autoSetDimensionsToSize(CGSize(width: CA_CELL_HEIGHT*2, height: CA_CELL_HEIGHT))
    }
    
    //MARK: - Actions -
    func save() {
        callback?(date: picker.date)
        Wireframe.dismissViewController()
    }
    
    func cancel() {
        Wireframe.dismissViewController()
    }
}