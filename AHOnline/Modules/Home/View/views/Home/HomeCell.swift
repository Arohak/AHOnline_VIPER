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
    
    func setValues(section: Int,
                   title: String,
                   desc: String,
                   items: [AHObject],
                   height: CGFloat = ScreenSize.HEIGHT*0.3,
                   inset: CGFloat = 0,
                   callBack: CollectionCallback) {
        
        cellContentView.setValues(section, title: title, desc: desc, items: items, height: height, inset: inset, callBack: callBack)
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
    var collectionSize = CGSizeZero
    var collectionInsets = UIEdgeInsetsZero
    
    var section: Int = 0
    var callBack: CollectionCallback?

    //MARK: - Create UIElements -
    lazy var titleLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayoutView()
        view.textColor = RED
        view.numberOfLines = 0
        view.textAlignment = .Center

        return view
    }()
    
    lazy var descriptionLabel: DescLabel = {
        let view = DescLabel.newAutoLayoutView()
        view.numberOfLines = 0
        view.textAlignment = .Center

        return view
    }()
    
    lazy var collection: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        let view = BaseCollectionView(frame: CGRectZero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.registerClass(HomeCollectionCell.self, forCellWithReuseIdentifier: self.collectionCellIdentifire)
        view.showsHorizontalScrollIndicator = false
        
        return view
    }()
    
    //MARK: - Initialize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    convenience init(title: String) {
        self.init(frame: CGRectZero)
        
        setupCollectionView()
        setupTitle(title)
    }
    
    convenience init(title: String, description: String) {
        self.init(title: title)
        
        setupDescription(description)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func setupTitle(text: String) {
        addSubview(titleLabel)
        titleLabel.text = text

        titleLabel.autoPinEdgeToSuperviewEdge(.Top, withInset: HO_INSET*2)
        titleLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: HO_INSET)
        titleLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: HO_INSET)
    }
    
    private func setupDescription(text: String) {
        addSubview(descriptionLabel)
        descriptionLabel.text = text

        descriptionLabel.autoPinEdge(.Top, toEdge: .Bottom, ofView: titleLabel, withOffset: 0)
        descriptionLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: HO_INSET)
        descriptionLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: HO_INSET)
    }
    
    private func setupCollectionView() {
        addSubview(collection)
        
        let view = descriptionLabel.superview == nil ? titleLabel.superview == nil ? self : titleLabel : descriptionLabel
        collection.autoPinEdge(.Top, toEdge: .Bottom, ofView: view, withOffset: HO_INSET)
        collection.autoPinEdgeToSuperviewEdge(.Left, withInset: HO_INSET)
        collection.autoPinEdgeToSuperviewEdge(.Right, withInset: HO_INSET)
        collection.autoPinEdgeToSuperviewEdge(.Bottom, withInset: 0)
    }
    
    //MARK: - Public Methods -
    func setValues(section: Int,
                   title: String,
                   desc: String,
                   items: [AHObject],
                   height: CGFloat = ScreenSize.HEIGHT*0.3,
                   inset: CGFloat = 0,
                   callBack: CollectionCallback)
    {
        
        if !title.isEmpty { setupTitle(title) }
        if !desc.isEmpty { setupDescription(desc) }
        setupCollectionView()
        
        collectionItems = items
        collectionSize = CGSize(width: height, height: height*0.7)
        collectionInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        self.section = section
        self.callBack = callBack
    }
}

//MARK: - extension for UICollectionView -
extension HomeCellContentView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCellIdentifire, forIndexPath: indexPath) as! HomeCollectionCell
        let restaurant = collectionItems[indexPath.row]
        cell.setValues(restaurant)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let indexPath = NSIndexPath(forRow: indexPath.row, inSection: section)
        callBack!(indexPath: indexPath)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return collectionSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return collectionInsets
    }
}
