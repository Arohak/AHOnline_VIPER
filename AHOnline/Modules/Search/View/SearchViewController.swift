//
//  SearchViewController.swift
//  AHOnline
//
//  Created by AroHak on 19/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class SearchViewController -
class SearchViewController: BaseViewController {

    var output: SearchViewOutput!

    var searchView = SearchView()
    let cellIdentifire = "cellIdentifire"
    var isAnimation = true
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewIsReady()
    }
    
    // MARK: - Internal Method -
    override func baseConfig() {
        self.view = searchView
        
        configureNavigationBar()

//        searchView.tableView.dataSource = self
//        searchView.tableView.delegate = self
//        searchView.tableView.registerClass(HomeCell.self, forCellReuseIdentifier: cellIdentifire)
        
        searchView.textField.delegate = self
        let filterButton = navigationItem.rightBarButtonItem?.customView as! HOButton
        filterButton.addTarget(self, action: #selector(filterAction), forControlEvents: .TouchUpInside)
    }
    
    private func configureNavigationBar() {
        title = "Search"
        navigationItem.titleView = searchView.textField
//        navigationItem.setRightBarButtonItem(searchView.rightItem, animated: true)
    }
    
    
    //MARK: - CallBacks Methods -
    func didSelectCollectionAtIndexPath(indexPath: NSIndexPath) {

    }
    
    //MARK: - Actions -
    func filterAction() {
        animationFilterView()
//        output.filterButtonClicked()
    }
    
    func animationFilterView() {
//        if isAnimation {
//            UIView.animateWithDuration(0.5, animations: {
//                self.searchView.filterView.alpha = 1
//            }) { finish in
//                self.isAnimation = !self.isAnimation
//            }
//        } else {
//            UIView.animateWithDuration(0.5, animations: {
//                self.searchView.filterView.alpha = 0
//            }) { finish in
//                self.isAnimation = !self.isAnimation
//            }
//        }
    }
}

//MARK: - extension for SearchViewInput -
extension SearchViewController: SearchViewInput {
    
    func setupInitialState() {
        
    }
}

//MARK: - extension for UITableView -
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire) as! HomeCell
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return SE_CELL_HEIGHT
    }
}

//MARK: - extension for UITextFieldDelegate -
extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.text!.characters.count < 3 {
            UIHelper.showHUD("search text min 3 simbol")
        } else {
            textField.resignFirstResponder()
            let json = JSON(["search": textField.text!])
            output.search(json)
        }
        return true
    }
}

