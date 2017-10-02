//
//  VerifyPhoneNumberView.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import FacebookLogin

class VerifyPhoneNumberView: BaseScrollView {
    
    //MARK: - Create UIElements -
    lazy var countryCodeButton: HOButton = {
        let view = HOButton.newAutoLayout()
        view.backgroundColor = .white

        return view
    }()
    
    lazy var phoneTextField: HOTextField = {
        let view = HOTextField.newAutoLayout()
        view.placeholder = "phone".localizedString
        view.keyboardType = .phonePad
        
        return view
    }()
    
    lazy var sendButton: HOButton = {
        let view = HOButton.newAutoLayout()
        view.setBackgroundImage(UIImage(named: "img_result"), for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.setTitle("send".localizedString, for: .normal)

        return view
    }()
    
    lazy var pinTextField: HOTextField = {
        let view = HOTextField.newAutoLayout()
        view.placeholder = "pin".localizedString
        view.isEnabled = false
        view.keyboardType = .phonePad

        return view
    }()
    
    lazy var acceptButton: HOButton = {
        let view = HOButton.newAutoLayout()
        view.setBackgroundImage(UIImage(named: "img_result"), for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.setTitle("accept".localizedString, for: .normal)
        view.isEnabled = false

        return view
    }()
    
    lazy var titleLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.numberOfLines = 0
        view.text = "Enter your mobile number and press SEND, after access true enter secure code (pin code) and press ACCEPT"
        view.textColor = .white
        
        return view
    }()
    
    lazy var loginButton: LoginButton = {
        let view = LoginButton(readPermissions: [ .publicProfile ])
        
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
        contentView.addSubview(phoneTextField)
        contentView.addSubview(countryCodeButton)
        contentView.addSubview(sendButton)
        contentView.addSubview(pinTextField)
        contentView.addSubview(acceptButton)
        contentView.addSubview(titleLabel)
        addSubview(loginButton)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        scrollView.autoPinEdge(.bottom, to: .bottom, of: acceptButton, withOffset: 0)
        contentView.autoPinEdge(.bottom, to: .bottom, of: acceptButton, withOffset: 0)
                
        phoneTextField.autoPinEdge(toSuperviewEdge: .top, withInset: VE_OFFSET*2)
        phoneTextField.autoAlignAxis(.vertical, toSameAxisOf: self, withOffset: -VE_HEIGHT*0.9)
        phoneTextField.autoSetDimensions(to: CGSize(width: VE_WIDTH, height: VE_HEIGHT))
        
        countryCodeButton.autoAlignAxis(.horizontal, toSameAxisOf: phoneTextField)
        countryCodeButton.autoPinEdge(.right, to: .left, of: phoneTextField)
        countryCodeButton.autoSetDimensions(to: CGSize(width: VE_HEIGHT, height: VE_HEIGHT))
        
        sendButton.autoPinEdge(.left, to: .right, of: phoneTextField)
        sendButton.autoAlignAxis(.horizontal, toSameAxisOf: phoneTextField)
        sendButton.autoSetDimensions(to: CGSize(width: VE_HEIGHT*2.7, height: VE_HEIGHT))
        
        pinTextField.autoPinEdge(.top, to: .bottom, of: sendButton, withOffset: VE_OFFSET)
        pinTextField.autoAlignAxis(.vertical, toSameAxisOf: self, withOffset: -VE_HEIGHT*1.35)
        pinTextField.autoSetDimensions(to: CGSize(width: VE_WIDTH + VE_HEIGHT, height: VE_HEIGHT))
        
        acceptButton.autoAlignAxis(.horizontal, toSameAxisOf: pinTextField)
        acceptButton.autoPinEdge(.left, to: .right, of: pinTextField)
        acceptButton.autoSetDimensions(to: CGSize(width: VE_HEIGHT*2.7, height: VE_HEIGHT))
        
        titleLabel.autoPinEdge(.top, to: .bottom, of: acceptButton, withOffset: VE_OFFSET)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: VE_OFFSET)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: VE_OFFSET)
        
        loginButton.autoPinEdge(toSuperviewEdge: .bottom, withInset: VE_OFFSET*10)
        loginButton.autoAlignAxis(toSuperviewAxis: .vertical)
        loginButton.autoSetDimensions(to: CGSize(width: VE_WIDTH, height: VE_HEIGHT))
    }
}
