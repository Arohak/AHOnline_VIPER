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

    private var notificationView = NotificationView()
    private let cellIdentifire = "cellIdentifire"
    private var items: [String] = []
    
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
        notificationView.tableView.registerClass(NotificationCell.self, forCellReuseIdentifier: cellIdentifire)
    }
}

//MARK: - extension for NotificationViewInput -
extension NotificationViewController: NotificationViewInput {
    
    func setupInitialState() {

    }
}

//MARK: - extension for UITableView -
extension NotificationViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire) as! NotificationCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 0 //CO_CELL_HEIGHT
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
}
