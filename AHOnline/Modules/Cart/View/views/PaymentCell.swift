//
//  PaymentCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class PaymentCell: BaseTableViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = PaymentCellContentView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - PaymentCellContentView
class PaymentCellContentView: UIView {

    //MARK: - Create UIElements -
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.contentMode = .ScaleAspectFit
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        
        return view
    }()
    
    lazy var titleLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayoutView()
        
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
//        addSubview(bgImageView)
        addSubview(imageView)
        addSubview(titleLabel)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
//        bgImageView.autoPinEdgesToSuperviewEdges()
//        
        imageView.autoAlignAxisToSuperviewAxis(.Horizontal)
        imageView.autoPinEdgeToSuperviewEdge(.Left, withInset: CA_INSET)
        imageView.autoSetDimensionsToSize(CGSize(width: CA_CELL_HEIGHT*2, height: CA_INSET*4))
        
        titleLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: CA_INSET)
        titleLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: CA_INSET)
    }
}
