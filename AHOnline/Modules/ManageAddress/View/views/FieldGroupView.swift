//
//  FieldGroupView.swift
//  AHOnline
//
//  Created by AroHak on 28/07/2016.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class FieldGroupView: UIView {
    
    //MARK: - Create UIElements -
    lazy var nameLabel: TitleLabel = {
        let view = TitleLabel.newAutoLayoutView()
        view.textColor = WHITE
        
        return view
    }()
    
    lazy var textField: HOTextField = {
        let view = HOTextField.newAutoLayoutView()
        
        return view
    }()
    
    //MARK: - Initialize -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addAllUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addAllUIElements() {
        addSubview(nameLabel)
        addSubview(textField)
        
        serConstraints()
    }
    
    //MARK: - Constarints -
    func serConstraints() {
        nameLabel.autoPinEdgeToSuperviewEdge(.Top)
        nameLabel.autoPinEdgeToSuperviewEdge(.Left)

        textField.autoPinEdge(.Top, toEdge: .Bottom, ofView: nameLabel)
        textField.autoPinEdgeToSuperviewEdge(.Left)
        textField.autoPinEdgeToSuperviewEdge(.Right)
        textField.autoSetDimension(.Height, toSize: MA_HEIGHT)
    }
    
    //MARK: - Public Methods -
    func setValue(title: String) {
        textField.text = title
    }
}
