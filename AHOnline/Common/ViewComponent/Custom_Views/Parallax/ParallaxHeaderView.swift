//
//  ParallaxHeaderView.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

class ParallaxHeaderView: UIView {
    
    var imageStr: String?
    var imageURL: String?
    var kFrame: CGRect!
    var topHeaderConstraints: NSLayoutConstraint!
    var heightHeaderConstraints: NSLayoutConstraint!
    var heightImageConstraints: NSLayoutConstraint!
    var heightBluredImageConstraints: NSLayoutConstraint!

    //MARK: - Create UIElements -
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView.newAutoLayout()
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.contentMode = .scaleAspectFill
        
        if let imageStr = self.imageStr {
            view.image = UIImage(named: imageStr)
        }
        
        if let url = self.imageURL {
            view.af_setImage(withURL: URL(string: url)!, placeholderImage: UIImage(named: "img_placeholder"))
        }
        
        return view
    }()
    
    lazy var bluredImageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.alpha = 0
        
        return view
    }()
    
    lazy var subView: UIView = {
        let view = UIView.newAutoLayout()
        
        return view
    }()
    
    //MARK: - Initialize -
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        kFrame = frame
    }
    
    convenience init(imageStr: String?, frame : CGRect) {
        self.init(frame: frame)
        
        self.imageStr = imageStr
        addDefaultUIElements()
    }
    
    convenience init(imageURL: String?, frame : CGRect = CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height*0.3)) {
        self.init(frame: frame)
        
        self.imageURL = imageURL
        addDefaultUIElements()
    }
    
    convenience init(subView: UIView, frame : CGRect = CGRect(x: 0, y: 0, width: Screen.width, height: Screen.height*0.3)) {
        self.init(frame: frame)
        
        addUIElements(subView: subView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addDefaultUIElements() {
        self.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(bluredImageView)
       
        topHeaderConstraints = scrollView.autoPinEdge(toSuperviewEdge: .top)
        heightHeaderConstraints = scrollView.autoMatch(.height, to: .height, of: self)
        scrollView.autoMatch(.width, to: .width, of: self)
        scrollView.autoPinEdge(toSuperviewEdge: .left)
        
        imageView.autoPinEdge(toSuperviewEdge: .top)
        heightImageConstraints = imageView.autoMatch(.height, to: .height, of: self)
        imageView.autoMatch(.width, to: .width, of: self)
        imageView.autoPinEdge(toSuperviewEdge: .left)
        
        bluredImageView.autoPinEdge(toSuperviewEdge: .top)
        heightBluredImageConstraints = bluredImageView.autoMatch(.height, to: .height, of: self)
        bluredImageView.autoMatch(.width, to: .width, of: self)
        bluredImageView.autoPinEdge(toSuperviewEdge: .left)
        
        refreshBlurViewForNewImage()
    }
    
    private func addUIElements(subView: UIView) {
        self.addSubview(scrollView)
        scrollView.addSubview(subView)
        scrollView.addSubview(bluredImageView)
        
        topHeaderConstraints = scrollView.autoPinEdge(toSuperviewEdge: .top)
        heightHeaderConstraints = scrollView.autoMatch(.height, to: .height, of: self)
        scrollView.autoMatch(.width, to: .width, of: self)
        scrollView.autoPinEdge(toSuperviewEdge: .left)
        
        subView.autoPinEdge(toSuperviewEdge: .top)
        heightImageConstraints = subView.autoMatch(.height, to: .height, of: self)
        subView.autoMatch(.width, to: .width, of: self)
        subView.autoPinEdge(toSuperviewEdge: .left)
        
        bluredImageView.autoPinEdge(toSuperviewEdge: .top)
        heightBluredImageConstraints = bluredImageView.autoMatch(.height, to: .height, of: self)
        bluredImageView.autoMatch(.width, to: .width, of: self)
        bluredImageView.autoPinEdge(toSuperviewEdge: .left)
        
        refreshBlurViewForNewImage()
    }
    
    private func screenShotOfView() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(kFrame.size, true, 0.0)
        self.drawHierarchy(in: kFrame, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    //MARK: - Public Methods -
    func refreshBlurViewForNewImage() {
        var screenShot = screenShotOfView()
        screenShot = screenShot.applyBlurWithRadius(blurRadius: 5, tintColor: UIColor(white: 0.6, alpha: 0.2), saturationDeltaFactor: 1.0)!
        bluredImageView.image = screenShot
    }
    
    func headerViewForScrollViewOffset(offset: CGPoint) {
        if offset.y > 0 {
            let Y = max(offset.y * 0.3, 0)
            topHeaderConstraints.constant = Y
            bluredImageView.alpha = 1 / kFrame.size.height * offset.y * 2
            clipsToBounds = true
            
        } else {
            let delta = fabs(min(0, offset.y))
            topHeaderConstraints.constant = -delta
            heightHeaderConstraints.constant = delta
            heightImageConstraints.constant = delta
            bluredImageView.alpha =   0
            clipsToBounds = false
        }
    }
}
