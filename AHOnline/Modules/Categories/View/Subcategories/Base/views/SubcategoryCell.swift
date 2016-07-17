//
//  SubcategoryCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class SubcategoryCell: UICollectionViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = SubcategoryCellContentView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    func setValues(subcategory: Subcategory) {
        cellContentView.imageView.kf_setImageWithURL(NSURL(string: subcategory.src)!, placeholderImage: Image(named: "img_placeholder"))
        cellContentView.nameLabel.text = subcategory.name
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - SubcategoryCellContentView -
class SubcategoryCellContentView: UIView {
    
    //MARK: - Create UIElements -
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        
        return view
    }()
    
    lazy var nameLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.numberOfLines = 2
        view.textAlignment = .Center
        
        return view
    }()
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRectZero)
        
        addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Privat Methods -
    func addAllUIElements() {
        addSubview(imageView)
        addSubview(nameLabel)
        
        setConstraints()
    }
    
    //MARK: - Constraints
    func setConstraints() {
        imageView.autoPinEdge(.Bottom, toEdge: .Top, ofView: nameLabel)
        imageView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: .Bottom)
        
        nameLabel.autoPinEdgeToSuperviewEdge(.Bottom)
        nameLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: SB_INSET)
        nameLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: SB_INSET)
    }
}
