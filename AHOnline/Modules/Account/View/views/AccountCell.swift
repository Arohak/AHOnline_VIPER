//
//  AccountCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class AccountCell: BaseTableViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = AccountCellCellContentView()

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

//MARK: - AccountCellCellContentView
class AccountCellCellContentView: UIView {

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
        view.font = FONT_NAVBAR
        
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
        imageView.autoPinEdgeToSuperviewEdge(.Left, withInset: AC_INSET)
        imageView.autoSetDimensionsToSize(CGSize(width: AC_CELL_HEIGHT*0.9, height: AC_CELL_HEIGHT*0.9))
        
        nameLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
        nameLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: AC_INSET)
        nameLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: AC_INSET)
    }
    
    //MARK: - Public Methods -
    func setValues(imageString: String, name: String)  {
        imageView.image = UIImage(named: imageString)
        nameLabel.text = name
    }
}
