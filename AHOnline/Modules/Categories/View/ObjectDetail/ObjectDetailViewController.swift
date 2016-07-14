//
//  ObjectDetailViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ObjectDetailViewController: BaseViewController {
    
    var output: CategoriesViewOutput!

    var objectDetailView: ObjectDetailView!
    let cellIdentifire = "cellIdentifire"
    var objectCategories = [ObjectCategory]()
    
    //MARK: - Initilize -
    init(title: String, detail: ObjectDetail, headerHeight: CGFloat = ScreenSize.HEIGHT*0.3) {
        super.init(nibName: nil, bundle: nil)
        
        objectDetailView = ObjectDetailView(detail: detail, headerRect: CGRect(x: 0, y: 0, width: ScreenSize.WIDTH, height: headerHeight))
        self.objectCategories = detail.objectCategories
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let headerView = objectDetailView.tableView.tableHeaderView as! ParallaxHeaderView
        headerView.refreshBlurViewForNewImage()
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = objectDetailView
        
        objectDetailView.tableView.dataSource = self
        objectDetailView.tableView.delegate = self
        objectDetailView.tableView.registerClass(BaseTableViewCell.self, forCellReuseIdentifier: cellIdentifire)
    }
    
    //MARK: - Actions -
    func favoriteAction(sender: UIButton) {

    }
    
    func downloadAction(sender: UIButton) {

    }
}

//MARK: - extension for UITableView -
extension ObjectDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return objectCategories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire) as! BaseTableViewCell
        let objectCategory = objectCategories[indexPath.row]
        cell.textLabel?.text = objectCategory.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let objectCategory = objectCategories[indexPath.row]
        output.didSelectObjectCategoriesRow(objectCategory)
    }
}

//MARK: - extension for UIScrollView -
extension ObjectDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == objectDetailView.tableView {
            if let parallaxHeaderView = objectDetailView.tableView.tableHeaderView as? ParallaxHeaderView {
                parallaxHeaderView.headerViewForScrollViewOffset(scrollView.contentOffset)
            }
        }
    }
}