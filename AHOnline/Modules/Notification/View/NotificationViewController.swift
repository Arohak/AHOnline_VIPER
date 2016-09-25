//
//  NotificationViewController.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class NotificationViewController -
class NotificationViewController: BaseViewController {

    var output: NotificationViewOutput!

    internal var notificationView = NotificationView()
    internal let cellIdentifire = "cellIdentifire"
    internal var items: [String] = []
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "notification".localizedString
        output.viewIsReady()
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = notificationView
        
        notificationView.tableView.dataSource = self
        notificationView.tableView.delegate = self
        notificationView.tableView.register(NotificationCell.self, forCellReuseIdentifier: cellIdentifire)
    }
}

//MARK: - extension for NotificationViewInput -
extension NotificationViewController: NotificationViewInput {
    
    func setupInitialState() {

    }
}

//MARK: - extension for UITableView -
extension NotificationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire) as! NotificationCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 0 //CO_CELL_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
