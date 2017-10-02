//
//  ProductViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

enum ProductsRequestType: String {
    case Default    = "products"
    case Search     = "results"
    case Favorite   = "favorites"
}

class ProductViewController: BaseViewController {
    
    var output: ProductViewOutput!

    internal var productView                 = ProductView()
    internal let cellIdentifire              = "cellIdentifire"
    internal var count: CGFloat              = 2
    internal var inset: CGFloat              = 5
    internal var products: [Product]         = []
    internal var search                      = ""
    internal var id                          = ""
    internal var limit                       = LIMIT
    internal var offset                      = OFFSET
    internal var requestType                 = ProductsRequestType.Default

    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        getProducts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch requestType {
        case .Favorite:
            getProducts()

        default:
            productView.collectionView.reloadData()
        }
    }
    
    override func updateLocalizedStrings() {
        navigationItem.title = requestType.rawValue.localizedString
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = productView

        productView.collectionView.dataSource = self
        productView.collectionView.delegate = self
        productView.collectionView.register(ProductCell.self, forCellWithReuseIdentifier: cellIdentifire)
        productView.refresh.addTarget(self, action: #selector(refresh), for: .valueChanged)

        createPagination()
    }
    
    override func refresh() {
        offset = 0
        productView.collectionView.showsInfiniteScrolling = true

        getProducts()
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
    func setParams(requestType: ProductsRequestType = .Default, id: String = "", search: String = "", count: CGFloat = 2, inset: CGFloat = 5) {
        self.requestType    = requestType
        self.id             = id
        self.search         = search
        
        self.count = count
        self.inset = inset
    }
    
    //MARK: - Pagination -
    func createPagination() {
        productView.collectionView.addInfiniteScrolling {
            [weak self] in
            if let weakSelf = self {
                weakSelf.offset += weakSelf.limit
                weakSelf.getProducts()
                weakSelf.productView.collectionView.infiniteScrollingView.stopAnimating()
            }
        }
    }
    
    //MARK: - Actions -
    func addAction(sender: HOButton) {
        let product = products[sender.indexPath.row]
        output.addProductBuy(product: product)
    }
    
    func addOrDeleteFavorite(sender: HOButton) {
        let product = products[sender.indexPath.row]
        output.favoriteButtonClicked(product: product)
    }
}

//MARK: - extension for ProductViewInput -
extension ProductViewController: ProductViewInput {
    
    func setupInitialState(products: [Product]) {
        handleData(newProducts: products)
        productView.refresh.endRefreshing()
    }
    
    func addProduct(product: Product) {
        let row = products.index(of: product)!
        let indexPath = IndexPath(row: row, section: 0)
        let cell = productView.collectionView.cellForItem(at: indexPath) as! ProductCell
        cell.cellContentView.updateCount(product: product)
    }
    
    func updateProduct(product: Product) {
        switch requestType {
        case .Favorite:
            deleteFavorite(product: product)

        default:
            let row = products.index(of: product)!
            let indexPath = IndexPath(row: row, section: 0)
            let cell = productView.collectionView.cellForItem(at: indexPath) as! ProductCell
            cell.cellContentView.favoriteButton.isSelected = !cell.cellContentView.favoriteButton.isSelected
        }
    }
    
    //MARK: - Private Methods -
    private func handleData(newProducts: [Product]) {
        if offset == 0 {
            UIHelper.deleteRowsFromCollection(collectionView: productView.collectionView, objects: &products)
        }
        
        productView.collectionView.showsInfiniteScrolling = newProducts.count < limit ? false : true
        UIHelper.insertRowsInCollection(collectionView: productView.collectionView, objects: newProducts, inObjects: &products, reversable: false)
    }
    
    private func deleteFavorite(product: Product) {
        let row = products.index(of: product)!
        let indexPath = IndexPath(row: row, section: 0)
        
        productView.collectionView.performBatchUpdates({
            self.products.remove(at: row)
            self.productView.collectionView.deleteItems(at: [indexPath])
            }, completion: { finish in
                self.productView.collectionView.reloadData()
        })
    }
}

//MARK: - extension for UICollectionView -
extension ProductViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let product = products[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifire, for: indexPath) as! ProductCell
        cell.cellContentView.addButton.addTarget(self, action: #selector(addAction(sender:)), for: .touchUpInside)
        cell.cellContentView.addButton.indexPath = indexPath
        cell.cellContentView.favoriteButton.addTarget(self, action: #selector(addOrDeleteFavorite(sender:)), for: .touchUpInside)
        cell.cellContentView.favoriteButton.indexPath = indexPath

        cell.setValues(product: product)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (Screen.width - inset*count*2)/count
        return CGSize(width: width, height: width*1.25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}
