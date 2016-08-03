//
//  ContuctUsViewController.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class ContuctUsViewController -
class ContuctUsViewController: BaseViewController {

    var output: ContuctUsViewOutput!
    
    private var contuctUsView = ContuctUsView()
    private let cellIdentifire = "cellIdentifire"
    private var items: [(String, String)] = [("img_co_call" , "+374 98 777777"),
                                             ("img_co_sms" , "+374 93 888888"),
                                             ("img_co_email" , "info@buyonline.am"),
                                             ("img_co_web" , "http://www.buyonline.am")]
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "contact_us".localizedString
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = contuctUsView
        
        contuctUsView.tableView.dataSource = self
        contuctUsView.tableView.delegate = self
        contuctUsView.tableView.registerClass(ContuctUsCell.self, forCellReuseIdentifier: cellIdentifire)
        
        contuctUsView.footerView.facebookButton.addTarget(self, action: #selector(facebookAction), forControlEvents: .TouchUpInside)
        contuctUsView.footerView.twitterButton.addTarget(self, action: #selector(twitterAction), forControlEvents: .TouchUpInside)
        contuctUsView.footerView.youtubeButton.addTarget(self, action: #selector(youtubeAction), forControlEvents: .TouchUpInside)
    }
    
    //MARK: - Actions -
    func facebookAction() {
        output.facebookButtonClicked()
    }
    
    func twitterAction() {
        output.twitterButtonClicked()
    }
    
    func youtubeAction() {
        output.youtubeButtonClicked()
    }
}

//MARK: - extension for ContuctUsViewInput -
extension ContuctUsViewController: ContuctUsViewInput {
    
    func setupInitialState() {
        
    }
}

//MARK: - extension for UITableView -
extension ContuctUsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire) as! ContuctUsCell
        cell.selectionStyle = .Default
        let item = items[indexPath.row]
        cell.setValues(item.0, name: item.1)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return CO_CELL_HEIGHT
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        output.didSelectRow(indexPath.row)
    }
}

