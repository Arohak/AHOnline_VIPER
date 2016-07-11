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
    
    func setValues(title: String, desc: String, items: [AnyObject], height: CGFloat = ScreenSize.HEIGHT*0.3) {
        cellContentView.setValues(title, desc: desc, items: items, height: height)
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

    var collectionItems = []
    var collectionSize = CGSizeZero
    var collectionInsets = UIEdgeInsetsZero    

    //MARK: - Create UIElements -
    lazy var titleLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
        view.numberOfLines = 0
        view.textAlignment = .Center

        return view
    }()
    
    lazy var descriptionLabel: HOLabel = {
        let view = HOLabel.newAutoLayoutView()
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
    func setValues(title: String,
                   desc: String,
                   items: [AnyObject],
                   height: CGFloat = ScreenSize.HEIGHT*0.3,
                   inset: CGFloat = HO_INSET)
    {
        
        if !title.isEmpty { setupTitle(title) }
        if !desc.isEmpty { setupDescription(desc) }
        setupCollectionView()
        
        collectionItems = items
        collectionSize = CGSize(width: height, height: height)
        collectionInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)        
    }
}

//MARK: - extension for UICollectionView -
extension HomeCellContentView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCellIdentifire, forIndexPath: indexPath) as! HomeCollectionCell
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return collectionSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return collectionInsets
    }
}
