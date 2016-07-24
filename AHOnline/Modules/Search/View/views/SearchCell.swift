//
//  SearchCell.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class SearchCell: BaseTableViewCell {
    
    //MARK: - Create UIElements -
    var cellContentView = SearchCellContentView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellContentView)
        cellContentView.autoPinEdgesToSuperviewEdges()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValues(collectionItems: [String]) {
       cellContentView.setValues(collectionItems)
    }
}

//MARK: - SearchCellContentView
class SearchCellContentView: UIView {
    
    private let collectionCellIdentifire = "collectionCellIdentifire"
    private var collectionItems: [String] = []

    //MARK: - Create UIElements -
    lazy var collection: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = BaseCollectionView(frame: CGRectZero, collectionViewLayout: layout)
        view.registerClass(SearchCollectionCell.self, forCellWithReuseIdentifier: self.collectionCellIdentifire)
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
    
    func setValues(collectionItems: [String]) {
        self.collectionItems = collectionItems
        
        collection.reloadData()
    }
}

//MARK: - extension for UICollectionView -
extension SearchCellContentView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let item = collectionItems[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionCellIdentifire, forIndexPath: indexPath) as! SearchCollectionCell
        cell.cellContentView.button.setTitle(item, forState: .Normal)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! SearchCollectionCell
        cell.cellContentView.button.selected = !cell.cellContentView.button.selected
        
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
