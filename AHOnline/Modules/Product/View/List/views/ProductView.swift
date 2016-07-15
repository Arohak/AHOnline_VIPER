//
//  ProductView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ProductView: BaseView {
    
    lazy var collectionView: BaseCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = BaseCollectionView(frame: CGRectZero, collectionViewLayout: layout)
        
        return view
    }()
    
    //MARK: - Initialize -
    override init() {
        super.init()
        
        addSubview(collectionView)
        collectionView.autoPinEdgeToSuperviewEdge(.Top, withInset: NAV_HEIGHT)
        collectionView.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        collectionView.autoPinEdgeToSuperviewEdge(.Right, withInset: 0)
        collectionView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: TAB_HEIGHT)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
