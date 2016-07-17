//
//  HomeViewController.swift
//  AHOnline
//
//  Created by AroHak on 09/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class HomeViewController -
class HomeViewController: BaseViewController {

    var output: HomeViewOutput!
    
    var homeView = HomeView()
    let cellIdentifire = "cellIdentifire"
    var titles: [String] = []
    var descs: [String] = []
    var items: [[AHObject]] = []
    var heights: [CGFloat] = []
    var carouselTimer: NSTimer!

    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        output.viewIsReady()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    // MARK: - Internal Method -
    override func baseConfig() {
        self.view = homeView
        
        homeView.tableView.dataSource = self
        homeView.tableView.delegate = self
        homeView.tableView.registerClass(HomeCell.self, forCellReuseIdentifier: cellIdentifire)
        
        scheduleCarouselScrolingTimer()
    }
    
    //MARK: - Private Methods -
    private func scheduleCarouselScrolingTimer() {
        carouselTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(scrollCarousel), userInfo: nil, repeats: true)
    }
    
    //MARK: - Timer Methods -
    func scrollCarousel() {
        homeView.carousel.scrollToItemAtIndex(homeView.carousel.currentItemIndex + 1, animated: true)
    }
    
    //MARK: - CallBacks Methods -
    func didSelectCollectionAtIndexPath(indexPath: NSIndexPath) {
        let object = items[indexPath.section][indexPath.row]
        output.didSelectObject(object)
    }
}

//MARK: - extension for HomeViewInput -
extension HomeViewController: HomeViewInput {
    
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
        
        homeView.tableView.reloadData()
    }
}

//MARK: - extension for UITableView -
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return ScreenSize.HEIGHT*0.3
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.addSubview(homeView.carousel)
        homeView.carousel.dataSource = self
        homeView.carousel.delegate = self
        homeView.carousel.clipsToBounds = true
        homeView.carousel.autoPinEdgesToSuperviewEdges()
        
        return view
    }
}

//MARK: - extension for iCarousel -
extension HomeViewController: iCarouselDataSource, iCarouselDelegate {
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        
        return 10
    }

    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        let itemView: UIView!
        var imageView: UIImageView!
        
        if (view == nil) {
            itemView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenSize.WIDTH - HO_INSET*2, height: ScreenSize.HEIGHT*0.3))
            imageView = UIImageView.newAutoLayoutView()
            itemView.addSubview(imageView)
            imageView.image = UIImage(named: "\(index).png")
            imageView.autoPinEdgesToSuperviewEdges()
        } else {
            itemView = view
        }
        
        return itemView
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .Spacing) {
            return value * 1.1
        }
        return value
    }
    
    func carouselWillBeginDecelerating(carousel: iCarousel) {
//        carouselTimer.invalidate()
        carouselTimer = nil
    }
    
    func carouselDidEndDecelerating(carousel: iCarousel) {
        scheduleCarouselScrolingTimer()
    }
}
