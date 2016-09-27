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

    internal var historyView                     = HistoryView()
    internal let cellIdentifire                  = "cellIdentifire"
    internal var historyOrders: [HistoryOrder]   = []
    
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
        historyView.tableView.register(HistoryCell.self, forCellReuseIdentifier: cellIdentifire)
    }
}

//MARK: - extension for HistoryViewInput -
extension HistoryViewController: HistoryViewInput {
    
    func setupInitialState(historyOrders: [HistoryOrder]) {
        self.historyOrders = historyOrders.reversed()
        
        historyView.tableView.reloadData()
    }
}

//MARK: - extension for UITableView -
extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return historyOrders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire) as! HistoryCell
        cell.selectionStyle = .default
        let historyOrder = historyOrders[indexPath.row]
        cell.setValues(historyOrder: historyOrder)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let historyOrder = historyOrders[indexPath.row]
        output.didSelectHistoryOrder(historyOrder: historyOrder)
    }
}
