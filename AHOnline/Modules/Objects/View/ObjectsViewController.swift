//
//  ObjectsViewController.swift
//  AHOnline
//
//  Created by AroHak on 17/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class ObjectsViewController -
class ObjectsViewController: BaseViewController {

    var output: ObjectsViewOutput!

    var objectsView = ObjectsView()
    let cellIdentifire = "cellIdentifire"
    var objects: [AHObject] = []
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Restaurants"
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = objectsView
        
        objectsView.tableView.dataSource = self
        objectsView.tableView.delegate = self
        objectsView.tableView.registerClass(ObjectsCell.self, forCellReuseIdentifier: cellIdentifire)
    }
}

//MARK: - extension for ObjectsViewInput -
extension ObjectsViewController: ObjectsViewInput {
    
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
        output.didSelectObjectRow(object)
    }
}

