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
        let view = TitleLabel.newAutoLayout()
        view.textColor = .white
        
        return view
    }()
    
    lazy var titleLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.backgroundColor = .white
        view.textAlignment = .center
        view.textColor = .red_
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.black.cgColor
        
        return view
    }()
    
    lazy var arrowImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.image = UIImage(named: "img_manage_arrow")
        view.backgroundColor = .white
        
        return view
    }()
    
    lazy var button: HOButton = {
        let view = HOButton.newAutoLayout()
        view.backgroundColor = .clear

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
        nameLabel.autoPinEdge(toSuperviewEdge: .top)
        nameLabel.autoPinEdge(toSuperviewEdge: .left)
        
        titleLabel.autoAlignAxis(.horizontal, toSameAxisOf: arrowImageView)
        titleLabel.autoPinEdge(toSuperviewEdge: .left)
        titleLabel.autoPinEdge(.right, to: .left, of: arrowImageView)
        titleLabel.autoSetDimension(.height, toSize: MA_HEIGHT)

        arrowImageView.autoPinEdge(.top, to: .bottom, of: nameLabel)
        arrowImageView.autoPinEdge(toSuperviewEdge: .right)
        arrowImageView.autoSetDimensions(to: CGSize(width: MA_HEIGHT, height: MA_HEIGHT))

        button.autoPinEdgesToSuperviewEdges()
    }
    
    //MARK: - Public Methods -
    func setValue(title: String) {
        titleLabel.text = title
    }
}
