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
        view.backgroundColor = WHITE
        
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.backgroundColor = RED
        
        return view
    }()
    
    let titleLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.textColor = BLUE
        view.text = "AAA BBB CCC DDD"
        
        return view
    }()
    
    let favoriteButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.backgroundColor = GREEN

        return view
    }()
    
    let historyButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.backgroundColor = GREEN

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
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(favoriteButton)
        addSubview(historyButton)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        imageView.autoPinEdgeToSuperviewEdge(.Top, withInset: 10)
        imageView.autoAlignAxisToSuperviewAxis(.Vertical)
        imageView.autoSetDimensionsToSize(CGSize(width: 80, height: 80))

        titleLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: imageView, withOffset: 10)
        titleLabel.autoAlignAxisToSuperviewAxis(.Vertical)
        
        favoriteButton.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: titleLabel, withOffset: 10)
        favoriteButton.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: bgImageView, withOffset: MP_BTN_SIZE)
        favoriteButton.autoSetDimensionsToSize(CGSize(width: 30, height: 30))
        
        historyButton.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: titleLabel, withOffset: 10)
        historyButton.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: bgImageView, withOffset: -MP_BTN_SIZE)
        historyButton.autoSetDimensionsToSize(CGSize(width: 30, height: 30))
    }
}