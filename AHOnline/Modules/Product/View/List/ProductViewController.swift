//
//  ProductViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ProductViewController: BaseViewController {
    
    var output: ProductViewOutput!

    private var productView = ProductView()
    private let cellIdentifire = "cellIdentifire"
    private var products: [Product] = []
    
    private var search              = ""
    private var id                  = ""
    private var isAddMore           = true
    private var limit               = LIMIT
    private var offset              = OFFSET

    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "products".localizedString
        navigationController?.setNavigationBarHidden(false, animated: true)
        getProducts()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        productView.collectionView.reloadData()
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = productView

        productView.collectionView.dataSource = self
        productView.collectionView.delegate = self
        productView.collectionView.registerClass(ProductCell.self, forCellWithReuseIdentifier: cellIdentifire)
        
        createPagination()
    }
    
    //MARK: - Actions -
    func addAction(sender: HOButton) {
        let product = products[sender.indexPath.row]
        output.addProductBuy(product)
        let cell = productView.collectionView.cellForItemAtIndexPath(sender.indexPath) as! ProductCell
        cell.cellContentView.updateCount(product)
    }
    
    private func getProducts() {
        var params = JSON.null
        if !id.isEmpty {
            params = JSON([
                "id"                : "\(id)",
                "limit"             : "\(limit)",
                "offset"            : "\(offset)"])
            
        } else if !search.isEmpty {
            params = JSON([
                "limit"             : "\(limit)",
                "offset"            : "\(offset)",
                "search"            : "\(search)"])
            
        }
        
        output.getProducts(params)
    }
    
    //MARK: - Public Methods -
    func setParams(id: String = "", search: String = "") {
        self.id     = id
        self.search = search
    }
    
    //MARK: - Pagination -
    func createPagination() {
        productView.collectionView.addInfiniteScrollingWithActionHandler {
            [weak self] in
            if let weakSelf = self {
                weakSelf.offset += weakSelf.limit
                weakSelf.getProducts()
                weakSelf.productView.collectionView.infiniteScrollingView.stopAnimating()
            }
        }
    }
}

//MARK: - extension for ProductViewInput -
extension ProductViewController: ProductViewInput {

    func setupInitialState(products: [Product]) {
        handleData(products)
//       self.products = products
//        productView.collectionView.reloadData()
    }
    
    func handleData(newProducts: [Product]) {
        if offset == 0 {
            UIHelper.deleteRowsFromCollection(productView.collectionView, objects: &products)
        }
        
        if isAddMore {
            UIHelper.insertRowsInCollection(productView.collectionView, objects: newProducts, inObjects: &products, reversable: false)
            
            if newProducts.count < limit {
                productView.collectionView.showsInfiniteScrolling = false
                isAddMore = false
            } else {
                productView.collectionView.showsInfiniteScrolling = true
            }
        }
    }
}

//MARK: - extension for UICollectionView -
extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return products.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let product = products[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifire, forIndexPath: indexPath) as! ProductCell
        cell.cellContentView.addButton.addTarget(self, action: #selector(addAction(_:)), forControlEvents: .TouchUpInside)
        cell.cellContentView.addButton.indexPath = indexPath
        cell.setValues(product)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSize(width: PR_LAYOUT_WIDTH, height: PR_LAYOUT_WIDTH*1.2)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: PR_INSET, left: PR_INSET, bottom: PR_INSET, right: PR_INSET)
    }
}
