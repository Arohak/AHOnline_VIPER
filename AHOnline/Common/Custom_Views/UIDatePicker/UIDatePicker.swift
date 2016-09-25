//
//  UIDatePicker.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class DatePickerView: UIView {
    
    private var callback:       DatePickerCallback?
    var date = Date()
    
    //MARK: - Create UIElements -
    lazy var headerView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = GREEN
        
        return view
    }()
    
    lazy var picker: UIDatePicker = {
        let view = UIDatePicker.newAutoLayout()
//        view.backgroundColor = WHITE
        view.locale = Locale(identifier: "en_GB")
//        view.setValue(BLACK, forKey: "textColor")
        view.date = self.date
        view.minimumDate = Date()
//        view.datePickerMode = .Date
//        view.datePickerMode = .CountDownTimer
        
        return view
    }()
    
    lazy var saveButton: HOButton = {
        let view = HOButton.newAutoLayout()
        view.setTitle("save".localizedString, for: .normal)
        view.addTarget(self, action: #selector(save), for: .touchUpInside)
        
        return view
    }()
    
    lazy var cancelButton: HOButton = {
        let view = HOButton.newAutoLayout()
        view.setTitle("Cancel".localizedString, for: .normal)
        view.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        
        return view
    }()
    
    //MARK: - Initilize -
    init(date: Date, callback: DatePickerCallback?) {
        super.init(frame: CGRect.zero)
        
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
        
        picker.autoPinEdge(.top, to: .bottom, of: headerView)
        picker.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: .top)
        
        headerView.autoPinEdge(toSuperviewEdge: .top)
        headerView.autoPinEdge(toSuperviewEdge: .right)
        headerView.autoPinEdge(toSuperviewEdge: .left)
        headerView.autoSetDimension(.height, toSize: CA_CELL_HEIGHT)
        
        saveButton.autoPinEdge(toSuperviewEdge: .right)
        saveButton.autoPinEdge(toSuperviewEdge: .top)
        saveButton.autoSetDimensions(to: CGSize(width: CA_CELL_HEIGHT*2, height: CA_CELL_HEIGHT))
        
        cancelButton.autoPinEdge(toSuperviewEdge: .left)
        cancelButton.autoPinEdge(toSuperviewEdge: .top)
        cancelButton.autoSetDimensions(to: CGSize(width: CA_CELL_HEIGHT*2, height: CA_CELL_HEIGHT))
    }
    
    //MARK: - Actions -
    func save() {
        callback?(picker.date)
        Wireframe.dismissViewController()
    }
    
    func cancel() {
        Wireframe.dismissViewController()
    }
}
