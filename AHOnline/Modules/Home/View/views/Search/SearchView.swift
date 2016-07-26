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
        let view = UIView.newAutoLayoutView()
        view.backgroundColor = BLACK
        view.alpha = 0.7
        
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView.newAutoLayoutView()
//        view.backgroundColor = BLUE
        
        return view
    }()
    
    lazy var textField: HOTextField = {
        let view = HOTextField.newAutoLayoutView()
        view.backgroundColor = WHITE
        view.returnKeyType = .Search
        
        return view
    }()
    
    lazy var filterButton: HOButton = {
        let view = HOButton.newAutoLayoutView()
        view.setImage(UIImage(named:"img_filter"), forState: .Normal)
        
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
        contentView.autoPinEdgeToSuperviewEdge(.Top)
        contentView.autoPinEdgeToSuperviewEdge(.Left)
        contentView.autoPinEdgeToSuperviewEdge(.Right)
        contentView.autoSetDimension(.Height, toSize: SE_SEARCH_HEIGHT)
        textField.autoPinEdgeToSuperviewEdge(.Left, withInset: inset*4)
        textField.autoPinEdge(.Right, toEdge: .Left, ofView: filterButton, withOffset: 0)
        textField.autoAlignAxisToSuperviewAxis(.Horizontal)
        textField.autoSetDimension(.Height, toSize: 30)
        filterButton.autoPinEdgeToSuperviewEdge(.Right, withInset: inset)
        filterButton.autoSetDimensionsToSize(CGSize(width: 30, height: 30))
        filterButton.autoAlignAxisToSuperviewAxis(.Horizontal)
    }
}
