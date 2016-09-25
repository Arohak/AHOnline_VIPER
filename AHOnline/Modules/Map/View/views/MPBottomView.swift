//
//  MPBottomView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/18/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class MPBottomView: UIView {
    
    //MARK: - Create UIElements -
    let locationButton: UIButton = {
        let view = UIButton.newAutoLayout()
        view.setBackgroundImage(UIImage(named: "img_map_pin"), for: .normal)
        
        return view
    }()
    
    let closeRoutButton: UIButton = {
        let view = UIButton.newAutoLayout()
        view.setBackgroundImage(UIImage(named: "img_delete_root"), for: .normal)
        view.isHidden = true
        
        return view
    }()
    
    //MARK: - Initialize -
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addAllUIElements() {
        addSubview(locationButton)
        addSubview(closeRoutButton)
        
        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        locationButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        locationButton.autoPinEdge(toSuperviewEdge: .right, withInset: MP_INSET)
        locationButton.autoSetDimensions(to: CGSize(width: MP_BTN_SIZE, height: MP_BTN_SIZE))
        
        closeRoutButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        closeRoutButton.autoPinEdge(toSuperviewEdge: .left, withInset: MP_INSET)
        closeRoutButton.autoSetDimensions(to: CGSize(width: MP_BTN_SIZE, height: MP_BTN_SIZE))
    }
}
