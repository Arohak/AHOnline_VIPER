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

    private var historyView = HistoryView()
    private let cellIdentifire = "cellIdentifire"
    private var items: [String] = []
    
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
    
    func setupInitialState() {

    }
}

//MARK: - extension for UITableView -
extension HistoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire) as! HistoryCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 0 //CO_CELL_HEIGHT
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
