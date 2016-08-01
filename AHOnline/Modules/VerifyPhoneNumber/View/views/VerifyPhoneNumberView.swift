//
//  VerifyPhoneNumberView.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class VerifyPhoneNumberView: BaseScrollView {
    
    //MARK: - Create UIElements -
    lazy var countryCodeButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.backgroundColor = WHITE

        return view
    }()
    
    lazy var phoneTextField: HOTextField = {
        let view = HOTextField.newAutoLayoutView()
        view.placeholder = "phone".localizedString
        view.keyboardType = .PhonePad
        
        return view
    }()
    
    lazy var sendButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.backgroundColor = GREEN
        view.setTitle("send".localizedString, forState: .Normal)
        
        return view
    }()
    
    lazy var pinTextField: HOTextField = {
        let view = HOTextField.newAutoLayoutView()
        view.placeholder = "pin".localizedString
        view.enabled = false
        view.keyboardType = .PhonePad

        return view
    }()
    
    lazy var acceptButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.backgroundColor = GREEN
        view.setTitle("accept".localizedString, forState: .Normal)
        view.enabled = false

        return view
    }()
    
    lazy var titleLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.numberOfLines = 0
        view.text = "Enter your mobile number and press SEND, after access true enter secure code (pin code) and press ACCEPT"
        view.textColor = WHITE
        
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
        contentView.addSubview(phoneTextField)
        contentView.addSubview(countryCodeButton)
        contentView.addSubview(sendButton)
        contentView.addSubview(pinTextField)
        contentView.addSubview(acceptButton)
        contentView.addSubview(titleLabel)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        scrollView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: acceptButton, withOffset: 0)
        contentView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: acceptButton, withOffset: 0)
                
        phoneTextField.autoPinEdgeToSuperviewEdge(.Top, withInset: VE_OFFSET*2)
        phoneTextField.autoAlignAxis(.Vertical, toSameAxisOfView: self, withOffset: -VE_HEIGHT/2)
        phoneTextField.autoSetDimensionsToSize(CGSize(width: VE_WIDTH, height: VE_HEIGHT))
        
        countryCodeButton.autoAlignAxis(.Horizontal, toSameAxisOfView: phoneTextField)
        countryCodeButton.autoPinEdge(.Right, toEdge: .Left, ofView: phoneTextField)
        countryCodeButton.autoSetDimensionsToSize(CGSize(width: VE_HEIGHT, height: VE_HEIGHT))
        
        sendButton.autoPinEdge(.Left, toEdge: .Right, ofView: phoneTextField)
        sendButton.autoAlignAxis(.Horizontal, toSameAxisOfView: phoneTextField)
        sendButton.autoSetDimensionsToSize(CGSize(width: VE_HEIGHT*2, height: VE_HEIGHT))
        
        pinTextField.autoPinEdge(.Top, toEdge: .Bottom, ofView: sendButton, withOffset: VE_OFFSET)
        pinTextField.autoAlignAxis(.Vertical, toSameAxisOfView: self, withOffset: -VE_HEIGHT)
        pinTextField.autoSetDimensionsToSize(CGSize(width: VE_WIDTH + VE_HEIGHT, height: VE_HEIGHT))
        
        acceptButton.autoAlignAxis(.Horizontal, toSameAxisOfView: pinTextField)
        acceptButton.autoPinEdge(.Left, toEdge: .Right, ofView: pinTextField)
        acceptButton.autoSetDimensionsToSize(CGSize(width: VE_HEIGHT*2, height: VE_HEIGHT))
        
        titleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: acceptButton, withOffset: VE_OFFSET)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: VE_OFFSET)
        titleLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: VE_OFFSET)
    }
}
