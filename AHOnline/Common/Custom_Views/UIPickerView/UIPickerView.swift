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
    convenience init(values: [String], callback: @escaping PickerCallback) {
        self.init(frame: CGRect.zero)
        
        self.callback = callback
        self.values = values
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIPickerViewDataSource -
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let value = values[row]
        
        return value
    }
    
    //MARK: - UIPickerViewDelegate -
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        callback?(values[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
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
    convenience init(values: [(String, String)], callback: @escaping ManageAddressPickerCallback) {
        self.init(frame: CGRect.zero)
        
        self.callback = callback
        self.values = values
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIPickerViewDataSource -
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let value = values[row]
        
        return value.0
    }
    
    //MARK: - UIPickerViewDelegate -
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        callback?(values[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CA_CELL_HEIGHT*0.6
    }
}

//MARK: - DUPickerView -
class ContryCodePickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var callback: PickerCallback?
    
    var indexPath: NSIndexPath!
    
    var values = Array<String>()
    var keys = Array<String>()
    var dictionary = Dictionary<String,String>()
    
    //MARK: - Initilize -
    init(values: [String], callback: @escaping PickerCallback) {
        super.init(frame: CGRect.zero)
        
        delegate = self
        dataSource = self
        clipsToBounds = true
        layer.cornerRadius = 5.0
        
        self.callback = callback
        self.values = values
    }
    
    //MARK: - Initilize -
    init(dictionary: [String : String], keys: [String], callback: @escaping PickerCallback) {
        super.init(frame: CGRect.zero)
        
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
    }
    
    //MARK: - UIPickerViewDataSource -
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return keys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        let imageView: UIImageView = {
            let view = UIImageView.newAutoLayout()
            view.image = UIImage(named: dictionary[keys[row]]!)
            
            return view
        }()
        
        let titleLabel: UILabel = {
            let view = UILabel.newAutoLayout()
            view.text = keys[row]
            
            return view
        }()
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        
        imageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        imageView.autoPinEdge(toSuperviewEdge: .left, withInset: 20)
        imageView.autoSetDimensions(to: CGSize(width: 30, height: 30))
        
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        titleLabel.autoPinEdge(.left, to: .right, of: imageView, withOffset: 20)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: 20)
        
        return view
    }
    
    //MARK: - UIPickerViewDelegate -
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        callback?(keys[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
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
    convenience init(deliveries: [Delivery], callback: @escaping DeliveryPickerCallback) {
        self.init(frame: CGRect.zero)
        
        self.callback = callback
        self.deliveries = deliveries
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIPickerViewDataSource -
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return deliveries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        
        let cityLabel: UILabel = {
            let view = UILabel.newAutoLayout()
            view.text = deliveries[row].city
            
            return view
        }()
        
        let priceLabel: UILabel = {
            let view = UILabel.newAutoLayout()
            view.text = "\(deliveries[row].price)"
            
            return view
        }()
        
        view.addSubview(cityLabel)
        view.addSubview(priceLabel)
        
        cityLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        cityLabel.autoPinEdge(toSuperviewEdge: .left, withInset: CA_INSET*3)
        cityLabel.autoPinEdge(.right, to: .left, of: priceLabel, withOffset: CA_INSET)

        priceLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        priceLabel.autoPinEdge(toSuperviewEdge: .right, withInset: CA_INSET*3)
        
        return view
    }
    
    //MARK: - UIPickerViewDelegate -
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        callback?(deliveries[row], row)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
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
    convenience init(distances: [Double], callback: @escaping DistancePickerCallback) {
        self.init(frame: CGRect.zero)
        
        self.callback = callback
        self.distances = distances
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIPickerViewDataSource -
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return distances.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let distance = "\(distances[row]) " + "km".localizedString
        
        return distance
    }
    
    //MARK: - UIPickerViewDelegate -
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        callback?(distances[row], row)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
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
        self.init(frame: CGRect.zero)
        
        self.languages = languages
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UIPickerViewDataSource -
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let language = languages[row]
        
        return language
    }
    
    //MARK: - UIPickerViewDelegate -
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CA_CELL_HEIGHT*0.6
    }
}
