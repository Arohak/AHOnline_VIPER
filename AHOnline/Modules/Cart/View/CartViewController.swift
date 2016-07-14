//
//  CartViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class CartViewController -
class CartViewController: BaseViewController {

    var output: CartViewOutput!

    var cartView = CartView()
    let cellIdentifire = "cellIdentifire"
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Cart"
        navigationItem.setLeftBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addAction)), animated: true)
        navigationItem.rightBarButtonItem = self.editButtonItem()

        output.viewIsReady()
    }
    
    // MARK: - Internal Method -
    override func baseConfig() {
        self.view = cartView
        
        cartView.tableView.dataSource = self
        cartView.tableView.delegate = self
        cartView.tableView.registerClass(OrderCell.self, forCellReuseIdentifier: cellIdentifire)
    }
    
    //MARK: - Actions -
    func addAction() {

    }
}

//MARK: - extension for CartViewInput -
extension CartViewController: CartViewInput {
    
    func setupInitialState() {

    }
}

//MARK: - extension for UITableView -
extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire) as! OrderCell
        cell.setValues()
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "ORDER"
        case 1:
            return "DELIVERY"
        default:
            break
        }
        
        return ""
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 80
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
           cartView.tableView.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        
        return .Delete
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        cartView.tableView.setEditing(editing, animated: animated)
    }
}