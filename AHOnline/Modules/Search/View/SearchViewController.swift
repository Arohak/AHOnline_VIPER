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
    var titles: [String] = []
    var descs: [String] = []
    var items: [[AHObject]] = []
    var heights: [CGFloat] = []
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        output.viewIsReady()
    }
    
    // MARK: - Internal Method -
    override func baseConfig() {
        self.view = searchView
        
        configureNavigationBar()

        searchView.tableView.dataSource = self
        searchView.tableView.delegate = self
        searchView.tableView.registerClass(HomeCell.self, forCellReuseIdentifier: cellIdentifire)
        
        searchView.textField.delegate = self
        let filterButton = navigationItem.rightBarButtonItem?.customView as! HOButton
        filterButton.addTarget(self, action: #selector(filterAction), forControlEvents: .TouchUpInside)
    }
    
    private func configureNavigationBar() {
        title = "Search"
        navigationItem.titleView = searchView.textField
        navigationItem.setRightBarButtonItem(searchView.rightItem, animated: true)
    }
    
    
    //MARK: - CallBacks Methods -
    func didSelectCollectionAtIndexPath(indexPath: NSIndexPath) {
//        let object = items[indexPath.section][indexPath.row]
//        if object.id != 0 {
//            output.didSelectObject(object)
//        } else {
//            var type: ObjectsType = .New
//            switch indexPath.section {
//            case 0:
//                type = .New
//            case 1:
//                type = .Rate
//            case 2:
//                type = .Open
//            default:
//                break
//            }
//            output.didSelectObjectForType(type)
//        }
    }
    
    //MARK: - Actions -
    func filterAction() {
//        output.filterButtonClicked()
    }
}

//MARK: - extension for SearchViewInput -
extension SearchViewController: SearchViewInput {
    
    func setupInitialState() {
        
    }

    func setupInitialState(home: Home) {
        titles = ["New Restaurants", "Rate Restaurants", "Open Restaurants"]
        descs = ["", "", ""]
        heights = [ScreenSize.HEIGHT*0.25, ScreenSize.HEIGHT*0.25, ScreenSize.HEIGHT*0.3]
        
        items.append([AHObject]())
        items.append([AHObject]())
        items.append([AHObject]())
        
        let existRestaurant = AHObject(data: JSON(["img" : "img_all"]))
        items[0] = Array(home.newRestaurants)
        items[0].append(existRestaurant)
        items[1] = Array(home.rateRestaurants)
        items[1].append(existRestaurant)
        items[2] = Array(home.openRestaurants)
        items[2].append(existRestaurant)
        
        searchView.tableView.reloadData()
    }
}

//MARK: - extension for UITableView -
extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire) as! HomeCell
        cell.setValues(indexPath.row,
                       title:   titles[indexPath.row],
                       desc:    descs[indexPath.row],
                       items:   items[indexPath.row],
                       height:  heights[indexPath.row],
                       inset:   0,
                       callBack: didSelectCollectionAtIndexPath)
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return heights[indexPath.row]
    }
}

//MARK: - extension for UITextFieldDelegate -
extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.text!.characters.count < 3 {
            UIHelper.showHUD("search text min 3 simbol")
        } else {
            
        }
        return true
    }
}

