//
//  BaseCategoryViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class BaseCategoryViewController: BaseViewController {
    
    var output: CategoriesViewOutput!
    
    var baseCategoryView = BaseCategoryView()
    let cellIdentifire = "cellIdentifire"
    var subCategories: [SubCategory] = []
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testCategories()
    }
    
    func testCategories() {
        let sub1 = SubCategory(data: JSON(["name" : "AAA", "image" : ""]))
        let sub2 = SubCategory(data: JSON(["name" : "BBB", "image" : ""]))
        let sub3 = SubCategory(data: JSON(["name" : "CCC", "image" : ""]))
        let sub4 = SubCategory(data: JSON(["name" : "DDD", "image" : ""]))
        
        subCategories.append(sub1)
        subCategories.append(sub2)
        subCategories.append(sub3)
        subCategories.append(sub4)
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = baseCategoryView
        
        baseCategoryView.tableView.dataSource = self
        baseCategoryView.tableView.delegate = self
        baseCategoryView.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifire)
    }
}

//MARK: - extension for UITableView -
extension BaseCategoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return subCategories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire)
        let item = subCategories[indexPath.row]
        cell!.imageView?.kf_setImageWithURL(NSURL(string: item.image)!)
        cell!.textLabel?.text = item.name
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
