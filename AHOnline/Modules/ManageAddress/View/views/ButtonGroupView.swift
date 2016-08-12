//
//  ButtonGroupView.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ButtonGroupView: UIView {
    
    //MARK: - Create UIElements -
    lazy var nameLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayoutView()
        view.textColor = WHITE
        
        return view
    }()
    
    lazy var titleLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.backgroundColor = WHITE
        view.textAlignment = .Center
        view.textColor = RED
        view.layer.borderWidth = 0.5
        view.layer.borderColor = BLACK.CGColor
        
        return view
    }()
    
    lazy var arrowImageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.image = UIImage(named: "img_manage_arrow")
        view.backgroundColor = WHITE
        
        return view
    }()
    
    lazy var button: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.backgroundColor = CLEAR

        return view
    }()
    
    //MARK: - Initialize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addAllUIElements() {
        addSubview(nameLabel)
        addSubview(arrowImageView)
        addSubview(titleLabel)
        addSubview(button)
        
        serConstraints()
    }
    
    //MARK: - Constarints -
    func serConstraints() {
        nameLabel.autoPinEdgeToSuperviewEdge(.Top)
        nameLabel.autoPinEdgeToSuperviewEdge(.Left)
        
        titleLabel.autoAlignAxis(.Horizontal, toSameAxisOfView: arrowImageView)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left)
        titleLabel.autoPinEdge(.Right, toEdge: .Left, ofView: arrowImageView)
        titleLabel.autoSetDimension(.Height, toSize: MA_HEIGHT)

        arrowImageView.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameLabel)
        arrowImageView.autoPinEdgeToSuperviewEdge(.Right)
        arrowImageView.autoSetDimensionsToSize(CGSize(width: MA_HEIGHT, height: MA_HEIGHT))

        button.autoPinEdgesToSuperviewEdges()
    }
    
    //MARK: - Public Methods -
    func setValue(title: String) {
        titleLabel.text = title
    }
}
