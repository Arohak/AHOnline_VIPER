//
//  FilterCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class FilterCell: BaseTableViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = FilterCellContentView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: SE_INSET, left: SE_INSET, bottom: 0, right: SE_INSET))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValues(collectionItems: [String]) {
       cellContentView.setValues(collectionItems)
    }
}

//MARK: - FilterCellContentView
class FilterCellContentView: UIView {
    
    private let collectionCellIdentifire    = "collectionCellIdentifire"
    private var collectionItems: [String]   = []
    var selectedItems: [String]             = []

    //MARK: - Create UIElements -
    lazy var collection: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = BaseCollectionView(frame: CGRectZero, collectionViewLayout: layout)
        view.registerClass(FilterCollectionCell.self, forCellWithReuseIdentifier: self.collectionCellIdentifire)
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    //MARK: - Initialize -
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRectZero)
        
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func setupCollectionView() {
        addSubview(collection)
        collection.autoPinEdgesToSuperviewEdges()
    }
    
    private func addItem(item: String) {
       selectedItems.append(item)
    }
    
    private func removeItem(item: String) {
        selectedItems.removeAtIndex(selectedItems.indexOf(item)!)
    }
    
    //MARK: - Public Methods -
    func setValues(collectionItems: [String]) {
        self.collectionItems = collectionItems
        
        collection.reloadData()
    }
}

//MARK: - extension for UICollectionView -
extension FilterCellContentView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = collectionItems[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCellIdentifire, forIndexPath: indexPath) as! FilterCollectionCell
        cell.cellContentView.button.setTitle(item, forState: .Normal)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! FilterCollectionCell
        cell.cellContentView.button.selected = !cell.cellContentView.button.selected
        
        let item = collectionItems[indexPath.row]
        cell.cellContentView.button.selected ? addItem(item) : removeItem(item)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let item = collectionItems[indexPath.row] as NSString 
        let textSize: CGSize = item.sizeWithAttributes([NSFontAttributeName: CAC_TITLE_FONT])
        
        return textSize
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: SE_INSET/2, left: SE_INSET/2, bottom: SE_INSET/2, right: SE_INSET/2)
    }
}
