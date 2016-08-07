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
    var cleaButtonItem: UIBarButtonItem!
    weak var AddAlertSaveAction: UIAlertAction?

    private let cellIdentifire                      = ["cellIdentifire1", "cellIdentifire2", "cellIdentifire3"]
    private let heights: [CGFloat]                  = [CA_CELL_HEIGHT, CA_CELL_HEIGHT*0.6, CA_CELL_HEIGHT*0.6]
    private var headers: [String]                   = []
    
    
    private var orders: [Product]                   = []
    
    private var deliveryCells: [DeliveryCell]       = []
    private var titleDeliveries: [(String, String)] = []
    
    private var deliveries: [Delivery]              = []
    private var ordersTotalPrice                    = 0.0
    private var deliveryPrice                       = 0.0
    
    private var paymentCells: [UITableViewCell]     = []
    private var titlePayments: [String]             = []
    
    private var selectedPayment                     = ""
    private var selectedPhone                       = "*"
    private var selectedCity                        = "*"
    private var selectedAddress                     = "*"
    private var selectedDate: NSDate!
    private var selectedAlias                       = ""

    private var user: User?
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setLeftBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addAction)), animated: true)
        cleaButtonItem = UIBarButtonItem(title: "clear".localizedString, style: .Plain, target: self, action: #selector(clearAction))
        navigationItem.rightBarButtonItems = [editButtonItem(), cleaButtonItem]
        
        output.getDeliveries()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)), name:UIKeyboardWillChangeFrameNotification, object: nil)
        
        output.getOrders()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(UIKeyboardWillChangeFrameNotification)
    }
    
    // MARK: - Internal Method -
    override func baseConfig() {
        self.view = cartView
        
        cartView.tableView.dataSource = self
        cartView.tableView.delegate = self
        cartView.tableView.registerClass(OrderCell.self, forCellReuseIdentifier: cellIdentifire[0])
    }
    
    override func updateLocalizedStrings() {
        setLocalizedStrings()
    }
    
    // MARK: - Private Method -
    private func setLocalizedStrings() {
        cleaButtonItem.title    = "clear".localizedString
        editButtonItem().title  = "edit".localizedString

        headers             = ["order".localizedString,
                               "delivery".localizedString,
                               "payment".localizedString]
        
        titleDeliveries = [("img_cart_call", "cart_call".localizedString),
                           ("img_cart_address", "cart_address".localizedString),
                           ("img_cart_city", "cart_city".localizedString),
                           ("img_cart_time", "cart_time".localizedString)]
        
        titlePayments = ["pay_on_delivery".localizedString,
                         "credit_cart".localizedString,
                         "paypal".localizedString]
        
        selectedPayment = "pay_on_delivery".localizedString
        
        configTableViewCell()
    }
    
    private func configTableViewCell() {
        deliveryCells.removeAll()
        paymentCells.removeAll()
        
        for tuple in titleDeliveries {
            let cell = DeliveryCell(style: .Default, reuseIdentifier: cellIdentifire[1])
            cell.cellContentView.imageView.image = UIImage(named: tuple.0)
            cell.cellContentView.titleLabel.text = tuple.1
            deliveryCells.append(cell)
        }
        
        for title in titlePayments {
            let cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifire[2])
            cell.backgroundColor = CLEAR
            cell.textLabel?.text = title
            cell.textLabel?.font = TITLE_FONT
            cell.accessoryType = title == selectedPayment ? .Checkmark : .None
            paymentCells.append(cell)
        }
        
        cartView.tableView.reloadData()
    }
    
    private func updateTableViewInfo() {
        if let user = user {
            if !user.phone.isEmpty { selectedPhone = user.phone }
            
            if let address = user.address {
                let delivery = deliveries.filter { $0.alias == address.alias }.first
                if let delivery = delivery {
                    deliveryPrice = delivery.price
                }
                
                selectedAddress = address.add
                selectedCity = address.city
                selectedAlias = address.alias

            } else {
                if let delivery = deliveries.first {
                    deliveryPrice = delivery.price
                    selectedCity = delivery.city
                    selectedAlias = delivery.alias
                }
            }
            
            cartView.footerView.updateValues(ordersTotalPrice, delivery: deliveryPrice)

            deliveryCells[0].cellContentView.deliveryLabel.text = selectedPhone
            deliveryCells[1].cellContentView.deliveryLabel.text = selectedAddress
            deliveryCells[2].cellContentView.deliveryLabel.text = selectedCity
            deliveryCells[3].cellContentView.deliveryLabel.text = NSDate().deliveryTimeFormat
        }
        
        updateView()
    }
    
    private func updateView() {
        cartView.tableView.hidden = orders.count == 0
        cartView.footerView.hidden = cartView.tableView.hidden
        cartView.emptyView.hidden = !cartView.tableView.hidden
        cleaButtonItem.enabled = !cartView.tableView.hidden
        editButtonItem().enabled = !cartView.tableView.hidden
    }
    
    //MARK: - Actions -
    func addAction() {
        output.addOrder()
    }
    
    func clearAction() {
        let alert =  UIAlertController(title: "clear_cart".localizedString, message: "clear_message".localizedString, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "cancel".localizedString, style: .Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "ok".localizedString, style: .Default, handler: { _ in
            self.output.removeOrders(self.orders)
            self.orders.removeAll()
            self.updateView()
        }))
        
        output.presentViewController(alert)
    }
    
    //MARK: - Keyboard notifications -
    func keyboardWillChangeFrame(notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.CGRectValue() {
            let animationDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber) as! NSTimeInterval
            let y = keyboardFrame.origin.y
            
            if AddAlertSaveAction == nil {
                self.view.layoutIfNeeded()
                UIView.animateWithDuration(animationDuration, animations: { _ in
                    if ScreenSize.HEIGHT - y == 0 {
                        self.cartView.heightTableViewConstraint.constant = y - (NAV_HEIGHT + TAB_HEIGHT + CA_CELL_HEIGHT*1.5)
                    } else {
                        self.cartView.heightTableViewConstraint.constant = y - (NAV_HEIGHT)
                    }
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    //MARK: - TextField notification -
    func handlePhoneTextFieldTextDidChangeNotification(notification: NSNotification) {
        let textField = notification.object as! UITextField
        
        AddAlertSaveAction!.enabled = UIHelper.isValidPhoneText(textField.text!)
    }
    
    func handleTextFieldTextDidChangeNotification(notification: NSNotification) {
        let textField = notification.object as! UITextField
        
        AddAlertSaveAction!.enabled = UIHelper.isValidText(textField.text!)
    }
}

//MARK: - extension for CartViewInput -
extension CartViewController: CartViewInput {
    
    func deliveriesComing(deliveries: [Delivery]) {
        self.deliveries = deliveries
        
        updateTableViewInfo()
    }
    
    func ordersComing(user: User, orders: [Product], ordersPrice: Double) {
        self.user = user
        self.orders = orders
        self.ordersTotalPrice = ordersPrice
        
        cartView.tableView.reloadData()
        updateTableViewInfo()
    }
    
    func ordersTotalPrice(ordersPrice: Double) {
        ordersTotalPrice = ordersPrice
        cartView.footerView.updateValues(ordersTotalPrice, delivery: deliveryPrice)
    }
}

//MARK: - extension for UITableView -
extension CartViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return headers.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return orders.count
            
        case 1:
            return deliveryCells.count
            
        case 2:
            return paymentCells.count
            
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let order = orders[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire[0]) as! OrderCell
            cell.cellContentView.textField.delegate = self
            cell.setValues(editing, product: order)

            return cell
        case 1:
            return deliveryCells[indexPath.row]

        case 2:
            return paymentCells[indexPath.row]
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return heights[indexPath.section]
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return headers[section]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 0:
                let alert = UIAlertController(title: "mobile_number".localizedString, message: nil, preferredStyle: .Alert)
                alert.addTextFieldWithConfigurationHandler { textField in
                    textField.keyboardType = .PhonePad
                    textField.keyboardAppearance = .Dark
                    textField.placeholder = "+374 xxxxxxxx"
                    var text = self.selectedPhone
                    text = text == "*" ? "" : text
                    textField.text = text
                    
                    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.handlePhoneTextFieldTextDidChangeNotification), name: UITextFieldTextDidChangeNotification, object: textField)
                }
                
                func removeTextFieldObserver() {
                    NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: alert.textFields?.first)
                }
                
                alert.addAction(UIAlertAction(title: "cancel".localizedString, style: .Cancel, handler: { _ in removeTextFieldObserver() }))
                
                let otherAction = UIAlertAction(title: "save".localizedString, style: .Destructive, handler: { a in
                    let textField = alert.textFields?.first!
                    self.selectedPhone = textField!.text!
                    self.deliveryCells[indexPath.row].cellContentView.deliveryLabel.text = self.selectedPhone
                    
                    removeTextFieldObserver()
                })
                otherAction.enabled = !selectedPhone.isEmpty
                AddAlertSaveAction = otherAction
                
                alert.addAction(otherAction)
                
                output.presentViewController(alert)
                
            case 1:
                let alert = UIAlertController(title: "delivery_address".localizedString, message: nil, preferredStyle: .Alert)
                alert.addTextFieldWithConfigurationHandler { textField in
                    textField.keyboardAppearance = .Dark
                    textField.placeholder = "delivery_address_pl".localizedString
                    var text = self.selectedAddress
                    text = text == "*" ? "" : text
                    textField.text = text
                    
                    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.handleTextFieldTextDidChangeNotification), name: UITextFieldTextDidChangeNotification, object: textField)
                }
                
                func removeTextFieldObserver() {
                    NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: alert.textFields?.first)
                }
                
                alert.addAction(UIAlertAction(title: "cancel".localizedString, style: .Cancel, handler: nil))
                let otherAction = UIAlertAction(title: "save".localizedString, style: .Destructive, handler: { a in
                    let textField = alert.textFields?.first!
                    self.selectedAddress = textField!.text!
                    self.deliveryCells[indexPath.row].cellContentView.deliveryLabel.text = self.selectedAddress
                    
                    removeTextFieldObserver()
                })
                otherAction.enabled = !selectedAddress.isEmpty
                AddAlertSaveAction = otherAction
                
                alert.addAction(otherAction)

                output.presentViewController(alert)
                
            case 2:
                let actionSheet = DeliveryActionSheetPickerViewController(deliveries: deliveries) { delivery, index in
                    self.deliveryCells[indexPath.row].cellContentView.deliveryLabel.text = delivery.city
                    self.deliveryPrice = delivery.price
                    self.cartView.footerView.updateValues(self.ordersTotalPrice, delivery: self.deliveryPrice)
                    self.selectedCity = delivery.city
                    self.selectedAlias = delivery.alias
                }
                actionSheet.pickerView.selectRow(deliveries.indexOf { $0.alias == selectedAlias }! , inComponent: 0, animated: true)
                
                output.presentViewController(actionSheet)
            case 3:
                let datePicker = DatePickerViewController(date: NSDate()) { date in
                    self.deliveryCells[indexPath.row].cellContentView.deliveryLabel.text = date.deliveryTimeFormat
                    self.selectedDate = date
                }
                if let date = selectedDate {
                    datePicker.pickerView.picker.setDate(date, animated: true)
                }
                
                output.presentViewController(datePicker)
            default:
                break
            }
            
        case 2:            
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            for cell in paymentCells { cell.accessoryType = .None }
            paymentCells[indexPath.row].accessoryType = .Checkmark
            selectedPayment = titlePayments[indexPath.row]
            
        default:
            break
        }
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            let cell = tableView.cellForRowAtIndexPath(indexPath) as? OrderCell
            
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
            cartView.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .None)
            updateView()
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