//
//  RestaurantViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class RestaurantViewController: BaseViewController {
    
    var output: CategoriesViewOutput!
    
    internal var restaurantView = RestaurantView()
    internal let cellIdentifire = "cellIdentifire"
    internal var items: [Subcategory] = []
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = restaurantView
        
        restaurantView.tableView.dataSource = self
        restaurantView.tableView.delegate = self
        restaurantView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifire)
    }
}

//MARK: - extension for UITableView -
extension RestaurantViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire)
        let item = items[indexPath.row]
        cell!.imageView?.af_setImage(withURL: URL(string: item.src)!, placeholderImage: UIImage(named: "img_empty"))
        cell!.textLabel?.text = item.name
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
