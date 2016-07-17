//
//  DiscountCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class DiscountCell: BaseTableViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = DiscountCellContentView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    func setValues(value: String) {
        cellContentView.setValues(value)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - DiscountCellContentView
class DiscountCellContentView: UIView {
    
    //MARK: - Create UIElements -
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.contentMode = .ScaleAspectFit
        //        view.backgroundColor = GRAY
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.contentMode = .ScaleAspectFit
        view.backgroundColor = GREEN
        
        return view
    }()
    
    lazy var nameLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayoutView()
        view.numberOfLines = 1
        
        return view
    }()
    
    //MARK: - Initialize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
        
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
        
        imageView.autoAlignAxisToSuperviewAxis(.Horizontal)
        imageView.autoPinEdgeToSuperviewEdge(.Left, withInset: 10)
        imageView.autoSetDimensionsToSize(CGSize(width: 60, height: 60))
        
        nameLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: 10)
        nameLabel.autoPinEdge(.Top, toEdge: .Top, ofView: imageView)
        nameLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 10)
    }
    
    //MARK: - Public Methods -
    func setValues(value: String)  {
        
    }
}