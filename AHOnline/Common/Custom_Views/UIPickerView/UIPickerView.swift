//
//  UIPickerView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//


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
        cityLabel.autoPinEdgeToSuperviewEdge(.Left, withInset: CA_INSET)
        cityLabel.autoPinEdge(.Right, toEdge: .Left, ofView: priceLabel, withOffset: CA_INSET)

        priceLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
        priceLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: CA_INSET)
        
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
        let distance = "\(distances[row]) km"
        
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