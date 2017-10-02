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

    internal var accountView = AccountView()
    internal let cellIdentifire = "cellIdentifire"
    internal var user: User?
    internal var cells: [AccountCell] = []
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "img_acc_settings"), style: .plain, target: self, action: #selector(settingsAction)), animated: true)

        output.viewIsReady()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let headerView = accountView.tableView.tableHeaderView as! ParallaxHeaderView
        headerView.refreshBlurViewForNewImage()
    }
    
    //MARK: -  Internal Methods -
    override func baseConfig() {
        self.view = accountView
        
        accountView.tableView.dataSource = self
        accountView.tableView.delegate = self
        accountView.tableView.register(AccountCell.self, forCellReuseIdentifier: cellIdentifire)
    }
    
    override func updateLocalizedStrings() {
        navigationItem.title = "profile".localizedString
        
        cells.removeAll()
        configTableViewCell()
        accountView.tableView.reloadData()
    }
    
    // MARK: - Private Method -
    private func configTableViewCell() {
        let menus = [
            ("img_history_logo"         , "history".localizedString),
            ("img_notification_logo"    , "notification".localizedString),
            ("img_language_logo"        , "language".localizedString)
        ]
        
        for tuple in menus {
            let cell = AccountCell(style: .default, reuseIdentifier: cellIdentifire)
            cell.selectionStyle = .default
            cell.setValues(imageString: tuple.0, name: tuple.1)
            cells.append(cell)
        }
    }
    
    //MARK: - Actions -
    func settingsAction() {
        output.settingsButtonClicked()
    }
}

//MARK: - extension for AccountViewInput -
extension AccountViewController: AccountViewInput {
    
    func setupInitialState(user: User) {
        self.user = user
        
        accountView.accountHeaderView.nameLabel.text = user.name.isEmpty ? "Guest" : user.name
        accountView.accountHeaderView.phoneLabel.text = user.phone.isEmpty ? "+374 xxxxxx" : user.phone
    }
}

//MARK: - extension for UITableView -
extension AccountViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return cells[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        output.didSelectRow(index: indexPath.row)
    }
}

//MARK: - extension for UIScrollView -
extension AccountViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == accountView.tableView {
            if let parallaxHeaderView = accountView.tableView.tableHeaderView as? ParallaxHeaderView {
                parallaxHeaderView.headerViewForScrollViewOffset(offset: scrollView.contentOffset)
            }
        }
    }
}

