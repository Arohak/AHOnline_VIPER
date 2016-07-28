//
//  HistoryCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class HistoryCell: BaseTableViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = HistoryCellContentView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    func setValues(imageString: String, name: String) {
        cellContentView.setValues(imageString, name: name)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - HistoryCellContentView
class HistoryCellContentView: UIView {

    //MARK: - Create UIElements -
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        
        return view
    }()
    
    lazy var nameLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayoutView()
        view.textColor = RED
        
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
        imageView.autoPinEdgeToSuperviewEdge(.Left, withInset: CO_INSET)
        imageView.autoSetDimensionsToSize(CGSize(width: CO_CELL_HEIGHT*0.9, height: CO_CELL_HEIGHT*0.9))
        
        nameLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
        nameLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: CO_INSET)
        nameLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: CO_INSET)
    }
    
    //MARK: - Public Methods -
    func setValues(imageString: String, name: String)  {
        imageView.image = UIImage(named: imageString)
        nameLabel.text = name
    }
}
