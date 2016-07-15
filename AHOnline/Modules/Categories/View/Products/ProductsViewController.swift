//
//  ProductsViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ProductsViewController: BaseViewController {
    
    var output: CategoriesViewOutput!

    var objectsView = ObjectsView()
    let cellIdentifire = "cellIdentifire"
    var products: [Product] = []
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = objectsView
        
        objectsView.tableView.dataSource = self
        objectsView.tableView.delegate = self
        objectsView.tableView.registerClass(BaseTableViewCell.self, forCellReuseIdentifier: cellIdentifire)
    }
}

//MARK: - extension for UITableView -
extension ProductsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return products.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire) as! BaseTableViewCell
        let product = products[indexPath.row]
        cell.imageView?.kf_setImageWithURL(NSURL(string: product.src)!, placeholderImage: Image(named: "img_all"))
        cell.textLabel?.text = product.name
        cell.detailTextLabel?.text = product.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
}
