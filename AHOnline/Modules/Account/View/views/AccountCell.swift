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
        cellContentView.setValues(imageString: imageString, name: name)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - AccountCellCellContentView
class AccountCellCellContentView: UIView {

    //MARK: - Create UIElements -
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.layer.cornerRadius = AC_CELL_HEIGHT*0.45
        view.clipsToBounds = true
        
        return view
    }()
    
    lazy var nameLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayout()
        view.font = CAC_TITLE_FONT
        
        return view
    }()

    //MARK: - Initialize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
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
        
        imageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        imageView.autoPinEdge(toSuperviewEdge: .left, withInset: AC_INSET)
        imageView.autoSetDimensions(to: CGSize(width: AC_CELL_HEIGHT*0.9, height: AC_CELL_HEIGHT*0.9))
        
        nameLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        nameLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: AC_INSET)
        nameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: AC_INSET)
    }
    
    //MARK: - Public Methods -
    func setValues(imageString: String, name: String)  {
        imageView.image = UIImage(named: imageString)
        nameLabel.text = name
    }
}
