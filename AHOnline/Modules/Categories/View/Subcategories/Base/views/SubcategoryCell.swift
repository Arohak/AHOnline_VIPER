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
        cellContentView.imageView.af_setImage(withURL: URL(string: subcategory.src)!, placeholderImage: UIImage(named: "img_placeholder"))
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
        let view = UIImageView.newAutoLayout()
        
        return view
    }()
    
    lazy var nameLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.numberOfLines = 2
        view.textAlignment = .center
        
        return view
    }()
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRect.zero)
        
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
        imageView.autoPinEdge(.bottom, to: .top, of: nameLabel)
        imageView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: .bottom)
        
        nameLabel.autoPinEdge(toSuperviewEdge: .bottom)
        nameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: SB_INSET)
        nameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: SB_INSET)
    }
}
