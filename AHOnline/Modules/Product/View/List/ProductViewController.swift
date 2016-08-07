//
//  ProductViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

enum RequestType: String {
    case ID = "id"
    case SEARCH = "search"
    case FAVORITE = "favorite"
}

class ProductViewController: BaseViewController {
    
    var output: ProductViewOutput!

    private var productView                 = ProductView()
    private let cellIdentifire              = "cellIdentifire"
    private var count: CGFloat              = 2
    private var inset: CGFloat              = 5
    private var products: [Product]         = []

    private var requestType                 = RequestType.ID
    private var search                      = ""
    private var id                          = ""
    private var limit                       = LIMIT
    private var offset                      = OFFSET

    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        getProducts()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        productView.collectionView.reloadData()
    }
    
    override func updateLocalizedStrings() {
        
        navigationItem.title = "products".localizedString
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = productView

        productView.collectionView.dataSource = self
        productView.collectionView.delegate = self
        productView.collectionView.registerClass(ProductCell.self, forCellWithReuseIdentifier: cellIdentifire)
        productView.refresh.addTarget(self, action: #selector(refresh), forControlEvents: .ValueChanged)

        createPagination()
    }
    
    override func refresh() {
        offset = 0
        productView.collectionView.showsInfiniteScrolling = true

        getProducts()
    }
    
    //MARK: - Actions -
    func addAction(sender: HOButton) {
        let product = products[sender.indexPath.row]
        output.addProductBuy(product)
    }
    
    func addOrDeleteFavorite(sender: HOButton) {
        let product = products[sender.indexPath.row]
        output.favoriteButtonClicked(product)
    }
    
    //MARK: -  Private Methods -
    private func getProducts() {
        var params = JSON.null
        if !id.isEmpty {
            params = JSON([
                "id"                : "\(id)",
                "limit"             : "\(limit)",
                "offset"            : "\(offset)"])
            
        } else if !search.isEmpty {
            params = JSON([
                "search"            : "\(search)",
                "limit"             : "\(limit)",
                "offset"            : "\(offset)"])
            
        } else {
            params = JSON([
                "user_id"           : "",
                "limit"             : "\(limit)",
                "offset"            : "\(offset)"])
        }
        
        
        output.getProducts(requestType, json: params)
    }
    
    //MARK: - Public Methods -
    func setParams(requestType: RequestType = .ID, id: String = "", search: String = "", count: CGFloat = 2, inset: CGFloat = 5) {
        self.requestType    = requestType
        self.id             = id
        self.search         = search
        
        self.count = count
        self.inset = inset
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
        productView.refresh.endRefreshing()
    }
    
    func addProduct(product: Product) {
        let row = products.indexOf(product)!
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        let cell = productView.collectionView.cellForItemAtIndexPath(indexPath) as! ProductCell
        cell.cellContentView.updateCount(product)
    }
    
    func updateProduct(product: Product) {
        let row = products.indexOf(product)!
        let indexPath = NSIndexPath(forRow: row, inSection: 0)
        
        switch requestType {
        case .FAVORITE:
            productView.collectionView.performBatchUpdates({ 
                self.products.removeAtIndex(row)
                self.productView.collectionView.deleteItemsAtIndexPaths([indexPath])
                }, completion: { finish in
                    self.productView.collectionView.reloadData()
            })

        default:
            let cell = productView.collectionView.cellForItemAtIndexPath(indexPath) as! ProductCell
            cell.cellContentView.favoriteButton.selected = !cell.cellContentView.favoriteButton.selected
        }
    }
    
    //MARK: - Private Methods -
    private func handleData(newProducts: [Product]) {
        if offset == 0 {
            UIHelper.deleteRowsFromCollection(productView.collectionView, objects: &products)
        }
        
        productView.collectionView.showsInfiniteScrolling = newProducts.count < limit ? false : true
        UIHelper.insertRowsInCollection(productView.collectionView, objects: newProducts, inObjects: &products, reversable: false)
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
        cell.cellContentView.favoriteButton.addTarget(self, action: #selector(addOrDeleteFavorite(_:)), forControlEvents: .TouchUpInside)
        cell.cellContentView.favoriteButton.indexPath = indexPath

        cell.setValues(product)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = (ScreenSize.WIDTH - inset*count*2)/count
        return CGSize(width: width, height: width*1.2)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}
