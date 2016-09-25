//
//  OrderGroupView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/14/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class OrderGroupView: UIView {
    
    //MARK: - Create UIElements -
    lazy var addButton: UIButton = {
        let view = UIButton.newAutoLayout()
        view.backgroundColor = RED
        
        return view
    }()
    
    lazy var removeButton: UIButton = {
        let view = UIButton.newAutoLayout()
        view.backgroundColor = RED

        return view
    }()
    
    lazy var titleLabel: HOLabel = {
        let view = HOLabel.newAutoLayout()
        view.textAlignment = .center
        view.textColor = GRAY
        view.text = "Count"
        
        return view
    }()
    
    //MARK: - Initialize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addAllUIElements() {
        addSubview(removeButton)
        addSubview(titleLabel)
        addSubview(addButton)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        removeButton.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        removeButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        removeButton.autoSetDimensions(to: CGSize(width: 50, height: 50))
        
        titleLabel.autoPinEdge(.left, to: .right, of: removeButton, withOffset: 0)
        titleLabel.autoPinEdge(.right, to: .left, of: addButton, withOffset: 0)
        titleLabel.autoAlignAxis(toSuperviewAxis: .horizontal)
        
        addButton.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        addButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        addButton.autoSetDimensions(to: CGSize(width: 50, height: 50))
    }
    
    //MARK: - Public Methods -
    func setValues()  {
        
    }
}
