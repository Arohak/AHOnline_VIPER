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
        let view = ButtonGroupView.newAutoLayout()
        view.nameLabel.text = "country".localizedString
        
        return view
    }()
    
    lazy var cityView: ButtonGroupView = {
        let view = ButtonGroupView.newAutoLayout()
        view.nameLabel.text = "city".localizedString

        return view
    }()
    
    lazy var cityFieldView: FieldGroupView = {
        let view = FieldGroupView.newAutoLayout()
        view.textField.returnKeyType = .next
        view.nameLabel.text = "city".localizedString
        view.textField.placeholder = "city".localizedString
        
        return view
    }()
    
    lazy var addressFieldView: FieldGroupView = {
        let view = FieldGroupView.newAutoLayout()
        view.textField.returnKeyType = .done
        view.nameLabel.text = "address".localizedString
        view.textField.placeholder = "delivery_address_pl".localizedString
        
        return view
    }()
    
    lazy var saveButton: HOButton = {
        let view = HOButton.newAutoLayout()
        view.setBackgroundImage(UIImage(named: "img_result"), for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.setTitle("save".localizedString, for: .normal)

        return view
    }()
    
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = .clear
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
        scrollView.autoPinEdge(.bottom, to: .bottom, of: saveButton, withOffset: 0)
        contentView.autoPinEdge(.bottom, to: .bottom, of: saveButton, withOffset: 0)
        
        countryView.autoPinEdge(toSuperviewEdge: .top, withInset: MA_OFFSET)
        countryView.autoAlignAxis(toSuperviewAxis: .vertical)
        countryView.autoSetDimension(.width, toSize: MA_WIDTH)
        countryView.autoPinEdge(.bottom, to: .bottom, of: countryView.arrowImageView)

        cityView.autoPinEdge(.top, to: .bottom, of: countryView, withOffset: MA_INSET)
        cityView.autoAlignAxis(toSuperviewAxis: .vertical)
        cityView.autoSetDimension(.width, toSize: MA_WIDTH)
        cityView.autoPinEdge(.bottom, to: .bottom, of: cityView.arrowImageView)
        
        cityFieldView.autoPinEdge(.top, to: .bottom, of: countryView, withOffset: MA_INSET)
        cityFieldView.autoAlignAxis(toSuperviewAxis: .vertical)
        cityFieldView.autoSetDimension(.width, toSize: MA_WIDTH)
        cityFieldView.autoPinEdge(.bottom, to: .bottom, of: cityFieldView.textField)
        
        addressFieldView.autoPinEdge(.top, to: .bottom, of: cityFieldView, withOffset: MA_INSET)
        addressFieldView.autoAlignAxis(toSuperviewAxis: .vertical)
        addressFieldView.autoSetDimension(.width, toSize: MA_WIDTH)
        addressFieldView.autoPinEdge(.bottom, to: .bottom, of: addressFieldView.textField)
        
        saveButton.autoPinEdge(.top, to: .bottom, of: addressFieldView, withOffset: MA_OFFSET)
        saveButton.autoAlignAxis(toSuperviewAxis: .vertical)
        saveButton.autoSetDimensions(to: CGSize(width: MA_WIDTH/2, height: MA_HEIGHT))
    }
}
