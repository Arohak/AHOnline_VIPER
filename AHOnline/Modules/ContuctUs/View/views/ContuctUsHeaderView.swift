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
        let view = UIImageView.newAutoLayoutView()
        view.contentMode = .ScaleAspectFill
//        view.image = Image(named: "img_bg_user")
        
        return view
    }()
    
    let parentView: UIView = {
        let view = UIView.newAutoLayoutView()
        
        return view
    }()
    
    let imageButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.layer.cornerRadius = CO_BTN_SIZE*0.5
        view.clipsToBounds = true
        view.setBackgroundImage(UIImage(named: "img_all"), forState: .Normal)

        return view
    }()
    
    let titleLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.textColor = BLUE
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
        
        parentView.autoAlignAxisToSuperviewAxis(.Horizontal)
        parentView.autoPinEdgeToSuperviewEdge(.Left)
        parentView.autoPinEdgeToSuperviewEdge(.Right)
        parentView.autoPinEdge(.Top, toEdge: .Top, ofView: imageButton)
        parentView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: titleLabel)
        
        imageButton.autoPinEdgeToSuperviewEdge(.Top)
        imageButton.autoAlignAxisToSuperviewAxis(.Vertical)
        imageButton.autoSetDimensionsToSize(CGSize(width: CO_BTN_SIZE, height: CO_BTN_SIZE))

        titleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: imageButton, withOffset: CO_INSET)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: CO_OFFSET)
        titleLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: CO_OFFSET)
    }
}