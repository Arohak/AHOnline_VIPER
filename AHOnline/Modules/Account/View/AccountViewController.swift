//
//  AccountViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class AccountViewController -
class AccountViewController: BaseViewController {

    var output: AccountViewOutput!

    private var accountView: AccountView!
    private let cellIdentifire = "cellIdentifire"
    private var user: User!
    private var menus: [(String, String)] = [("img_all" , "Language"),
                                             ("img_all" , "Notifications"),
                                             ("img_all" , "Contuct us"),
                                             ("img_all" , "About")]
    
    //MARK: - Initilize -
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        
        title = user.name
        accountView = AccountView(user: user, headerRect: CGRect(x: 0, y: 0, width: ScreenSize.WIDTH, height: ScreenSize.HEIGHT*0.3))
        self.user = user
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let headerView = accountView.tableView.tableHeaderView as! ParallaxHeaderView
        headerView.refreshBlurViewForNewImage()
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = accountView
        
        accountView.tableView.dataSource = self
        accountView.tableView.delegate = self
        accountView.tableView.registerClass(AccountCell.self, forCellReuseIdentifier: cellIdentifire)
    }
}


//MARK: - extension for AccountViewInput -
extension AccountViewController: AccountViewInput {
    
    func setupInitialState() {
        
    }
}

//MARK: - extension for UITableView -
extension AccountViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menus.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifire) as! AccountCell
        let menu = menus[indexPath.row]
        cell.setValues(menu.0, name: menu.1)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let menu = menus[indexPath.row]
//        output.didSelectObjectMenuRow(menu)
    }
}

//MARK: - extension for UIScrollView -
extension AccountViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == accountView.tableView {
            if let parallaxHeaderView = accountView.tableView.tableHeaderView as? ParallaxHeaderView {
                parallaxHeaderView.headerViewForScrollViewOffset(scrollView.contentOffset)
            }
        }
    }
}

