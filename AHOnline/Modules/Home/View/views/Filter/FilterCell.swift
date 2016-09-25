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
        cellContentView.autoPinEdgesToSuperviewEdges(with: UIEdgeInsets(top: SE_INSET, left: SE_INSET, bottom: 0, right: SE_INSET))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setValues(collectionItems: [String]) {
       cellContentView.setValues(collectionItems: collectionItems)
    }
}

//MARK: - FilterCellContentView
class FilterCellContentView: UIView {
    
    internal let collectionCellIdentifire    = "collectionCellIdentifire"
    internal var collectionItems: [String]   = []
    var selectedItems: [String]             = []

    //MARK: - Create UIElements -
    lazy var collection: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = BaseCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.register(FilterCollectionCell.self, forCellWithReuseIdentifier: self.collectionCellIdentifire)
        view.dataSource = self
        view.delegate = self
        
        return view
    }()
    
    //MARK: - Initialize -
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Internal Methods -
    internal func setupCollectionView() {
        addSubview(collection)
        collection.autoPinEdgesToSuperviewEdges()
    }
    
    internal func addItem(item: String) {
       selectedItems.append(item)
    }
    
    internal func removeItem(item: String) {
        selectedItems.remove(at: selectedItems.index(of: item)!)
    }
    
    //MARK: - Public Methods -
    func setValues(collectionItems: [String]) {
        self.collectionItems = collectionItems
        
        collection.reloadData()
    }
}

//MARK: - extension for UICollectionView -
extension FilterCellContentView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionItems[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellIdentifire, for: indexPath) as! FilterCollectionCell
        cell.cellContentView.button.setTitle(item, for: .normal)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! FilterCollectionCell
        cell.cellContentView.button.isSelected = !cell.cellContentView.button.isSelected
        
        let item = collectionItems[indexPath.row]
        cell.cellContentView.button.isSelected ? addItem(item: item) : removeItem(item: item)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let item = collectionItems[indexPath.row] as NSString 
        let textSize: CGSize = item.size(attributes: [NSFontAttributeName: CAC_TITLE_FONT])
        
        return textSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: SE_INSET/2, left: SE_INSET/2, bottom: SE_INSET/2, right: SE_INSET/2)
    }
}
