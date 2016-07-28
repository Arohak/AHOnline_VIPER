//
//  FavoriteViewController.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class FavoriteViewController -
class FavoriteViewController: BaseViewController {

    var output: FavoriteViewOutput!

    private var favoriteView = FavoriteView()
    private let cellIdentifire = "cellIdentifire"
    private var items: [String] = []
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "favorite".localizedString
        output.viewIsReady()
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = favoriteView
        
        favoriteView.tableView.dataSource = self
        favoriteView.tableView.delegate = self
        favoriteView.tableView.registerClass(FavoriteCell.self, forCellReuseIdentifier: cellIdentifire)
    }
}

//MARK: - extension for FavoriteViewInput -
extension FavoriteViewController: FavoriteViewInput {
    
    func setupInitialState() {

    }
}

//MARK: - extension for UITableView -
extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire) as! FavoriteCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 0 //CO_CELL_HEIGHT
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
