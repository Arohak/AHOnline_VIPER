//
//  UIPickerView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - DUPickerView -
class DUPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private var callback: PickerCallback?
    
    var closeTimer = NSTimer()
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
        
        closeTimer.invalidate()
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
        callback?(value: dictionary[keys[row]]!)
        
        closeTimer.invalidate()
        closeTimer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(closePopUp), userInfo: AnyObject?(), repeats: true)
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 36
    }
}

//MARK: - DUCPickerView -
class DUCPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var callback: PickerCallback?
    
    var indexPath: NSIndexPath!
    var keys = Array<String>()
    var dictionary = Dictionary<String,String>()
    
    //MARK: - Initilize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        dataSource = self
        clipsToBounds = true
        layer.cornerRadius = 5.0
    }
    
    convenience init(dictionary: [String : String], keys: [String], callback: PickerCallback? = nil) {
        self.init(frame: CGRectZero)
        
        self.callback = callback
        self.dictionary = dictionary
        self.keys = keys
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        imageView.autoPinEdgeToSuperviewEdge(.Left, withInset: 0)
        imageView.autoSetDimensionsToSize(CGSize(width: 40, height: 40))
        
        titleLabel.autoAlignAxisToSuperviewAxis(.Horizontal)
        titleLabel.autoPinEdge(.Left, toEdge: .Right, ofView: imageView, withOffset: 0)
        titleLabel.autoPinEdgeToSuperviewEdge(.Right, withInset: 40)
        
        return view
    }
    
    //MARK: - UIPickerViewDelegate -
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        callback?(value: keys[row])
    }
}

//MARK: - ACPickerView -
class ACPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var callback: ACPickerCallback?
    
    var values = Array<String>()
    var imageString = ""
    
    //MARK: - Initilize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        dataSource = self
        clipsToBounds = true
        layer.cornerRadius = 5.0
    }
    
    //MARK: - Initilize -
    convenience init(values: [String], callback: ACPickerCallback) {
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
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let view = UIView()
        let imageView: UIImageView = {
            let view = UIImageView.newAutoLayoutView()
            view.image = UIImage(named: imageString)
            
            return view
        }()
        
        let titleLabel: UILabel = {
            let view = UILabel.newAutoLayoutView()
            view.text = values[row]
            
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
        
        callback?(value: values[row], index: row)
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        
        return 36
    }
}