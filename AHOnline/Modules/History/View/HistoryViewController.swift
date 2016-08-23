//
//  HistoryViewController.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class HistoryViewController -
class HistoryViewController: BaseViewController {

    var output: HistoryViewOutput!

    private var historyView                     = HistoryView()
    private let cellIdentifire                  = "cellIdentifire"
    private var historyOrders: [HistoryOrder]   = []
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "history".localizedString
        output.viewIsReady()
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = historyView
        
        historyView.tableView.dataSource = self
        historyView.tableView.delegate = self
        historyView.tableView.registerClass(HistoryCell.self, forCellReuseIdentifier: cellIdentifire)
    }
}

//MARK: - extension for HistoryViewInput -
extension HistoryViewController: HistoryViewInput {
    
    func setupInitialState(historyOrders: [HistoryOrder]) {
        self.historyOrders = historyOrders
        
        historyView.tableView.reloadData()
    }
}

//MARK: - extension for UITableView -
extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return historyOrders.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire) as! HistoryCell
        cell.selectionStyle = .Default
        let historyOrder = historyOrders[indexPath.row]
        cell.setValues(historyOrder)
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let historyOrder = historyOrders[indexPath.row]
        output.didSelectHistoryOrder(historyOrder)
    }
}
