//
//  FilterTableView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class FilterTableView: BaseTableView {
    
    let cellIdentifire1 = "cellIdentifire1"
    let cellIdentifire2 = "cellIdentifire2"
    let cellIdentifire3 = "cellIdentifire3"
    var headers: [String] = []
    var items: [[AnyObject]] = []
    var heights: [CGFloat] = []
    
    let footerView: AccountFooterView = {
        let view = AccountFooterView(frame: CGRect(x: OB_INSET*5, y: 0, width: ScreenSize.WIDTH - OB_INSET*10, height: OB_INSET*10))
        
        return view
    }()

    //MARK: - Initialize -
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        baseConfig()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Initialize -
    private func baseConfig() {
        tableFooterView = footerView

        registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifire1)
        registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifire2)
        registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifire3)
        
        dataSource = self
        delegate = self

        headers = ["Type", "Sort", "Key Words"]
        heights = [50, 50, 200]
        
        items.append([AnyObject]())
        items.append([AnyObject]())
        items.append([AnyObject]())
        
        items[0] = ["Restaurants", "Products"]
        items[1] = ["Name", "Popular", "Rate"]
        items[2] = [""]
        
        reloadData()
    }
}

//MARK: - extension for UITableView -
extension FilterTableView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return headers.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let item = items[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire1)
        cell!.textLabel?.text = item as? String
        cell!.accessoryType = .Checkmark
        
        return cell!
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return headers[section]
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return heights[indexPath.section]
    }
}
