//
//  ManageAddressView.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ManageAddressView: BaseScrollView {
    
    //MARK: - Create UIElements -
    lazy var countryView: ButtonGroupView = {
        let view = ButtonGroupView.newAutoLayoutView()
        view.nameLabel.text = "country".lowercaseString
        
        return view
    }()
    
    lazy var cityView: ButtonGroupView = {
        let view = ButtonGroupView.newAutoLayoutView()
        view.nameLabel.text = "city".lowercaseString

        return view
    }()
    
    lazy var cityFieldView: FieldGroupView = {
        let view = FieldGroupView.newAutoLayoutView()
        view.textField.returnKeyType = .Next
        view.nameLabel.text = "city".lowercaseString
        view.textField.placeholder = "city".localizedString
        
        return view
    }()
    
    lazy var addressFieldView: FieldGroupView = {
        let view = FieldGroupView.newAutoLayoutView()
        view.textField.returnKeyType = .Done
        view.nameLabel.text = "address".lowercaseString
        view.textField.placeholder = "street, apartment, house".localizedString
        
        return view
    }()
    
    lazy var saveButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.backgroundColor = GREEN
        view.layer.borderWidth = 0.5
        view.layer.borderColor = BLACK.CGColor
        view.setTitle("save".localizedString, forState: .Normal)

        return view
    }()
    
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRectZero)
        
        backgroundColor = CLEAR
        addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    override func addAllUIElements() {
        super.addAllUIElements()
        
        bgView.alpha = 0.7
        contentView.addSubview(countryView)
        contentView.addSubview(cityView)
        contentView.addSubview(cityFieldView)
        contentView.addSubview(addressFieldView)
        contentView.addSubview(saveButton)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        scrollView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: addressFieldView, withOffset: 0)
        contentView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: addressFieldView, withOffset: 0)
        
        countryView.autoPinEdgeToSuperviewEdge(.Top, withInset: MA_OFFSET)
        countryView.autoAlignAxisToSuperviewAxis(.Vertical)
        countryView.autoSetDimension(.Width, toSize: MA_WIDTH)
        countryView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: countryView.arrowImageView)

        cityView.autoPinEdge(.Top, toEdge: .Bottom, ofView: countryView, withOffset: MA_INSET)
        cityView.autoAlignAxisToSuperviewAxis(.Vertical)
        cityView.autoSetDimension(.Width, toSize: MA_WIDTH)
        cityView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: cityView.arrowImageView)
        
        cityFieldView.autoPinEdge(.Top, toEdge: .Bottom, ofView: countryView, withOffset: MA_INSET)
        cityFieldView.autoAlignAxisToSuperviewAxis(.Vertical)
        cityFieldView.autoSetDimension(.Width, toSize: MA_WIDTH)
        cityFieldView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: cityFieldView.textField)
        
        addressFieldView.autoPinEdge(.Top, toEdge: .Bottom, ofView: cityFieldView, withOffset: MA_INSET)
        addressFieldView.autoAlignAxisToSuperviewAxis(.Vertical)
        addressFieldView.autoSetDimension(.Width, toSize: MA_WIDTH)
        addressFieldView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: addressFieldView.textField)
        
        saveButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: addressFieldView, withOffset: MA_OFFSET)
        saveButton.autoAlignAxisToSuperviewAxis(.Vertical)
        saveButton.autoSetDimensionsToSize(CGSize(width: MA_WIDTH/2, height: MA_HEIGHT))
    }
}