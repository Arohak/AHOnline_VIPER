//
//  ObjectsViewController.swift
//  AHOnline
//
//  Created by AroHak on 17/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import SVPullToRefresh_Bell

enum ObjectsType: String {
    case ALL = "all"
    case New = "new"
    case Rate = "rate"
    case Open = "open"
}

//MARK: - class ObjectsViewController -
class ObjectsViewController: BaseViewController {

    var output: ObjectsViewOutput!

    internal var objectsView         = ObjectsView()
    internal let cellIdentifire      = "cellIdentifire"
    internal var objects: [AHObject] = []
    internal var search              = ""
    internal var categoryID          = ""
    internal var subcategoryID       = ""
    internal var limit               = LIMIT
    internal var offset              = OFFSET
    internal var type                = ObjectsType.ALL
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "restaurants".localizedString
        navigationController?.setNavigationBarHidden(false, animated: false)
        getObjects()
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = objectsView
        
        objectsView.tableView.dataSource = self
        objectsView.tableView.delegate = self
        objectsView.tableView.register(ObjectsCell.self, forCellReuseIdentifier: cellIdentifire)
        objectsView.refresh.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        createPagination()
    }
    
    override func refresh() {
        offset = 0
        objectsView.tableView.showsInfiniteScrolling = true
        
        getObjects()
    }
    
    //MARK: -  Private Methods -
    private func getObjects() {
        var params = JSON.null
        if !categoryID.isEmpty {
            params = JSON([
                "category_id"       : "\(categoryID)",
                "subcategory_id"    : "\(subcategoryID)",
                "limit"             : "\(limit)",
                "offset"            : "\(offset)",
                "type"              : "\(type.rawValue)"])
            
        } else if !search.isEmpty {
            params = JSON([
                "limit"             : "\(limit)",
                "offset"            : "\(offset)",
                "search"            : "\(search)"])
            
        } else {
            params = JSON([
                "limit"             : "\(limit)",
                "offset"            : "\(offset)",
                "type"              : "\(type.rawValue)"])
        }
        
        output.getObjects(params: params)
    }
    
    //MARK: - Public Methods -
    func setParams(categoryID: String = "", subcategoryID: String = "", search: String = "", type: ObjectsType = .ALL) {
        self.categoryID     = categoryID
        self.subcategoryID  = subcategoryID
        self.search         = search
        self.type           = type
    }
    
    //MARK: - Pagination -
    func createPagination() {
        objectsView.tableView.addInfiniteScrolling {
            [weak self] in
            if let weakSelf = self {
                weakSelf.offset += weakSelf.limit
                weakSelf.getObjects()
                weakSelf.objectsView.tableView.infiniteScrollingView.stopAnimating()
            }
        }
    }
}

//MARK: - extension for ObjectsViewInput -
extension ObjectsViewController: ObjectsViewInput {
    
    func updateObjectsData(objects: [AHObject]) {
        handleData(newObjects: objects)
        objectsView.refresh.endRefreshing()
    }
    
    func handleData(newObjects: [AHObject]) {
        if offset == 0 {
            UIHelper.deleteRowsFromTable(tableView: objectsView.tableView, objects: &objects)
        }
        
        UIHelper.insertRowsInTable(tableView: objectsView.tableView, objects: newObjects, inObjects: &objects, reversable: false)
        objectsView.tableView.showsInfiniteScrolling = newObjects.count < limit ? false : true
    }
}

//MARK: - extension for UITableView -
extension ObjectsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire) as! ObjectsCell
        let object = objects[indexPath.row]
        cell.setValues(object: object)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = objects[indexPath.row]
        output.didSelectObject(object: object)
    }
}

