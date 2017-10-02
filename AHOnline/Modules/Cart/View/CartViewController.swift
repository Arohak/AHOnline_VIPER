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
    
    internal var cartView = CartView()
    internal var clearButtonItem: UIBarButtonItem!
    internal let cellIdentifire                      = ["cellIdentifire1", "cellIdentifire2", "cellIdentifire3"]
    internal let heights: [CGFloat]                  = [CA_CELL_HEIGHT, CA_CELL_HEIGHT*0.6, CA_CELL_HEIGHT*0.6]
    internal var headers: [String]                   = []
    internal var deliveryCells: [DeliveryCell]       = []
    internal var titleDeliveries: [(String, String)] = []
    internal var paymentCells: [DeliveryCell]     = []
    internal var titlePayments: [(String, String)]   = []
    internal weak var AddAlertSaveAction: UIAlertAction?

    internal var user: User?
    internal var cart: Cart {
        if let user = user {
            return user.cart
        }
        return Cart(data: JSON.null)
    }
    internal var products: [Product] {
        return Array(cart.products).reversed()
    }
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.setLeftBarButton(UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAction)), animated: true)
        clearButtonItem = UIBarButtonItem(title: "clear".localizedString, style: .plain, target: self, action: #selector(clearAction))
        navigationItem.rightBarButtonItems = [editButtonItem, clearButtonItem]
        
        output.getDeliveries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name:NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        output.getUser()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    // MARK: - Internal Method -
    override func baseConfig() {
        self.view = cartView
        
        cartView.tableView.dataSource = self
        cartView.tableView.delegate = self
        cartView.tableView.register(OrderCell.self, forCellReuseIdentifier: cellIdentifire[0])
        cartView.footerView.orderButton.addTarget(self, action: #selector(placeOrderAction), for: .touchUpInside)
    }
    
    override func updateLocalizedStrings() {
        cartView.updateLocalizedStrings()
        setLocalizedStrings()
    }

    internal func setLocalizedStrings() {
        clearButtonItem.title   = "clear".localizedString
        editButtonItem.title    = isEditing ? "done".localizedString : "edit".localizedString

        headers                 = ["order".localizedString,
                                   "delivery".localizedString,
                                   "payment".localizedString]
        
        titleDeliveries         = [("img_cart_call", "cart_call".localizedString),
                                    ("img_cart_address", "cart_address".localizedString),
                                    ("img_cart_city", "cart_city".localizedString),
                                    ("img_cart_time", "cart_time".localizedString)]
        
        titlePayments           = [("img_cash_logo", "pay_on_delivery".localizedString)]
        
//        titlePayments           = [("img_cash_logo", "pay_on_delivery".localizedString),
//                                   ("img_cart_logo", "credit_cart".localizedString),
//                                   ("img_paypal_logo", "paypal".localizedString)]
    }
    
    internal func configTableViewCell() {
        deliveryCells.removeAll()
        paymentCells.removeAll()
        
        for tuple in titleDeliveries {
            let cell = DeliveryCell(style: .default, reuseIdentifier: cellIdentifire[1])
            cell.cellContentView.imageView.image = UIImage(named: tuple.0)
            cell.cellContentView.titleLabel.text = tuple.1
            deliveryCells.append(cell)
        }
        
        for tuple in titlePayments {
            let cell = DeliveryCell(style: .default, reuseIdentifier: cellIdentifire[2])
            cell.cellContentView.imageView.image = UIImage(named: tuple.0)
            cell.cellContentView.titleLabel.text = tuple.1
            cell.accessoryType = .checkmark
//            cell.accessoryType = tuple.1 == cart.payment ? .checkmark : .none
            paymentCells.append(cell)
        }
        
        deliveryCells[0].cellContentView.deliveryLabel.text = cart.mobileNumber
        deliveryCells[1].cellContentView.deliveryLabel.text = cart.deliveryAddress
        deliveryCells[2].cellContentView.deliveryLabel.text = cart.deliveryCity
        deliveryCells[3].cellContentView.deliveryLabel.text = Date().deliveryTimeFormat
        
        cartView.footerView.updateValues(orderPrice: cart.ordersTotalPrice, delivery: cart.deliveryPrice)
        
        cartView.tableView.reloadData()
        updateView()
    }
    
    internal func updateView() {
        cartView.tableView.isHidden = (user?.cart?.products.count == 0 || user == nil) ? true : false
        cartView.footerView.isHidden = cartView.tableView.isHidden
        cartView.emptyView.isHidden = !cartView.tableView.isHidden
        clearButtonItem.isEnabled = !cartView.tableView.isHidden
        editButtonItem.isEnabled = !cartView.tableView.isHidden
    }
    
    internal func updateCartInfo() {
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
                
            } else if let delivery = cart.deliveries.first , cart.deliveryPrice == 0.0 {
                deliveryPrice = delivery.price
                deliveryCity = delivery.city
                deliveryAlias = delivery.alias
            }
        }
        
        self.output.updateCart(phone: mobileNumber,
                               address: deliveryAddress,
                               city: deliveryCity,
                               alias: deliveryAlias,
                               deliveryPrice: deliveryPrice,
                               date: self.cart.deliveryDate,
                               payment: self.cart.payment)
        

        configTableViewCell()
    }
    
    internal func validInputParams() -> Bool {
        var isValid = true
        if cart.mobileNumber == "*"     { isValid =  false }
        if cart.deliveryAddress == "*"  { isValid =  false }

        return isValid
    }
    
    internal func verifyMobileNumber() {
        if let user = user , user.isVerified && user.phone == cart.mobileNumber {
            placeOrder()
        } else {
            output.sendMobileNumber(number: cart.mobileNumber)
        }
    }
    
    internal func placeOrder() {
        let alert = UIAlertController(title: "caption".localizedString, message: "place_order_msg".localizedString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel".localizedString, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "ok".localizedString, style: .destructive, handler: { _ in
            let json = JSON([
                "title"                 : "",
                "date_create"           : Date().createTimeFormat,
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
            historyOrder.addHistoryProductFrom(products: self.products)
            
            self.output.placeOrder(historyOrder: historyOrder)
        }))
        
        output.presentViewController(vc: alert)
    }
    
    //MARK: - Actions -
    func addAction() {
        output.addOrder()
    }
    
    func clearAction() {
        let alert =  UIAlertController(title: "caption".localizedString, message: "clear_message".localizedString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel".localizedString, style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "ok".localizedString, style: .default, handler: { _ in
            self.output.removeOrders()
            self.updateView()
        }))
        
        output.presentViewController(vc: alert)
    }

    func placeOrderAction() {
        if validInputParams() {
            verifyMobileNumber()
        } else {
            UIHelper.showHUD(message: "invalid_params".localizedString)
        }
    }
    
    //MARK: - Keyboard notifications -
    func keyboardWillChangeFrame(notification: NSNotification) {
        if let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let animationDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber) as! TimeInterval
            let y = keyboardFrame.origin.y
            
            if AddAlertSaveAction == nil {
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: animationDuration, animations: { _ in
                    if Screen.height - y == 0 {
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
        
        AddAlertSaveAction!.isEnabled = UIHelper.isValidPhoneText(text: textField.text!)
    }
    
    func handleTextFieldTextDidChangeNotification(notification: NSNotification) {
        let textField = notification.object as! UITextField
        
        AddAlertSaveAction!.isEnabled = UIHelper.isValidText(text: textField.text!)
    }
}

//MARK: - extension for CartViewInput -
extension CartViewController: CartViewInput {
    
    func userComing(user: User) {
        self.user = user
     
        updateCartInfo()
    }
    
    func updateTotalPrice() {
        cartView.footerView.updateValues(orderPrice: cart.ordersTotalPrice, delivery: cart.deliveryPrice)
    }
    
    func showAlertForVerify() {
        let alert = UIAlertController(title: "verify".localizedString, message: "send_verify_message".localizedString, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.keyboardAppearance = .dark
            textField.placeholder = "pin".localizedString
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextFieldTextDidChangeNotification), name: NSNotification.Name.UITextFieldTextDidChange, object: textField)
        }
        
        func removeTextFieldObserver() {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: alert.textFields?.first)
        }
        
        alert.addAction(UIAlertAction(title: "cancel".localizedString, style: .cancel, handler: { _ in removeTextFieldObserver() }))
        let otherAction = UIAlertAction(title: "accept".localizedString, style: .destructive, handler: { _ in
            self.output.acceptButtonClicked(pin: (alert.textFields?.first?.text)!)
            
            removeTextFieldObserver()
        })
        otherAction.isEnabled = !(alert.textFields?.first!.text!.isEmpty)!
        AddAlertSaveAction = otherAction
        alert.addAction(otherAction)
        
        output.presentViewController(vc: alert)
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return headers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire[0]) as! OrderCell
            cell.cellContentView.textField.delegate = self
            let product = products[indexPath.row]
            cell.setValues(state: isEditing, product: product)

            return cell
        case 1:
            return deliveryCells[indexPath.row]

        case 2:
            return paymentCells[indexPath.row]
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heights[indexPath.section]
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 0:
                let alert = UIAlertController(title: "mobile_number".localizedString, message: nil, preferredStyle: .alert)
                alert.addTextField { textField in
                    textField.keyboardType = .phonePad
                    textField.keyboardAppearance = .dark
                    textField.placeholder = "+374 xxxxxxxx"
                    var text = self.cart.mobileNumber
                    text = text == "*" ? "" : text
                    textField.text = text
                    
                    NotificationCenter.default.addObserver(self, selector: #selector(self.handlePhoneTextFieldTextDidChangeNotification), name: NSNotification.Name.UITextFieldTextDidChange, object: textField)
                }
                
                func removeTextFieldObserver() {
                    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: alert.textFields?.first)
                }
                
                alert.addAction(UIAlertAction(title: "cancel".localizedString, style: .cancel, handler: { _ in removeTextFieldObserver() }))
                let otherAction = UIAlertAction(title: "save".localizedString, style: .destructive, handler: { a in
                    let textField = alert.textFields?.first!
                    let mobileNumber = textField!.text!
                    self.deliveryCells[indexPath.row].cellContentView.deliveryLabel.text = mobileNumber
                    
                    self.output.updateCart(phone: mobileNumber,
                        address: self.cart.deliveryAddress,
                        city: self.cart.deliveryCity,
                        alias: self.cart.deliveryAlias,
                        deliveryPrice: self.cart.deliveryPrice,
                        date: self.cart.deliveryDate,
                        payment: self.cart.payment)
                    
                    removeTextFieldObserver()
                })
                otherAction.isEnabled = !cart.mobileNumber.isEmpty && cart.mobileNumber != "*"
                AddAlertSaveAction = otherAction
                alert.addAction(otherAction)
                
                output.presentViewController(vc: alert)
                
            case 1:
                let alert = UIAlertController(title: "delivery_address".localizedString, message: nil, preferredStyle: .alert)
                alert.addTextField { textField in
                    textField.keyboardAppearance = .dark
                    textField.placeholder = "delivery_address_pl".localizedString
                    var text = self.cart.deliveryAddress
                    text = text == "*" ? "" : text
                    textField.text = text
                    
                    NotificationCenter.default.addObserver(self, selector: #selector(self.handleTextFieldTextDidChangeNotification), name: NSNotification.Name.UITextFieldTextDidChange, object: textField)
                }
                
                func removeTextFieldObserver() {
                    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextFieldTextDidChange, object: alert.textFields?.first)
                }
                
                alert.addAction(UIAlertAction(title: "cancel".localizedString, style: .cancel, handler: nil))
                let otherAction = UIAlertAction(title: "save".localizedString, style: .destructive, handler: { a in
                    let textField = alert.textFields?.first!
                    let address = textField!.text!
                    self.deliveryCells[indexPath.row].cellContentView.deliveryLabel.text = address
                    
                    self.output.updateCart(phone: self.cart.mobileNumber,
                        address: address,
                        city: self.cart.deliveryCity,
                        alias: self.cart.deliveryAlias,
                        deliveryPrice: self.cart.deliveryPrice,
                        date: self.cart.deliveryDate,
                        payment: self.cart.payment)
                    
                    removeTextFieldObserver()
                })
                otherAction.isEnabled = !cart.deliveryAddress.isEmpty && cart.deliveryAddress != "*"
                AddAlertSaveAction = otherAction
                alert.addAction(otherAction)

                output.presentViewController(vc: alert)
                
            case 2:
                let actionSheet = DeliveryActionSheetPickerViewController(deliveries: Array(cart.deliveries)) { delivery, index in
                    self.deliveryCells[indexPath.row].cellContentView.deliveryLabel.text = delivery.city
                    self.cartView.footerView.updateValues(orderPrice: self.cart.ordersTotalPrice, delivery: delivery.price)
                    
                    self.output.updateCart(phone: self.cart.mobileNumber,
                                           address: self.cart.deliveryAddress,
                                           city: delivery.city,
                                           alias: delivery.alias,
                                           deliveryPrice: delivery.price,
                                           date: self.cart.deliveryDate,
                                           payment: self.cart.payment)
                }
                var index = 0
                let findIndex = Array(cart.deliveries).index { $0.alias == cart.deliveryAlias }
                if let i = findIndex { index = i }
                actionSheet.pickerView.selectRow(index , inComponent: 0, animated: true)
                
                output.presentViewController(vc: actionSheet)
            case 3:
                let selectedDate = cart.deliveryDate == nil ? Date() : cart.deliveryDate
                let datePicker = ActionSheetDatePicker(title: "choose_date".localizedString,
                                                       datePickerMode: .dateAndTime,
                                                       selectedDate: selectedDate,
                                                       doneBlock: { picker, value, index in
                                                        
                                                        let date = (value as! Date)
                                                        self.deliveryCells[indexPath.row].cellContentView.deliveryLabel.text = date.deliveryTimeFormat
                                                        self.output.updateCart(phone: self.cart.mobileNumber,
                                                                               address: self.cart.deliveryAddress,
                                                                               city: self.cart.deliveryCity,
                                                                               alias: self.cart.deliveryAlias,
                                                                               deliveryPrice: self.cart.deliveryPrice,
                                                                               date: date,
                                                                               payment: self.cart.payment)
                            
                                                        
                    }, cancel: nil,
                       origin: self.cartView)
                
                datePicker?.minimumDate = Date()
                datePicker?.locale = Locale(identifier: "en_GB")
                datePicker?.show()

            default:
                break
            }
            
        case 2:            
            tableView.deselectRow(at: indexPath, animated: true)
            for cell in paymentCells { cell.accessoryType = .none }
            paymentCells[indexPath.row].accessoryType = .checkmark
            
            self.output.updateCart(phone: self.cart.mobileNumber,
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

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.section {
        case 0:
            let cell = tableView.cellForRow(at: indexPath) as? OrderCell
            
            if let cell = cell {
                let product = products[indexPath.row]
                if !isEditing {
                    view.endEditing(true)

                    let count = cell.cellContentView.textField.text!.isEmpty ? 1 : Int(cell.cellContentView.textField.text!)!
                    output.updateOrder(product: product, count: count)
                }
                cell.cellContentView.updateValues(state: isEditing, product: product)
            }
        
            return true
            
        default:
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let product = products[indexPath.row]
            output.removeOrder(product: product)

            cartView.tableView.deleteRows(at: [indexPath], with: .none)
            updateView()
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        cartView.tableView.setEditing(editing, animated: animated)
        editButtonItem.title = editing ? "done".localizedString : "edit".localizedString
    }
}

//MARK: - extension for UITextField -
extension CartViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString : String) -> Bool {
        return UIHelper.isValidCountTextField(textField: textField, range: range, string: replacementString)
    }
}
