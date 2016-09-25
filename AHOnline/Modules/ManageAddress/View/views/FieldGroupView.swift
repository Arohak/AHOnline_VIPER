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
        let view = TitleLabel.newAutoLayout()
        view.textColor = WHITE
        
        return view
    }()
    
    lazy var textField: HOTextField = {
        let view = HOTextField.newAutoLayout()
        
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
        nameLabel.autoPinEdge(toSuperviewEdge: .top)
        nameLabel.autoPinEdge(toSuperviewEdge: .left)

        textField.autoPinEdge(.top, to: .bottom, of: nameLabel)
        textField.autoPinEdge(toSuperviewEdge: .left)
        textField.autoPinEdge(toSuperviewEdge: .right)
        textField.autoSetDimension(.height, toSize: MA_HEIGHT)
    }
    
    //MARK: - Public Methods -
    func setValue(title: String) {
        textField.text = title
    }
}
