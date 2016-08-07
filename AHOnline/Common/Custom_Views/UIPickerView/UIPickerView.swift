//
//  UIPickerView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - ManagePickerView -
class ManagePickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var callback: PickerCallback?
    private var values: [String] = []
    
    //MARK: - Initilize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        dataSource = self
    }
    
    //MARK: - Initilize -
    convenience init(values: [String], callback: PickerCallback) {
        self.init(frame: CGRectZero)
        
        self.callback = callback
        self.values = values
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIPickerViewDataSource -
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return values.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let value = values[row]
        
        return value
    }
    
    //MARK: - UIPickerViewDelegate -
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        callback?(value: values[row])
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return CA_CELL_HEIGHT*0.6
    }
}

//MARK: - ManageAddressPickerView -
class ManageAddressPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var callback: ManageAddressPickerCallback?
    private var values: [(String, String)] = []
    
    //MARK: - Initilize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        dataSource = self
    }
    
    //MARK: - Initilize -
    convenience init(values: [(String, String)], callback: ManageAddressPickerCallback) {
        self.init(frame: CGRectZero)
        
        self.callback = callback
        self.values = values
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIPickerViewDataSource -
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return values.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let value = values[row]
        
        return value.0
    }
    
    //MARK: - UIPickerViewDelegate -
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        callback?(value: values[row])
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return CA_CELL_HEIGHT*0.6
    }
}

//MARK: - DUPickerView -
class ContryCodePickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var callback: PickerCallback?
    
//    var closeTimer = NSTimer()
    var indexPath: NSIndexPath!
    
    var values = Array<String>()
    var keys = Array<String>()
    var dictionary = Dictionary<String,String>()
    
    //MARK: - Initilize -
    init(values: [String], callback: PickerCallback) {
        super.init(frame: CGRectZero)
        
        delegate = self
        dataSource = self
        clipsToBounds = true
        layer.cornerRadius = 5.0
        
        self.callback = callback
        self.values = values
    }
    
    //MARK: - Initilize -
    init(dictionary: [String : String], keys: [String], callback: PickerCallback) {
        super.init(frame: CGRectZero)
        
        delegate = self
        dataSource = self
        clipsToBounds = true
        layer.cornerRadius = 5.0
        
        self.callback = callback
        self.dictionary = dictionary
        self.keys = keys
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions methods -
    func closePopUp() {
        Wireframe.dismissViewController()
        
//        closeTimer.invalidate()
    }
    
    //MARK: - UIPickerViewDataSource -
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return keys.count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let view = UIView()
        let imageView: UIImageView = {
            let view = UIImageView.newAutoLayoutView()
            view.image = UIImage(named: dictionary[keys[row]]!)
            
            return view
        }()
        
        let titleLabel: UILabel = {
            let view = UILabel.newAutoLayoutView()
            view.text = keys[row]
            
            return view
        }()
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        
        imageView.autoAlignAxisToSuperviewAxis(.Horizontal)
        imageView.autoPinEdgeToSuperviewEdge(.Left, withInset: 20)
        imageView.autoSetDimensionsToSize(CGSize(width: 30, height: 30))
        
        titleLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
        titleLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: 20)
        titleLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 20)
        
        return view
    }
    
    //MARK: - UIPickerViewDelegate -
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        callback?(value: keys[row])
        
//        closeTimer.invalidate()
//        closeTimer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(closePopUp), userInfo: AnyObject?(), repeats: true)
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 36
    }
}

//MARK: - DeliveryPickerView -
class DeliveryPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var callback: DeliveryPickerCallback?
    var deliveries: [Delivery] = []
    
    //MARK: - Initilize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        dataSource = self
        clipsToBounds = true
        layer.cornerRadius = 5.0
    }
    
    //MARK: - Initilize -
    convenience init(deliveries: [Delivery], callback: DeliveryPickerCallback) {
        self.init(frame: CGRectZero)
        
//        backgroundColor = BLUE_LIGHT
        self.callback = callback
        self.deliveries = deliveries
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIPickerViewDataSource -
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return deliveries.count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let view = UIView()
        
        let cityLabel: UILabel = {
            let view = UILabel.newAutoLayoutView()
            view.text = deliveries[row].city
            
            return view
        }()
        
        let priceLabel: UILabel = {
            let view = UILabel.newAutoLayoutView()
            view.text = "\(deliveries[row].price)"
            
            return view
        }()
        
        view.addSubview(cityLabel)
        view.addSubview(priceLabel)
        
        cityLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
        cityLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: CA_INSET*3)
        cityLabel.autoPinEdge(.Right, toEdge: .Left, ofView: priceLabel, withOffset: CA_INSET)

        priceLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
        priceLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: CA_INSET*3)
        
        return view
    }
    
    //MARK: - UIPickerViewDelegate -
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        callback?(value: deliveries[row], index: row)
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return CA_CELL_HEIGHT*0.7
    }
}

//MARK: - DistancePickerView -
class DistancePickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var callback: DistancePickerCallback?
    var distances: [Double] = []
    
    //MARK: - Initilize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        dataSource = self
    }
    
    //MARK: - Initilize -
    convenience init(distances: [Double], callback: DistancePickerCallback) {
        self.init(frame: CGRectZero)
        
        self.callback = callback
        self.distances = distances
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIPickerViewDataSource -
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return distances.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let distance = "\(distances[row]) " + "km".localizedString
        
        return distance
    }
    
    //MARK: - UIPickerViewDelegate -
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        callback?(value: distances[row], index: row)
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return CA_CELL_HEIGHT*0.6
    }
}

//MARK: - LanguagePickerView -
class LanguagePickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var languages: [String] = []
    
    //MARK: - Initilize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        dataSource = self
    }
    
    //MARK: - Initilize -
    convenience init(languages: [String]) {
        self.init(frame: CGRectZero)
        
        self.languages = languages
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIPickerViewDataSource -
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return languages.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let language = languages[row]
        
        return language
    }
    
    //MARK: - UIPickerViewDelegate -
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return CA_CELL_HEIGHT*0.6
    }
}