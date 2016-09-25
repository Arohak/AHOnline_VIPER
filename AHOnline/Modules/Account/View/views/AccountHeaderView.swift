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
        view.layer.cornerRadius = AC_BTN_SIZE*0.5
        
        return view
    }()
    
    let titleLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.textColor = BLUE
        
        return view
    }()
    
    let favoriteButton: HOButton = {
        let view = HOButton.newAutoLayout()
        view.setBackgroundImage(UIImage(named: "img_acc_favorite"), for: .normal)

        return view
    }()
    
    let favoriteLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.textColor = BLUE
        
        return view
    }()
    
    let historyButton: HOButton = {
        let view = HOButton.newAutoLayout()
        view.setBackgroundImage(UIImage(named: "img_acc_history"), for: .normal)

        return view
    }()
    
    let historyLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
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
        
        parentView.autoAlignAxis(toSuperviewAxis: .horizontal)
        parentView.autoPinEdge(toSuperviewEdge: .left)
        parentView.autoPinEdge(toSuperviewEdge: .right)
        parentView.autoPinEdge(.top, to: .top, of: imageButton)
        parentView.autoPinEdge(.bottom, to: .bottom, of: historyLabel)
        
        imageButton.autoPinEdge(toSuperviewEdge: .top)
        imageButton.autoAlignAxis(toSuperviewAxis: .vertical)
        imageButton.autoSetDimensions(to: CGSize(width: AC_BTN_SIZE, height: AC_BTN_SIZE))

        titleLabel.autoPinEdge(.top, to: .bottom, of: imageButton, withOffset: AC_INSET)
        titleLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        
        favoriteButton.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: AC_INSET)
        favoriteButton.autoAlignAxis(.vertical, toSameAxisOf: bgImageView, withOffset: AC_HEIGHT)
        favoriteButton.autoSetDimensions(to: CGSize(width: AC_BTN_SIZE*0.3, height: AC_BTN_SIZE*0.3))
        
        favoriteLabel.autoPinEdge(.top, to: .bottom, of: favoriteButton, withOffset: 0)
        favoriteLabel.autoAlignAxis(.vertical, toSameAxisOf: favoriteButton)
        
        historyButton.autoAlignAxis(.horizontal, toSameAxisOf: favoriteButton)
        historyButton.autoAlignAxis(.vertical, toSameAxisOf: bgImageView, withOffset: -AC_HEIGHT)
        historyButton.autoSetDimensions(to: CGSize(width: AC_BTN_SIZE*0.3, height: AC_BTN_SIZE*0.3))
        
        historyLabel.autoPinEdge(.top, to: .bottom, of: historyButton, withOffset: 0)
        historyLabel.autoAlignAxis(.vertical, toSameAxisOf: historyButton)
    }
    
    //MARK: - Public Methods -
    func updateLocalizedStrings()  {
        historyLabel.text = "history".localizedString
        favoriteLabel.text = "favorite".localizedString

    }
}
