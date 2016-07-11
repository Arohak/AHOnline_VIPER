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
    
    func setValues(item: Category) {

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - HomeCollectionCellContentView -
class HomeCollectionCellContentView: UIView {
    
    //MARK: - Create UIElements -
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var nameLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.textColor = WHITE
        view.text = "Name"
        
        return view
    }()
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRectZero)
        
        backgroundColor = GREEN
        addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addAllUIElements() {
        addSubview(imageView)
        addSubview(nameLabel)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        imageView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 0)
        imageView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), excludingEdge: .Bottom)
        
        nameLabel.autoPinEdgeToSuperviewEdge(.Bottom)
        nameLabel.autoAlignAxisToSuperviewAxis(.Vertical)
    }
}

