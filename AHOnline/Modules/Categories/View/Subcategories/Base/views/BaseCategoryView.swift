//
//  BaseCategoryView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class BaseCategoryView: BaseView {
    
    lazy var collection: BaseCollectionView = {
        let view = BaseCollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
        
        return view
    }()
    
    //MARK: - Initialize -
    override init() {
        super.init()
        
        addSubview(collection)
        collection.autoPinEdgesToSuperviewEdges()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
