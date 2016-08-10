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
    
    private var deliveryCells: [DeliveryCell]       = []
    private var titleDeliveries: [(String, String)] = []
    private var paymentCells: [UITableViewCell]     = []
    private var titlePayments: [(String, String)]   = []

    var user: User?
    var cart: Cart {
        if let user = user { return user.cart }
        return Cart(data: JSON.null)
    }
    private var products: List<Product> {
        return cart.products
    }
    
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
        
        output.getUser()
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
        cartView.footerView.orderButton.addTarget(self, action: #selector(placeOrderAction), forControlEvents: .TouchUpInside)
    }
    
    override func updateLocalizedStrings() {
        setLocalizedStrings()
    }

    // MARK: - Private Method -
    private func setLocalizedStrings() {
        cleaButtonItem.title    = "clear".localizedString
        editButtonItem().title  = "edit".localizedString

        headers                 = ["order".localizedString,
                                   "delivery".localizedString,
                                   "payment".localizedString]
        
        titleDeliveries         = [("img_cart_call", "cart_call".localizedString),
                                    ("img_cart_address", "cart_address".localizedString),
                                    ("img_cart_city", "cart_city".localizedString),
                                    ("img_cart_time", "cart_time".localizedString)]
        
        titlePayments           = [("img_cash_logo", "pay_on_delivery".localizedString),
                                   ("img_cart_logo", "credit_cart".localizedString),
                                   ("img_paypal_logo", "paypal".localizedString)]
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
        
        for tuple in titlePayments {
            let cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifire[2])
            cell.backgroundColor = CLEAR
            cell.imageView!.image = UIImage(named: tuple.0)
            cell.textLabel?.text = tuple.1
            cell.textLabel?.font = TITLE_FONT
            cell.accessoryType = tuple.1 == cart.payment ? .Checkmark : .None
            paymentCells.append(cell)
        }
        
        deliveryCells[0].cellContentView.deliveryLabel.text = cart.mobileNumber
        deliveryCells[1].cellContentView.deliveryLabel.text = cart.deliveryAddress
        deliveryCells[2].cellContentView.deliveryLabel.text = cart.deliveryCity
        deliveryCells[3].cellContentView.deliveryLabel.text = NSDate().deliveryTimeFormat
        
        cartView.footerView.updateValues(cart.ordersTotalPrice, delivery: cart.deliveryPrice)
        
        cartView.tableView.reloadData()
        updateView()
    }
    
    private func updateView() {
        cartView.tableView.hidden = (user?.cart?.products.count == 0 || user == nil) ? true : false
        cartView.footerView.hidden = cartView.tableView.hidden
        cartView.emptyView.hidden = !cartView.tableView.hidden
        cleaButtonItem.enabled = !cartView.tableView.hidden
        editButtonItem().enabled = !cartView.tableView.hidden
    }
    
    private func updateCartInfo() {
        var mobileNumber    = cart.mobileNumber
        var deliveryAddress = cart.deliveryAddress
        var deliveryCity    = cart.deliveryCity
        var deliveryAlias   = cart.deliveryAlias
        var deliveryPrice   = cart.deliveryPrice

        if let user = user {
            if !user.phone.isEmpty {
                mobileNumber = user.phone
            }
            
            if let address = user.address {
                let delivery = cart.deliveries.filter { $0.alias == address.alias }.first
                if let delivery = delivery {
                    deliveryPrice = delivery.price
                }
                
                deliveryAddress = address.add
                deliveryCity = address.city
                deliveryAlias = address.alias
                
            } else if let delivery = cart.deliveries.first where cart.deliveryPrice == 0.0 {
                deliveryPrice = delivery.price
                deliveryCity = delivery.city
                deliveryAlias = delivery.alias
            }
        }
        
        self.output.updateCart(mobileNumber,
                               address: deliveryAddress,
                               city: deliveryCity,
                               alias: deliveryAlias,
                               deliveryPrice: deliveryPrice,
                               date: self.cart.deliveryDate,
                               payment: self.cart.payment)
        

        configTableViewCell()
    }
    
    private func validInputParams() -> Bool {
        var isValid = true
        if cart.mobileNumber == "*"     { isValid =  false }
        if cart.deliveryAddress == "*"   { isValid =  false }

        return isValid
    }
    
    private func verifyMobileNumber() {
        if let user = user where user.isVerified && user.phone == cart.mobileNumber {
            placeOrder()
        } else {
            output.sendMobileNumber(cart.mobileNumber)
        }
    }
    
    private func placeOrder() {
        let alert = UIAlertController(title: "AAA BBB CCC".localizedString, message: "aaa bbb ccc", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "cancel".localizedString, style: .Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "ok".localizedString, style: .Destructive, handler: { _ in
            let json = JSON([
                "title"                 : "",
                "date_create"           : NSDate().createTimeFormat,
                "mobile_number"         : self.cart.mobileNumber,
                "delivery_address"      : self.cart.deliveryAddress,
                "delivery_city"         : self.cart.deliveryCity,
                "delivery_alias"        : self.cart.deliveryAlias,
                "delivery_date"         : self.cart.deliveryDate.deliveryTimeFormat,
                "payment"               : self.cart.payment,
                "orders_total_price"    : self.cart.ordersTotalPrice,
                "delivery_price"        : self.cart.deliveryPrice,
                "total_price"           : self.cart.ordersTotalPrice + self.cart.deliveryPrice
                ])
            
            let historyOrder = HistoryOrder(data: json)
            historyOrder.addHistoryProductFrom(self.products)
            
            self.output.placeOrder(historyOrder)
        }))
        
        output.presentViewController(alert)
    }
    
    //MARK: - Actions -
    func addAction() {
        output.addOrder()
    }
    
    func clearAction() {
        let alert =  UIAlertController(title: "clear_cart".localizedString, message: "clear_message".localizedString, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "cancel".localizedString, style: .Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "ok".localizedString, style: .Default, handler: { _ in
            self.output.removeOrders()
            self.updateView()
        }))
        
        output.presentViewController(alert)
    }

    func placeOrderAction() {
        if validInputParams() {
            verifyMobileNumber()
        } else {
            UIHelper.showHUD("invalid_params".localizedString)
        }
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
    
    func userComing(user: User) {
        self.user = user
     
        updateCartInfo()
    }
    
    func updateTotalPrice() {
        cartView.footerView.updateValues(cart.ordersTotalPrice, delivery: cart.deliveryPrice)
    }
    
    func showAlertForVerify() {
        let alert = UIAlertController(title: "verify".localizedString, message: nil, preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { textField in
            textField.keyboardAppearance = .Dark
            textField.placeholder = "pin".localizedString
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.handleTextFieldTextDidChangeNotification), name: UITextFieldTextDidChangeNotification, object: textField)
        }
        
        func removeTextFieldObserver() {
            NSNotificationCenter.defaultCenter().removeObserver(self, name: UITextFieldTextDidChangeNotification, object: alert.textFields?.first)
        }
        
        alert.addAction(UIAlertAction(title: "cancel".localizedString, style: .Cancel, handler: { _ in removeTextFieldObserver() }))
        let otherAction = UIAlertAction(title: "accept".localizedString, style: .Destructive, handler: { _ in
            self.output.acceptButtonClicked((alert.textFields?.first?.text)!)
            
            removeTextFieldObserver()
        })
        otherAction.enabled = !(alert.textFields?.first!.text!.isEmpty)!
        AddAlertSaveAction = otherAction
        alert.addAction(otherAction)
        
        output.presentViewController(alert)
    }
    
    func acceptVerification() {
        placeOrder()
    }
    
    func updateViewAfterPlaceOrder() {
        updateView()
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
            return products.count
            
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
            let product = products[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire[0]) as! OrderCell
            cell.cellContentView.textField.delegate = self
            cell.setValues(editing, product: product)

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
                    var text = self.cart.mobileNumber
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
                    let mobileNumber = textField!.text!
                    self.deliveryCells[indexPath.row].cellContentView.deliveryLabel.text = mobileNumber
                    
                    self.output.updateCart(mobileNumber,
                        address: self.cart.deliveryAddress,
                        city: self.cart.deliveryCity,
                        alias: self.cart.deliveryAlias,
                        deliveryPrice: self.cart.deliveryPrice,
                        date: self.cart.deliveryDate,
                        payment: self.cart.payment)
                    
                    removeTextFieldObserver()
                })
                otherAction.enabled = !cart.mobileNumber.isEmpty && cart.mobileNumber != "*"
                AddAlertSaveAction = otherAction
                alert.addAction(otherAction)
                
                output.presentViewController(alert)
                
            case 1:
                let alert = UIAlertController(title: "delivery_address".localizedString, message: nil, preferredStyle: .Alert)
                alert.addTextFieldWithConfigurationHandler { textField in
                    textField.keyboardAppearance = .Dark
                    textField.placeholder = "delivery_address_pl".localizedString
                    var text = self.cart.deliveryAddress
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
                    let address = textField!.text!
                    self.deliveryCells[indexPath.row].cellContentView.deliveryLabel.text = address
                    
                    self.output.updateCart(self.cart.mobileNumber,
                        address: address,
                        city: self.cart.deliveryCity,
                        alias: self.cart.deliveryAlias,
                        deliveryPrice: self.cart.deliveryPrice,
                        date: self.cart.deliveryDate,
                        payment: self.cart.payment)
                    
                    removeTextFieldObserver()
                })
                otherAction.enabled = !cart.deliveryAddress.isEmpty && cart.deliveryAddress != "*"
                AddAlertSaveAction = otherAction
                alert.addAction(otherAction)

                output.presentViewController(alert)
                
            case 2:
                let actionSheet = DeliveryActionSheetPickerViewController(deliveries: Array(cart.deliveries)) { delivery, index in
                    self.deliveryCells[indexPath.row].cellContentView.deliveryLabel.text = delivery.city
                    self.cartView.footerView.updateValues(self.cart.ordersTotalPrice, delivery: delivery.price)
                    
                    self.output.updateCart(self.cart.mobileNumber,
                                           address: self.cart.deliveryAddress,
                                           city: delivery.city,
                                           alias: delivery.alias,
                                           deliveryPrice: delivery.price,
                                           date: self.cart.deliveryDate,
                                           payment: self.cart.payment)
                }
                actionSheet.pickerView.selectRow(Array(cart.deliveries).indexOf { $0.alias == cart.deliveryAlias }! , inComponent: 0, animated: true)
                
                output.presentViewController(actionSheet)
            case 3:
                let datePicker = DatePickerViewController(date: NSDate()) { date in
                    self.deliveryCells[indexPath.row].cellContentView.deliveryLabel.text = date.deliveryTimeFormat
                    
                    self.output.updateCart(self.cart.mobileNumber,
                                           address: self.cart.deliveryAddress,
                                           city: self.cart.deliveryCity,
                                           alias: self.cart.deliveryAlias,
                                           deliveryPrice: self.cart.deliveryPrice,
                                           date: date,
                                           payment: self.cart.payment)
                }
                if let date = cart.deliveryDate {
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
            
            self.output.updateCart(self.cart.mobileNumber,
                                   address: self.cart.deliveryAddress,
                                   city: self.cart.deliveryCity,
                                   alias: self.cart.deliveryAlias,
                                   deliveryPrice: self.cart.deliveryPrice,
                                   date: self.cart.deliveryDate,
                                   payment: titlePayments[indexPath.row].1)
        default:
            break
        }
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            let cell = tableView.cellForRowAtIndexPath(indexPath) as? OrderCell
            
            if let cell = cell {
                let product = products[indexPath.row]
                if !editing {
                    view.endEditing(true)

                    let count = cell.cellContentView.textField.text!.isEmpty ? 1 : Int(cell.cellContentView.textField.text!)!
                    output.updateOrder(product, count: count)
                }
                cell.cellContentView.updateValues(editing, product: product)
            }
        
            return true
            
        default:
            return false
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let product = products[indexPath.row]
            output.removeOrder(product)

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