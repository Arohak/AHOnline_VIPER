//
//  SearchView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class SearchView: UIView {
    
    //MARK: - Create UIElements -
    lazy var bgView: UIView = {
        let view = UIView.newAutoLayout()
        view.backgroundColor = BLACK
        view.alpha = 0.7
        
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView.newAutoLayout()
        
        return view
    }()
    
    lazy var textField: HOTextField = {
        let view = HOTextField.newAutoLayout()
        view.backgroundColor = WHITE
        view.returnKeyType = .search
        
        return view
    }()
    
    lazy var filterButton: HOButton = {
        let view = HOButton.newAutoLayout()
        view.setImage(UIImage(named:"img_filter"), for: .normal)
        
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
        addSubview(bgView)
        addSubview(contentView)
        contentView.addSubview(textField)
        contentView.addSubview(filterButton)

        setConstraints()
    }
    
    //MARK: - Constraints -
    func setConstraints() {
        let inset = SE_INSET
        bgView.autoPinEdgesToSuperviewEdges()
        contentView.autoPinEdge(toSuperviewEdge: .top)
        contentView.autoPinEdge(toSuperviewEdge: .left)
        contentView.autoPinEdge(toSuperviewEdge: .right)
        contentView.autoSetDimension(.height, toSize: SE_SEARCH_HEIGHT)
        textField.autoPinEdge(toSuperviewEdge: .left, withInset: inset*4)
        textField.autoPinEdge(.right, to: .left, of: filterButton, withOffset: 0)
        textField.autoAlignAxis(toSuperviewAxis: .horizontal)
        textField.autoSetDimension(.height, toSize: 30)
        filterButton.autoPinEdge(toSuperviewEdge: .right, withInset: inset)
        filterButton.autoSetDimensions(to: CGSize(width: 30, height: 30))
        filterButton.autoAlignAxis(toSuperviewAxis: .horizontal)
    }
}
