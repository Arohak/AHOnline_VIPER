//
//  UIView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class BaseView: UIView {
    
    lazy var bgImageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.image = UIImage(named: "img_bg")
        
        return view
    }()
    
    //MARK: - Initialize -
    init() {
        super.init(frame: CGRectZero)
        
        addSubview(bgImageView)
        bgImageView.autoPinEdgesToSuperviewEdges()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class BaseNode: ASDisplayNode {
    
    lazy var bgImage: ASImageNode = {
        let view = ASImageNode()
        view.image = UIImage(named: "img_bg")
        
        return view
    }()
    
    //MARK: - Initialize -
    override init() {
        super.init()
        
        addSubnode(bgImage)
    }
    
    override func layoutSpecThatFits(constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASStackLayoutSpec(
            direction: .Horizontal,
            spacing: 16,
            justifyContent: .Center,
            alignItems: .Center,
            children: [bgImage])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
