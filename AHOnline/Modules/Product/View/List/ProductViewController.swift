//
//  ProductViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ProductViewController: BaseViewController {
    
    var output: ProductViewOutput!

    var productView = ProductView()
    let cellIdentifire = "cellIdentifire"
    private var products: [Product] = []
    private var objectMenu: ObjectMenu!
    
    //MARK: - Initilize -
    init(objectMenu: ObjectMenu) {
        super.init(nibName: nil, bundle: nil)

        self.objectMenu = objectMenu
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
        output.getProducts(objectMenu)
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
    }
    
    //MARK: - Actions -
    func addAction(sender: HOButton) {
        let product = products[sender.indexPath.row]
        output.addProductBuy(product)
        let cell = productView.collectionView.cellForItemAtIndexPath(sender.indexPath) as! ProductCell
        cell.cellContentView.updateCount(product)
    }
}

//MARK: - extension for ProductViewInput -
extension ProductViewController: ProductViewInput {

    func setupInitialState(products: [Product]) {
       self.products = products
        
        productView.collectionView.reloadData()
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
