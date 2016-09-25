//
//  MapObjectsCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class MapObjectsCell: BaseTableViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = MapObjectsCellCellContentView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    func setValues(imageURL: URL, name: String, address: String, distance: String) {
        cellContentView.setValues(imageURL: imageURL, name: name, address: address, distance: distance)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - MapObjectsCellCellContentView
class MapObjectsCellCellContentView: UIView {

    //MARK: - Create UIElements -
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        
        return view
    }()
    
    lazy var nameLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayout()
        
        return view
    }()
    
    lazy var addressLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayout()
        view.numberOfLines = 2
        view.font = TITLE_BTN_FONT
        
        return view
    }()
    
    lazy var distanceLabel: DescLabel = {
        let view = DescLabel.newAutoLayout()
        view.textAlignment = .right

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
        addSubview(addressLabel)
        addSubview(distanceLabel)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        imageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        imageView.autoPinEdge(toSuperviewEdge: .left, withInset: OB_INSET)
        imageView.autoSetDimensions(to: CGSize(width: OB_INSET*8, height: OB_INSET*3))
        
        nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: OB_INSET)
        nameLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: OB_INSET)
        nameLabel.autoPinEdge(.right, to: .left, of: distanceLabel, withOffset: -OB_INSET)
        
        addressLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: OB_INSET)
        addressLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: OB_INSET)
        addressLabel.autoPinEdge(.right, to: .left, of: distanceLabel, withOffset: -OB_INSET)
        addressLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: OB_INSET)
        
        distanceLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        distanceLabel.autoPinEdge(toSuperviewEdge: .right, withInset: OB_INSET)
        distanceLabel.autoSetDimension(.width, toSize: OB_INSET*8)
    }
    
    //MARK: - Public Methods -
    func setValues(imageURL: URL, name: String, address: String, distance: String)  {
        imageView.af_setImage(withURL: imageURL, placeholderImage: UIImage(named: "img_empty"))
        nameLabel.text = name
        addressLabel.text = address
        distanceLabel.text = distance
    }
}
