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
    
    //MARK: - Create UIElements
    let bgView: UIView = {
        let view = UIView.newAutoLayoutView()
        view.backgroundColor = UIColor.whiteColor()
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        return view
    }()
    
    let drawRoutButton: UIButton = {
        let view = UIButton.newAutoLayoutView()
        view.setImage(UIImage(named: "img_mapview_route"), forState: UIControlState.Normal)
        
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel.newAutoLayoutView()
        view.textColor = BLUE
        view.numberOfLines = 1
        
        return view
    }()
    
    let descLabel: DescLabel = {
        let view = DescLabel.newAutoLayoutView()
        view.numberOfLines = 2
        
        return view
    }()
    
    let arrowImageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.image = UIImage(named: "img_mapview_arrow")
        
        return view
    }()
    
    //MARK: - Initialize
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        self.addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Methods
    func addAllUIElements() {
        self.addSubview(bgView)
        self.bgView.addSubview(drawRoutButton)
        self.bgView.addSubview(titleLabel)
        self.bgView.addSubview(descLabel)
        self.addSubview(arrowImageView)
        
        self.setConstraints()
    }
    
    //MARK: - Set Constraints
    func setConstraints() {
        bgView.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        bgView.autoPinEdgeToSuperviewEdge(ALEdge.Left)
        bgView.autoPinEdgeToSuperviewEdge(ALEdge.Right)
        bgView.autoSetDimension(ALDimension.Height, toSize: MP_INFOWINDOW_SIZE)
        
        drawRoutButton.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        drawRoutButton.autoPinEdgeToSuperviewEdge(ALEdge.Left)
        widthRoutConstraints = drawRoutButton.autoSetDimension(ALDimension.Width, toSize: MP_INFOWINDOW_SIZE)
        drawRoutButton.autoSetDimension(ALDimension.Height, toSize: MP_INFOWINDOW_SIZE)
        
        descLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: bgView, withOffset: MP_INSET/2)
        descLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: drawRoutButton, withOffset: MP_INSET/2)
        descLabel.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: MP_INSET/2)
        
        titleCenterConstraints = titleLabel.autoPinEdge(ALEdge.Bottom, toEdge: ALEdge.Top, ofView: descLabel)
        titleLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: drawRoutButton, withOffset: MP_INSET/2)
        titleLabel.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: MP_INSET/2)
        
        arrowImageView.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: bgView)
        arrowImageView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: bgView)
        arrowImageView.autoSetDimensionsToSize(CGSize(width: MP_INSET, height: MP_INSET/2))
    }
}