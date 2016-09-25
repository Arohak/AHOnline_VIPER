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
        baseCategoryView.collection.register(SubcategoryCell.self, forCellWithReuseIdentifier: cellIdentifire)
    }
}

    //MARK: - extension for UICollectionView -
extension BaseCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return subcategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifire, for: indexPath) as! SubcategoryCell
        let subcategory = subcategories[indexPath.row]
        cell.setValues(subcategory: subcategory)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let subcategory = subcategories[indexPath.row]
        output.didSelectSubcategoryRow(subcategory: subcategory)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: SB_CELL_WIDTH, height: SB_CELL_WIDTH*1.2)
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: SB_INSET, left: SB_INSET, bottom: SB_INSET, right: SB_INSET)
    }
}
