//
//  HomeCollectionCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class HomeCollectionCell: UICollectionViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = HomeCollectionCellContentView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    func setValues(restaurant: AHObject) {
        cellContentView.setValues(restaurant: restaurant)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - HomeCollectionCellContentView -
class HomeCollectionCellContentView: UIView {
    
    //MARK: - Create UIElements -
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .gray_239
        view.layer.cornerRadius = HO_INSET
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    lazy var nameLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.textColor = .black
        view.numberOfLines = 0
        
        return view
    }()
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRect.zero)
        
//        backgroundColor = GRAY_239
        backgroundColor = .clear
        addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addAllUIElements() {
        addSubview(bgImageView)
        bgImageView.addSubview(imageView)
        bgImageView.addSubview(nameLabel)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        imageView.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        imageView.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        imageView.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        imageView.autoMatch(.height, to: .width, of: imageView, withMultiplier: 0.4)
        
        nameLabel.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: HO_INSET/2)
        nameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: HO_INSET)
        nameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: HO_INSET)
    }
    
    //MARK: - Public Methods -
    func setValues(restaurant: AHObject) {
        imageView.af_setImage(withURL: URL(string: restaurant.src)!, placeholderImage: UIImage(named: "img_empty"))
        nameLabel.text = restaurant.label
    }
}

