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
    let cellIdentifire1 = "cellIdentifire1"
    let cellIdentifire2 = "cellIdentifire2"
    
    var orders: [Product] = []
    var delivers: [String] = ["Choose Place", "Time Delivery"]

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Cart"
        navigationItem.setLeftBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addAction)), animated: true)
        navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        output.viewIsReady()
    }
    
    // MARK: - Internal Method -
    override func baseConfig() {
        self.view = cartView
        
        cartView.tableView.dataSource = self
        cartView.tableView.delegate = self
        cartView.tableView.registerClass(OrderCell.self, forCellReuseIdentifier: cellIdentifire1)
        cartView.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifire2)
    }
    
    //MARK: - Actions -
    func addAction() {

    }
}

//MARK: - extension for CartViewInput -
extension CartViewController: CartViewInput {
    
    func setupInitialState(orders: [Product]) {
        self.orders = orders
        
        cartView.tableView.reloadData()
    }
}

//MARK: - extension for UITableView -
extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return orders.count
            
        case 1:
            return delivers.count
            
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let order = orders[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire1) as! OrderCell
            cell.cellContentView.textField.delegate = self
            cell.setValues(order)

            return cell

        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire2)
            let deliver = delivers[indexPath.row]
            cell?.textLabel?.text = deliver
            cell?.backgroundColor = CLEAR
            
            return cell!
        }
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
        
        switch indexPath.section {
        case 0:
            return 80
        case 1:
            return 40
        default:
            break
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                print("Choose")
            case 1:
                print("Time")
            default:
                break
            }
        }
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            let cell = cartView.tableView.cellForRowAtIndexPath(indexPath) as? OrderCell
            
            if let cell = cell {
                let order = orders[indexPath.row]
                if !editing {
                    view.endEditing(true)
                    
                    let count = cell.cellContentView.textField.text!.isEmpty ? 1 : Int(cell.cellContentView.textField.text!)!
                    output.updateOrder(order, count: count)
                }
                cell.cellContentView.updateValues(editing, product: order)
            }
            
            return true
            
        default:
            return false
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let order = orders[indexPath.row]
            output.removeOrder(order)
            
            orders.removeAtIndex(indexPath.row)
            cartView.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
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

//MARK: - extension for UITextField -
extension CartViewController: UITextFieldDelegate {
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString : String) -> Bool {
        
        return UIHelper.isValidCountTextField(textField, range: range, string: replacementString)
    }
}