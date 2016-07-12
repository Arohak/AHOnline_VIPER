//
//  RestaurantViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class RestaurantViewController: BaseViewController {
    
    var output: CategoriesViewOutput!
    
    var restaurantView = RestaurantView()
    let cellIdentifire = "cellIdentifire"
    var items: [SubCategory] = []
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = restaurantView
        
        restaurantView.tableView.dataSource = self
        restaurantView.tableView.delegate = self
        restaurantView.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifire)
    }
}

//MARK: - extension for UITableView -
extension RestaurantViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire)
        let item = items[indexPath.row]
        cell!.imageView?.kf_setImageWithURL(NSURL(string: item.src)!)
        cell!.textLabel?.text = item.name
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
