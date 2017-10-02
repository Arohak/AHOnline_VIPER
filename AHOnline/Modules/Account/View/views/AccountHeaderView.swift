//
//  AccountHeaderView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/18/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class AccountHeaderView: UIView {
    
    var widthRoutConstraints: NSLayoutConstraint!
    var titleCenterConstraints: NSLayoutConstraint!
    
    //MARK: - Create UIElements -
    let bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "img_bg_user")
        
        return view
    }()
    
    let parentView: UIView = {
        let view = UIView.newAutoLayout()
        
        return view
    }()
    
    let imageButton: HOButton = {
        let view = HOButton.newAutoLayout()
        view.setBackgroundImage(UIImage(named: "img_acc_user"), for: .normal)
        view.layer.cornerRadius = AC_IMG_SIZE*0.5
        
        return view
    }()
    
    let nameLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayout()
        view.textColor = .blue_
        
        return view
    }()
    
    let phoneLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.textColor = .blue_
        
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
        parentView.addSubview(nameLabel)
        parentView.addSubview(phoneLabel)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        parentView.autoAlignAxis(toSuperviewAxis: .horizontal)
        parentView.autoPinEdge(toSuperviewEdge: .left)
        parentView.autoPinEdge(toSuperviewEdge: .right)
        parentView.autoPinEdge(.top, to: .top, of: imageButton)
        parentView.autoPinEdge(.bottom, to: .bottom, of: phoneLabel)
        
        imageButton.autoPinEdge(toSuperviewEdge: .top)
        imageButton.autoAlignAxis(toSuperviewAxis: .vertical)
        imageButton.autoSetDimensions(to: CGSize(width: AC_IMG_SIZE, height: AC_IMG_SIZE))

        nameLabel.autoPinEdge(.top, to: .bottom, of: imageButton, withOffset: AC_INSET)
        nameLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        phoneLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: 0)
        phoneLabel.autoAlignAxis(toSuperviewAxis: .vertical)
    }
}
