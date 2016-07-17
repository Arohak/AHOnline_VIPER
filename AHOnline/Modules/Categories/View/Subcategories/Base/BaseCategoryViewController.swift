//
//  BaseCategoryViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class BaseCategoryViewController: BaseViewController {
    
    var output: CategoriesViewOutput!
    
    var baseCategoryView = BaseCategoryView()
    let cellIdentifire = "cellIdentifire"
    var category: Category!
    var subcategories: [Subcategory] = []
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = baseCategoryView
        
        baseCategoryView.collection.dataSource = self
        baseCategoryView.collection.delegate = self
        baseCategoryView.collection.registerClass(SubcategoryCell.self, forCellWithReuseIdentifier: cellIdentifire)
    }
}

    //MARK: - extension for UICollectionView -
extension BaseCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return subcategories.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifire, forIndexPath: indexPath) as! SubcategoryCell
        let subcategory = subcategories[indexPath.row]
        cell.setValues(subcategory)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let subcategory = subcategories[indexPath.row]
        output.didSelectSubcategoryRow(subcategory)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size = CGSize(width: SB_CELL_WIDTH, height: SB_CELL_WIDTH*1.2)
        
        return size
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: SB_INSET, left: SB_INSET, bottom: SB_INSET, right: SB_INSET)
    }
}
