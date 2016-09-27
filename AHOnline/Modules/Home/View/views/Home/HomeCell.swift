//
//  HomeCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class HomeCell: BaseTableViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = HomeCellContentView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    init(style: UITableViewCellStyle, reuseIdentifier: String?, title: String = "", description: String = "") {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let cellContentView = HomeCellContentView(title: title, description: description)
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    func setValues(indexPath: IndexPath,
                   title: String,
                   desc: String,
                   items: [AHObject],
                   height: CGFloat = ScreenSize.HEIGHT*0.3,
                   inset: CGFloat = 0,
                   callBack: @escaping CollectionCallback) {
        
        cellContentView.setValues(indexPath: indexPath, title: title, desc: desc, items: items, height: height, inset: inset, callBack: callBack)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - HomeCellContentView
class HomeCellContentView: UIView {
    
    let collectionCellIdentifire = "collectionCellIdentifire"
    
    var title: String!
    var desc: String!

    var collectionItems: [AHObject] = []
    var collectionSize = CGSize.zero
    var collectionInsets = UIEdgeInsets.zero
    
    var section: Int = 0
    var callBack: CollectionCallback?

    //MARK: - Create UIElements -
    lazy var titleLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayout()
        view.textColor = RED
        view.numberOfLines = 0
        view.textAlignment = .center

        return view
    }()
    
    lazy var descriptionLabel: DescLabel = {
        let view = DescLabel.newAutoLayout()
        view.numberOfLines = 0
        view.textAlignment = .center

        return view
    }()
    
    lazy var seellAllButton: HOButton = {
        let view = HOButton.newAutoLayout()
        view.setBackgroundImage(UIImage(named: "img_more"), for: .normal)
        
        return view
    }()
    
    lazy var collection: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = BaseCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(HomeCollectionCell.self, forCellWithReuseIdentifier: self.collectionCellIdentifire)
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    //MARK: - Initialize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    convenience init(title: String) {
        self.init(frame: CGRect.zero)
        
        setupCollectionView()
        setupTitle(text: title)
    }
    
    convenience init(title: String, description: String) {
        self.init(title: title)
        
        setupDescription(text: description)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func setupTitle(text: String) {
        addSubview(titleLabel)
        addSubview(seellAllButton)
        titleLabel.text = text

        seellAllButton.autoAlignAxis(.horizontal, toSameAxisOf: titleLabel)
        seellAllButton.autoPinEdge(toSuperviewEdge: .right, withInset: HO_INSET*2)
        seellAllButton.autoSetDimensions(to: CGSize(width: HO_INSET*4.6*0.6, height: HO_INSET*0.6))

        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: HO_INSET*2)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: HO_INSET*2)
    }
    
    private func setupDescription(text: String) {
        addSubview(descriptionLabel)
        descriptionLabel.text = text

        descriptionLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: 0)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: HO_INSET)
        descriptionLabel.autoPinEdge(toSuperviewEdge: .right, withInset: HO_INSET)
    }
    
    private func setupCollectionView() {
        addSubview(collection)
        
        let view = descriptionLabel.superview == nil ? titleLabel.superview == nil ? self : titleLabel : descriptionLabel
        collection.autoPinEdge(.top, to: .bottom, of: view, withOffset: HO_INSET)
        collection.autoPinEdge(toSuperviewEdge: .left, withInset: HO_INSET)
        collection.autoPinEdge(toSuperviewEdge: .right, withInset: HO_INSET)
        collection.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
    }
    
    //MARK: - Public Methods -
    func setValues(indexPath: IndexPath,
                   title: String,
                   desc: String,
                   items: [AHObject],
                   height: CGFloat = ScreenSize.HEIGHT*0.3,
                   inset: CGFloat = 0,
                   callBack: @escaping CollectionCallback)
    {
        
        if !title.isEmpty { setupTitle(text: title) }
        if !desc.isEmpty { setupDescription(text: desc) }
        seellAllButton.indexPath = indexPath
        setupCollectionView()
        
        collectionItems = items
        collectionSize = CGSize(width: height, height: height*0.7)
        collectionInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        self.section = indexPath.row
        self.callBack = callBack
    }
}

//MARK: - extension for UICollectionView -
extension HomeCellContentView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifire, for: indexPath) as! HomeCollectionCell
        let restaurant = collectionItems[indexPath.row]
        cell.setValues(restaurant: restaurant)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let indexPath = IndexPath(row: indexPath.row, section: section)
        callBack!(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return collectionInsets
    }
}
