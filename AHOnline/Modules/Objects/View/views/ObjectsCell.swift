//
//  ObjectsCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import Cosmos

class ObjectsCell: BaseTableViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = ObjectsCellContentView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    func setValues(object: AHObject) {
        cellContentView.setValues(object: object)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - ObjectsCellContentView
class ObjectsCellContentView: UIView {

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
        view.numberOfLines = 1
        
        return view
    }()
    
    lazy var descLabel: DescLabel = {
        let view = DescLabel.newAutoLayout()
        view.numberOfLines = 2
        
        return view
    }()
    
    lazy var openImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        
        return view
    }()
    
    lazy var openLabel: DescLabel = {
        let view = DescLabel.newAutoLayout()
        
        return view
    }()
    
    lazy var cosmosView: CosmosView = {
        let view = CosmosView.newAutoLayout()
        view.settings.updateOnTouch = false
        view.settings.filledColor = RED
        view.settings.emptyBorderColor = RED
        view.settings.filledBorderColor = RED
        view.settings.starSize = Double(OB_IMG_SIZE)
        
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
        addSubview(descLabel)
        addSubview(openImageView)
        addSubview(openLabel)
        addSubview(cosmosView)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        bgImageView.autoPinEdgesToSuperviewEdges()
        
        imageView.autoPinEdge(toSuperviewEdge: .top, withInset: OB_INSET)
        imageView.autoPinEdge(toSuperviewEdge: .left, withInset: OB_INSET)
        imageView.autoSetDimensions(to: CGSize(width: OB_INSET*10, height: OB_INSET*5))
        
        nameLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: OB_INSET)
        nameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: OB_INSET)
        nameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: OB_INSET)
        
        descLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: OB_INSET)
        descLabel.autoPinEdge(.top, to: .bottom, of: nameLabel, withOffset: OB_INSET/2)
        descLabel.autoPinEdge(toSuperviewEdge: .right, withInset: OB_INSET)
        
        openImageView.autoPinEdge(.left, to: .right, of: imageView, withOffset: OB_INSET)
        openImageView.autoPinEdge(.top, to: .bottom, of: descLabel, withOffset: OB_INSET)
        openImageView.autoSetDimensions(to: CGSize(width: OB_IMG_SIZE, height: OB_IMG_SIZE))

        openLabel.autoAlignAxis(.horizontal, toSameAxisOf: openImageView)
        openLabel.autoPinEdge(.left, to: .right, of: openImageView, withOffset: OB_INSET)
        openLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: OB_INSET)
        
        cosmosView.autoAlignAxis(.horizontal, toSameAxisOf: openImageView)
        cosmosView.autoPinEdge(toSuperviewEdge: .right, withInset: OB_INSET)
    }
    
    //MARK: - Public Methods -
    func setValues(object: AHObject)  {
        imageView.af_setImage(withURL: URL(string: object.src)!, placeholderImage: UIImage(named: "img_empty"))
        nameLabel.text      = object.label
        descLabel.text      = object.desc
        openLabel.text      = object.openTime.shortTime + " - " + object.closeTime.shortTime
        cosmosView.rating   = Double(object.rate)
        
        if object.status == "open" {
            openImageView.image = UIImage(named: "img_clock_select")
            openLabel.textColor = GREEN
        } else {
            openImageView.image = UIImage(named: "img_clock")
            openLabel.textColor = RED
        }
    }
}
