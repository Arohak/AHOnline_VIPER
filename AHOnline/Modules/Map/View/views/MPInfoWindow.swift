//
//  MPInfoWindow.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/18/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class MPInfoWindow: UIView {
    
    var widthRoutConstraints: NSLayoutConstraint!
    var titleCenterConstraints: NSLayoutConstraint!
    
    //MARK: - Create UIElements -
    let bgView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = WHITE
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        return view
    }()
    
    let drawRoutButton: UIButton = {
        let view = UIButton.newAutoLayout()
        view.setImage(UIImage(named: "img_mapview_route"), for: UIControlState.normal)
        
        return view
    }()
    
    let titleLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.textColor = BLUE
        view.numberOfLines = 1
        
        return view
    }()
    
    let descLabel: DescLabel = {
        let view = DescLabel.newAutoLayout()
        view.numberOfLines = 2
        
        return view
    }()
    
    let arrowImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.image = UIImage(named: "img_mapview_arrow")
        
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
    
    //MARK: - Private Methods -
    private func addAllUIElements() {
        addSubview(bgView)
        bgView.addSubview(drawRoutButton)
        bgView.addSubview(titleLabel)
        bgView.addSubview(descLabel)
        addSubview(arrowImageView)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgView.autoPinEdge(toSuperviewEdge: .top)
        bgView.autoPinEdge(toSuperviewEdge: .left)
        bgView.autoPinEdge(toSuperviewEdge: .right)
        bgView.autoSetDimension(.height, toSize: MP_INFOWINDOW_SIZE)
        
        drawRoutButton.autoPinEdge(toSuperviewEdge: .top)
        drawRoutButton.autoPinEdge(toSuperviewEdge: .left)
        widthRoutConstraints = drawRoutButton.autoSetDimension(.width, toSize: MP_INFOWINDOW_SIZE)
        drawRoutButton.autoSetDimension(.height, toSize: MP_INFOWINDOW_SIZE)
        
        descLabel.autoAlignAxis(.horizontal, toSameAxisOf: bgView, withOffset: MP_INSET/2)
        descLabel.autoPinEdge(.left, to: .right, of: drawRoutButton, withOffset: MP_INSET/2)
        descLabel.autoPinEdge(toSuperviewEdge: .right, withInset: MP_INSET/2)
        
        titleCenterConstraints = titleLabel.autoPinEdge(.bottom, to: .top, of: descLabel)
        titleLabel.autoPinEdge(.left, to: .right, of: drawRoutButton, withOffset: MP_INSET/2)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: MP_INSET/2)
        
        arrowImageView.autoAlignAxis(.vertical, toSameAxisOf: bgView)
        arrowImageView.autoPinEdge(.top, to: .bottom, of: bgView)
        arrowImageView.autoSetDimensions(to: CGSize(width: MP_INSET, height: MP_INSET/2))
    }
}
