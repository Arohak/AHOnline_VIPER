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
    
    lazy var refresh: CarbonSwipeRefresh = {
        let view = CarbonSwipeRefresh(scrollView: self.collectionView)
        view.colors = RCOLORS
        
        return view
    }()
    
    //MARK: - Initialize -
    override init() {
        super.init()
        
        addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addAllUIElements() {
        addSubview(collectionView)
        collectionView.addSubview(refresh)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        collectionView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: NAV_HEIGHT, left: 0, bottom: TAB_HEIGHT, right: 0))
        refresh.setMarginTop(0)
    }
}
