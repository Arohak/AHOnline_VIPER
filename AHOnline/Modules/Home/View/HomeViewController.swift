//
//  HomeViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

import iCarousel

class HomeViewController: BaseViewController {

    var output: HomeViewOutput!
    
    internal var homeView = HomeView()
    internal let cellIdentifire = "cellIdentifire"
    internal var titles: [String] = []
    internal var descs: [String] = []
    internal var items: [[AHObject]] = []
    internal var heights: [CGFloat] = []
    internal var carouselTimer: Timer!
    internal var isSearchAnimation = true
    internal var isFilterAnimation = true

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configNavigationBar()
        output.checkUser()
        output.viewIsReady()
    }
    
    // MARK: - Internal Method -
    func configNavigationBar() {
        navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "img_map"), style: .plain, target: self, action: #selector(mapAction)), animated: true)
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(named: "img_search"), style: .plain, target: self, action: #selector(searchAction)), animated: true)
    }
    
    override func baseConfig() {
        self.view = homeView
        
        homeView.tableView.dataSource = self
        homeView.tableView.delegate = self
        homeView.tableView.register(HomeCell.self, forCellReuseIdentifier: cellIdentifire)
        
        homeView.searchView.textField.delegate = self
        homeView.searchView.filterButton.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
        
        scheduleCarouselScrolingTimer()
    }
    
    override func updateLocalizedStrings() {
        navigationItem.title = "home".localizedString
        
        titles  = ["new_restaurants".localizedString,
                   "rate_restaurants".localizedString,
                   "open_restaurants".localizedString]
        
        descs   = ["", "", ""]
    }
    
    internal func scheduleCarouselScrolingTimer() {
        carouselTimer = Timer.scheduledTimer(timeInterval: 7, target: self, selector: #selector(scrollCarousel), userInfo: nil, repeats: true)
    }
    
    //MARK: - Timer Methods -
    func scrollCarousel() {
        let index = homeView.carousel.currentItemIndex % 19 + 1
        homeView.carousel.scrollToItem(at: index, animated: true)
    }
    
    //MARK: - CallBacks didSelectCollectionAtIndexPath Method -
    func didSelectCollectionAtIndexPath(indexPath: IndexPath) {
        let object = items[indexPath.section][indexPath.row]
        output.didSelectObject(object: object)
    }
    
    //MARK: - Actions -
    func mapAction() {
        output.mapButtonClicked()
    }
    
    func searchAction() {
        animationSearchView()
        if !isFilterAnimation {
            animationFilterView()
        }
    }

    func filterAction() {
        animationFilterView()
    }
    
    func seeAllButtonAction(sender: HOButton) {
        var type: ObjectsType = .New
        switch sender.indexPath.row {
        case 0:
            type = .New
        case 1:
            type = .Rate
        case 2:
            type = .Open
        default:
            break
        }
        
        output.didSelectObjectForType(type: type)
    }
    
    //MARK: - Animation -
    func animationSearchView() {
        if isSearchAnimation {
            UIView.animate(withDuration: 0.5, animations: {
                self.homeView.searchView.alpha = 1
            }) { finish in
                self.isSearchAnimation = !self.isSearchAnimation
            }
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.homeView.searchView.alpha = 0
            }) { finish in
                self.isSearchAnimation = !self.isSearchAnimation
                self.view.endEditing(true)
            }
        }
    }
    
    func animationFilterView() {
        if isFilterAnimation {
            UIView.animate(withDuration: 0.5, animations: {
                self.homeView.filterView.alpha = 1
                self.homeView.filterView.configurationTableViewCell()
            }) { finish in
                self.isFilterAnimation = !self.isFilterAnimation
            }
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.homeView.filterView.alpha = 0
            }) { finish in
                self.isFilterAnimation = !self.isFilterAnimation
            }
        }
    }
}

//MARK: - extension for HomeViewInput -
extension HomeViewController: HomeViewInput {
    
    func setupInitialState(home: Home) {
        items.removeAll()
        
        heights = [Screen.height*0.25, Screen.height*0.25, Screen.height*0.3]
        
        items.append([AHObject]())
        items.append([AHObject]())
        items.append([AHObject]())
        
        items[0] = Array(home.newRestaurants)
        items[1] = Array(home.rateRestaurants)
        items[2] = Array(home.openRestaurants.reversed())
        
        updateAllData()
    }
    
    private func updateAllData() {
        updateLocalizedStrings()
        
        homeView.tableView.reloadData()
        for i in 0..<items.count {
            let cell = homeView.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! HomeCell
            cell.cellContentView.collection.reloadData()
        }
    }
}

//MARK: - extension for UITableView -
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire) as! HomeCell
        cell.cellContentView.seellAllButton.addTarget(self, action: #selector(seeAllButtonAction(sender:)), for: .touchUpInside)
        cell.setValues(indexPath: indexPath,
                       title:   titles[indexPath.row],
                       desc:    descs[indexPath.row],
                       items:   items[indexPath.row],
                       height:  heights[indexPath.row],
                       inset:   0,
                       callBack: didSelectCollectionAtIndexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return heights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return Screen.height*0.3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.addSubview(homeView.carousel)
        homeView.carousel.dataSource = self
        homeView.carousel.delegate = self
        homeView.carousel.clipsToBounds = true
        homeView.carousel.autoPinEdgesToSuperviewEdges()
        
        return view
    }
}

//MARK: - extension for UITextFieldDelegate -
extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text!.characters.count < 3 {
            UIHelper.showHUD(message: "search_message".localizedString)
        } else {
            textField.resignFirstResponder()
            output.search(keyword: textField.text!,
                          searchType: homeView.filterView.searchType,
                          sort: homeView.filterView.sort,
                          kitchen: homeView.filterView.kitchens)
        }
        return true
    }
}

//MARK: - extension for iCarousel -
extension HomeViewController: iCarouselDataSource, iCarouselDelegate {
    
    public func numberOfItems(in carousel: iCarousel) -> Int {
        return 20
    }

    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let itemView: UIView!
        var imageView: UIImageView!
        
        if (view == nil) {
            let inset = HO_INSET*2
            itemView = UIView(frame: CGRect(x: 0, y: inset, width: Screen.width - inset, height: Screen.height*0.3 - inset))
            imageView = UIImageView.newAutoLayout()
            itemView.addSubview(imageView)
            imageView.image = UIImage(named: "\(index % 4).png")
            imageView.autoPinEdgesToSuperviewEdges()
        } else {
            itemView = view
        }
        
        return itemView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    
    func carouselWillBeginDecelerating(_ carousel: iCarousel) {
//        carouselTimer.invalidate()
        carouselTimer = nil
    }
    
    func carouselDidEndDecelerating(_ carousel: iCarousel) {
        scheduleCarouselScrolingTimer()
    }
}
