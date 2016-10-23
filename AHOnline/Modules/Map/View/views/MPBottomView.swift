//
//  MPBottomView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/18/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class MPBottomView: UIView {
    
    //MARK: - Create UIElements -
    let locationButton: InsetButton = {
        let view = InsetButton.newAutoLayout()
        view.setImage(UIImage(named: "img_map_pin"), for: .normal)
        
        return view
    }()
    
    let closeRoutButton: InsetButton = {
        let view = InsetButton.newAutoLayout()
        view.setImage(UIImage(named: "img_map_delete"), for: .normal)
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
        locationButton.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        locationButton.autoSetDimensions(to: CGSize(width: BTN_SIZE, height: BTN_SIZE))
        
        closeRoutButton.autoAlignAxis(toSuperviewAxis: .horizontal)
        closeRoutButton.autoPinEdge(.right, to: .left, of: locationButton, withOffset: 0)
        closeRoutButton.autoSetDimensions(to: CGSize(width: BTN_SIZE*0.95, height: BTN_SIZE*0.95))
    }
}
