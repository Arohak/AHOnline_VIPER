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
        let view = UIImageView.newAutoLayoutView()
        view.contentMode = .ScaleAspectFill
        view.image = Image(named: "img_bg_user")
        
        return view
    }()
    
    let parentView: UIView = {
        let view = UIView.newAutoLayoutView()
        
        return view
    }()
    
    let imageButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.setBackgroundImage(UIImage(named: "img_acc_user"), forState: .Normal)
        view.layer.cornerRadius = AC_BTN_SIZE*0.5
        
        return view
    }()
    
    let titleLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.textColor = BLUE
        
        return view
    }()
    
    let favoriteButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.setBackgroundImage(UIImage(named: "img_acc_favorite"), forState: .Normal)

        return view
    }()
    
    let favoriteLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.textColor = BLUE
        
        return view
    }()
    
    let historyButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.setBackgroundImage(UIImage(named: "img_acc_history"), forState: .Normal)

        return view
    }()
    
    let historyLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.textColor = BLUE
        
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
        parentView.addSubview(favoriteButton)
        parentView.addSubview(favoriteLabel)
        parentView.addSubview(historyButton)
        parentView.addSubview(historyLabel)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        parentView.autoAlignAxisToSuperviewAxis(.Horizontal)
        parentView.autoPinEdgeToSuperviewEdge(.Left)
        parentView.autoPinEdgeToSuperviewEdge(.Right)
        parentView.autoPinEdge(.Top, toEdge: .Top, ofView: imageButton)
        parentView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: historyLabel)
        
        imageButton.autoPinEdgeToSuperviewEdge(.Top)
        imageButton.autoAlignAxisToSuperviewAxis(.Vertical)
        imageButton.autoSetDimensionsToSize(CGSize(width: AC_BTN_SIZE, height: AC_BTN_SIZE))

        titleLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: imageButton, withOffset: AC_INSET)
        titleLabel.autoAlignAxisToSuperviewAxis(.Vertical)
        
        favoriteButton.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: AC_INSET)
        favoriteButton.autoAlignAxis(.Vertical, toSameAxisOfView: bgImageView, withOffset: AC_HEIGHT)
        favoriteButton.autoSetDimensionsToSize(CGSize(width: AC_BTN_SIZE*0.3, height: AC_BTN_SIZE*0.3))
        
        favoriteLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: favoriteButton, withOffset: 0)
        favoriteLabel.autoAlignAxis(.Vertical, toSameAxisOfView: favoriteButton)
        
        historyButton.autoAlignAxis(.Horizontal, toSameAxisOfView: favoriteButton)
        historyButton.autoAlignAxis(.Vertical, toSameAxisOfView: bgImageView, withOffset: -AC_HEIGHT)
        historyButton.autoSetDimensionsToSize(CGSize(width: AC_BTN_SIZE*0.3, height: AC_BTN_SIZE*0.3))
        
        historyLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: historyButton, withOffset: 0)
        historyLabel.autoAlignAxis(.Vertical, toSameAxisOfView: historyButton)
    }
    
    //MARK: - Public Methods -
    func updateLocalizedStrings()  {
        historyLabel.text = "history".localizedString
        favoriteLabel.text = "favorite".localizedString

    }
}