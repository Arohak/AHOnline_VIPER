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

    private var accountView = AccountView()
    private let cellIdentifire = "cellIdentifire"
    private var user: User?
    private var cells: [AccountCell] = []
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        output.viewIsReady()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let headerView = accountView.tableView.tableHeaderView as! ParallaxHeaderView
        headerView.refreshBlurViewForNewImage()
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = accountView
        
        navigationItem.setRightBarButtonItem(UIBarButtonItem(image: UIImage(named: "img_acc_settings"), style: .Plain, target: self, action: #selector(settingsAction)), animated: true)

        accountView.tableView.dataSource = self
        accountView.tableView.delegate = self
        accountView.tableView.registerClass(AccountCell.self, forCellReuseIdentifier: cellIdentifire)
        
        accountView.accountHeaderView.historyButton.addTarget(self, action: #selector(historyAction), forControlEvents: .TouchUpInside)
        accountView.accountHeaderView.favoriteButton.addTarget(self, action: #selector(favoriteAction), forControlEvents: .TouchUpInside)
        
        updateLocalizedStrings()
    }
    
    // MARK: - Private Method -
    private func configTableViewCell() {
        let menus = [("img_all" , "language".localizedString),
                     ("img_all" , "notification".localizedString),
                     ("img_all" , "contact_us".localizedString),
                     ("img_all" , "help".localizedString)]
        
        for tuple in menus {
            let cell = AccountCell(style: .Default, reuseIdentifier: cellIdentifire)
            cell.selectionStyle = .Default
            cell.setValues(tuple.0, name: tuple.1)
            cells.append(cell)
        }
    }
    
    private func updateTabBarTitles() {
        let tabArray = Wireframe.root().tabBar.items
        let titles = ["home".localizedString, "categories".localizedString, "cart".localizedString, "map".localizedString, "profile".localizedString]
        for (index, tab) in tabArray!.enumerate() { tab.title = titles[index] }
    }
    
    //MARK: - Actions -
    func historyAction() {
        output.historyButtonClicked()
    }
    
    func favoriteAction() {
        output.favoriteButtonClicked()
    }
    
    func settingsAction() {
        output.settingsButtonClicked()
    }
}


//MARK: - extension for AccountViewInput -
extension AccountViewController: AccountViewInput {
    
    func setupInitialState(user: User) {
        self.user = user
        
        navigationItem.title = user.name.isEmpty ? "guest".localizedString : user.name
        accountView.accountHeaderView.titleLabel.text = user.phone.isEmpty ? "+374 xxxxxx" : user.phone
    }
    
    override func updateLocalizedStrings() {
        if let user = user { navigationItem.title = user.name.isEmpty ? "guest".localizedString : user.name }

        updateTabBarTitles()
        accountView.accountHeaderView.updateLocalizedStrings()
        
        cells.removeAll()
        configTableViewCell()
        accountView.tableView.reloadData()
    }
}

//MARK: - extension for UITableView -
extension AccountViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cells.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return cells[indexPath.row]
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        output.didSelectRow(indexPath.row)
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

