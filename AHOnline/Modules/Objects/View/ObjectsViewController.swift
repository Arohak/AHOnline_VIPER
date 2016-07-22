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

    private var objectsView         = ObjectsView()
    private let cellIdentifire      = "cellIdentifire"
    private var objects: [AHObject] = []
    
    private var categoryID          = ""
    private var subcategoryID       = ""
    private var isAddMore           = true
    private var limit               = OBJECT_LIMIT
    private var offset              = OBJECT_OFFSET
    private var type                = ObjectsType.ALL
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Restaurants"
        getObjects()
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = objectsView
        
        objectsView.tableView.dataSource = self
        objectsView.tableView.delegate = self
        objectsView.tableView.registerClass(ObjectsCell.self, forCellReuseIdentifier: cellIdentifire)
        
        createPagination()
    }
    
    //MARK: -  Private Methods -
    private func getObjects() {
        var params = JSON.null
        if categoryID.isEmpty {
            params = JSON([
                "limit"             : "\(limit)",
                "offset"            : "\(offset)",
                "type"              : "\(type.rawValue)"])
        } else {
            params = JSON([
                "category_id"       : "\(categoryID)",
                "subcategory_id"    : "\(subcategoryID)",
                "limit"             : "\(limit)",
                "offset"            : "\(offset)",
                "type"              : "\(type.rawValue)"])
        }
        
        output.getObjects(params)
    }
    
    //MARK: - Public Methods -
    func setParams(categoryID: String = "", subcategoryID: String = "", type: ObjectsType = .ALL) {
        self.categoryID     = categoryID
        self.subcategoryID  = subcategoryID
        self.type           = type
    }
    
    //MARK: - Pagination -
    func createPagination() {
        objectsView.tableView.addInfiniteScrollingWithActionHandler {
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
        handleData(objects)
    }
    
    func handleData(newObjects: [AHObject]) {
        if offset == 0 {
            UIHelper.deleteRowsFromTable(objectsView.tableView, objects: &objects)
        }
        
        if isAddMore {
            UIHelper.insertRowsInTable(objectsView.tableView, objects: newObjects, inObjects: &objects, reversable: false)
            
            if newObjects.count < limit {
                objectsView.tableView.showsInfiniteScrolling = false
                isAddMore = false
            } else {
                objectsView.tableView.showsInfiniteScrolling = true
            }
        }
    }
}

//MARK: - extension for UITableView -
extension ObjectsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return objects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire) as! ObjectsCell
        let object = objects[indexPath.row]
        cell.setValues(object)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let object = objects[indexPath.row]
        output.didSelectObject(object)
    }
}

