//
//  ContuctUsHeaderView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/18/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ContuctUsHeaderView: UIView {
    
    //MARK: - Create UIElements -
    let bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.contentMode = .scaleAspectFill
//        view.image = Image(named: "img_bg_user")
        
        return view
    }()
    
    let parentView: UIView = {
        let view = UIView.newAutoLayout()
        
        return view
    }()
    
    let imageButton: HOButton = {
        let view = HOButton.newAutoLayout()
        view.layer.cornerRadius = CO_BTN_SIZE*0.5
        view.clipsToBounds = true
        view.setBackgroundImage(UIImage(named: "img_empty"), for: .normal)

        return view
    }()
    
    let titleLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.textColor = .blue_
        view.numberOfLines = 0
        view.text = "Certificate = Certificate getCertificate = Apply the certificate; AskYourBankLblText = Enter your email, mobile number and certificate code which Doocat emailed you.; EnterYourEmailLblText = Enter your email, mobile number and certificate code; ProvideMobileNumber = Enter the mobile number you provided to Doocat which will be used in Doocat; ProvidePinCode = Enter the certificate code the bank emailed you; CertificateExpired = Your security certificate has expired. Please contact Doocat to get a new certificate. RelauchApp= \nPlease, relaunch the application."
        
        return view
    }()
    
    //MARK: - Initialize -
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        self.addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods
    private func addAllUIElements() {
        addSubview(bgImageView)
        addSubview(parentView)
        parentView.addSubview(imageButton)
        parentView.addSubview(titleLabel)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        parentView.autoAlignAxis(toSuperviewAxis: .horizontal)
        parentView.autoPinEdge(toSuperviewEdge: .left)
        parentView.autoPinEdge(toSuperviewEdge: .right)
        parentView.autoPinEdge(.top, to: .top, of: imageButton)
        parentView.autoPinEdge(.bottom, to: .bottom, of: titleLabel)
        
        imageButton.autoPinEdge(toSuperviewEdge: .top)
        imageButton.autoAlignAxis(toSuperviewAxis: .vertical)
        imageButton.autoSetDimensions(to: CGSize(width: CO_BTN_SIZE, height: CO_BTN_SIZE))

        titleLabel.autoPinEdge(.top, to: .bottom, of: imageButton, withOffset: CO_INSET)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: CO_OFFSET)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: CO_OFFSET)
    }
}
