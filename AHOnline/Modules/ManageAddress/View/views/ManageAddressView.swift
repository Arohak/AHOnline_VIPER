//
//  ManageAddressView.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ManageAddressView: BaseScrollView {
    
    //MARK: - Create UIElements -
    lazy var countryButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.backgroundColor = WHITE
        view.layer.borderWidth = 0.5
        view.layer.borderColor = BLACK.CGColor
        
        return view
    }()
    
    lazy var cityButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.backgroundColor = WHITE
        view.layer.borderWidth = 0.5
        view.layer.borderColor = BLACK.CGColor
        
        return view
    }()
    
    lazy var cityTextField: HOTextField = {
        let view = HOTextField.newAutoLayoutView()
        view.placeholder = "city".localizedString
        
        return view
    }()
    
    lazy var addressTextField: HOTextField = {
        let view = HOTextField.newAutoLayoutView()
        view.placeholder = "street, apartment, house".localizedString
        
        return view
    }()
    
    lazy var saveButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.backgroundColor = GREEN
        view.layer.borderWidth = 0.5
        view.layer.borderColor = BLACK.CGColor
        
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
        contentView.addSubview(countryButton)
        contentView.addSubview(cityButton)
        contentView.addSubview(cityTextField)
        contentView.addSubview(addressTextField)
        contentView.addSubview(saveButton)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        scrollView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: addressTextField, withOffset: 0)
        contentView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: addressTextField, withOffset: 0)
        
        countryButton.autoPinEdgeToSuperviewEdge(.Top, withInset: MA_OFFSET*2)
        countryButton.autoAlignAxisToSuperviewAxis(.Vertical)
        countryButton.autoSetDimensionsToSize(CGSize(width: MA_WIDTH, height: MA_HEIGHT))
        
        cityButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: countryButton, withOffset: MA_INSET)
        cityButton.autoAlignAxisToSuperviewAxis(.Vertical)
        cityButton.autoSetDimensionsToSize(CGSize(width: MA_WIDTH, height: MA_HEIGHT))
        
        cityTextField.autoPinEdge(.Top, toEdge: .Bottom, ofView: countryButton, withOffset: MA_INSET)
        cityTextField.autoAlignAxisToSuperviewAxis(.Vertical)
        cityTextField.autoSetDimensionsToSize(CGSize(width: MA_WIDTH, height: MA_HEIGHT))
        
        addressTextField.autoPinEdge(.Top, toEdge: .Bottom, ofView: cityButton, withOffset: MA_INSET)
        addressTextField.autoAlignAxisToSuperviewAxis(.Vertical)
        addressTextField.autoSetDimensionsToSize(CGSize(width: MA_WIDTH, height: MA_HEIGHT))
        
        saveButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: addressTextField, withOffset: MA_OFFSET)
        saveButton.autoAlignAxisToSuperviewAxis(.Vertical)
        saveButton.autoSetDimensionsToSize(CGSize(width: MA_WIDTH/2, height: MA_HEIGHT))
    }
}