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
        cellContentView.setValues(restaurant)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - HomeCollectionCellContentView -
class HomeCollectionCellContentView: UIView {
    
    //MARK: - Create UIElements -
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.contentMode = .ScaleAspectFit

        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.contentMode = .ScaleAspectFit
        
        return view
    }()
    
    lazy var nameLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.textColor = GRAY
        view.numberOfLines = 0
        
        return view
    }()
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRectZero)
        
        backgroundColor = GRAY_239
        addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addAllUIElements() {
        addSubview(bgImageView)
        addSubview(imageView)
        addSubview(nameLabel)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        imageView.autoPinEdgeToSuperviewEdge(.Top, withInset: 0)
        imageView.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        imageView.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        imageView.autoMatchDimension(.Height, toDimension: .Width, ofView: imageView, withMultiplier: 0.4)
        
        nameLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: imageView, withOffset: HO_INSET/2)
        nameLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        nameLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
    }
    
    //MARK: - Public Methods -
    func setValues(restaurant: AHObject) {
        if restaurant.img.isEmpty {
            imageView.hidden = false
            bgImageView.hidden = true
            imageView.kf_setImageWithURL(NSURL(string: restaurant.src)!)
            nameLabel.text = restaurant.label
            
        } else {
            bgImageView.hidden = false
            imageView.hidden = true
            bgImageView.image = UIImage(named: restaurant.img)
            nameLabel.text = ""
        }
    }
}

