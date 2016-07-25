////
////  FilterView.swift
////  AHOnline
////
////  Created by Ara Hakobyan on 7/9/16.
////  Copyright © 2016 AroHak LLC. All rights reserved.
////
//
//class FilterView: UIView {
//    
//    private let cellIdentifire      = ["cellIdentifire1", "cellIdentifire2", "cellIdentifire3"]
//    private let headers             = ["Type", "Sort", "Key Words"]
//    private let heights: [CGFloat]  = [SE_CELL_HEIGHT, SE_CELL_HEIGHT, SE_CELL_HEIGHT*4]
//    private let items               = [["Restaurants", "Products"], ["Name", "Popular", "Rate"], [""]]
//    private var selectedItems       = ["Restaurants", "Name"]
//    var cells: [[UITableViewCell]]  = []
//    
//    //MARK: - Create UIElements -
//    lazy var bgView: UIView = {
//        let view = UIView.newAutoLayoutView()
//        view.backgroundColor = BLACK
//        view.alpha = 0.4
//        
//        return view
//    }()
//    
//    lazy var footerView: UIView = {
//        let view = UIView.newAutoLayoutView()
//        view.backgroundColor = GREEN
//        
//        return view
//    }()
//    
//    lazy var saveButton: HOButton = {
//        let view = HOButton.newAutoLayoutView()
//        view.setTitle("Save", forState: .Normal)
//        
//        return view
//    }()
//    
//    lazy var cancelButton: HOButton = {
//        let view = HOButton.newAutoLayoutView()
//        view.setTitle("Cancel", forState: .Normal)
//        
//        return view
//    }()
//    
//    lazy var tableView: BaseTableView = {
//        let view = BaseTableView.newAutoLayoutView()
//        view.backgroundColor = WHITE
//        view.dataSource = self
//        view.delegate = self
//        
//        return view
//    }()
//
//    //MARK: - Initialize -
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        addAllUIElements()
//        configurationTableViewCell()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    //MARK: - Private Methods -
//    private func addAllUIElements() {
//        addSubview(bgView)
//        addSubview(tableView)
//        addSubview(footerView)
//        footerView.addSubview(saveButton)
//        footerView.addSubview(cancelButton)
//
//        setConstraints()
//    }
//    
//    //MARK: - Constraints -
//    func setConstraints() {
//        let offset = SE_OFFSET
//        bgView.autoPinEdgesToSuperviewEdges()
//        tableView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsets(top: offset, left: offset, bottom: 0, right: offset), excludingEdge: .Bottom)
//        tableView.autoPinEdge(.Bottom, toEdge: .Bottom, ofView: footerView)
//        footerView.autoPinEdgeToSuperviewEdge(.Bottom, withInset: offset)
//        footerView.autoPinEdgeToSuperviewEdge(.Right, withInset: offset)
//        footerView.autoPinEdgeToSuperviewEdge(.Left, withInset: offset)
//        footerView.autoSetDimension(.Height, toSize: SE_CELL_HEIGHT)
//        saveButton.autoAlignAxisToSuperviewAxis(.Horizontal)
//        saveButton.autoPinEdgeToSuperviewEdge(.Left, withInset: SE_OFFSET)
//        saveButton.autoPinEdgeToSuperviewEdge(.Bottom)
//        cancelButton.autoAlignAxisToSuperviewAxis(.Horizontal)
//        cancelButton.autoPinEdgeToSuperviewEdge(.Right, withInset: SE_OFFSET)
//        cancelButton.autoPinEdgeToSuperviewEdge(.Bottom)
//    }
//    
//    private func configurationTableViewCell() {
//        for i in 0..<headers.count {
//            var temp: [UITableViewCell] = []
//            for j in 0..<items[i].count {
//                if i == headers.count - 1 {
//                    let cell = FilterCell(style: .Default, reuseIdentifier: cellIdentifire[i])
//                    cell.setValues(["AAABBB", "BBBcc", "CCC", "EEE", "DDDbbbbb", "FFF", "AA", "BBB", "AAA", "BBB", "CCC"])
//                    temp.append(cell)
//                } else {
//                    let cell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifire[i])
//                    cell.textLabel?.text = items[i][j]
//                    cell.accessoryType = (items[i][j] == selectedItems[i]) ? .Checkmark : .None
//                    temp.append(cell)
//                }
//            }
//            cells.append(temp)
//        }
//        tableView.reloadData()
//    }
//}
//
////MARK: - extension for UITableView -
//extension FilterView: UITableViewDataSource, UITableViewDelegate {
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        
//        return cells.count
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return cells[section].count
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        return cells[indexPath.section][indexPath.row]
//    }
//    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        
//        return headers[section]
//    }
//    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        
//        return heights[indexPath.section]
//    }
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        switch indexPath.section {
//        case 0:
//            for cell in cells[0] {
//                cell.accessoryType = .None
//            }
//        case 1:
//            for cell in cells[1] {
//                cell.accessoryType = .None
//            }
//        default:
//            break
//        }
//        let cell = cells[indexPath.section][indexPath.row]
//        cell.accessoryType = .Checkmark
//        selectedItems[indexPath.section] = items[indexPath.section][indexPath.row]        
//    }
//}
