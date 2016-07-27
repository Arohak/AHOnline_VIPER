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
        let view = UIScrollView.newAutoLayoutView()
        
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.contentMode = .ScaleAspectFill
        
        if let imageStr = self.imageStr {
            view.image = UIImage(named: imageStr)
        }
        
        if let url = self.imageURL {
            view.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: Image(named: "img_placeholder"))
        }
        
        return view
    }()
    
    lazy var bluredImageView: UIImageView = {
        let view = UIImageView.newAutoLayoutView()
        view.alpha = 0
        
        return view
    }()
    
    lazy var subView: UIView = {
        let view = UIView.newAutoLayoutView()
        
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
    
    convenience init(imageURL: String?, frame : CGRect = CGRect(x: 0, y: 0, width: ScreenSize.WIDTH, height: ScreenSize.HEIGHT*0.3)) {
        self.init(frame: frame)
        
        self.imageURL = imageURL
        addDefaultUIElements()
    }
    
    convenience init(subView: UIView, frame : CGRect = CGRect(x: 0, y: 0, width: ScreenSize.WIDTH, height: ScreenSize.HEIGHT*0.3)) {
        self.init(frame: frame)
        
        addUIElements(subView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Methods -
    private func addDefaultUIElements() {
        self.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(bluredImageView)
       
        topHeaderConstraints = scrollView.autoPinEdgeToSuperviewEdge(.Top)
        heightHeaderConstraints = scrollView.autoMatchDimension(.Height, toDimension: .Height, ofView: self)
        scrollView.autoMatchDimension(.Width, toDimension: .Width, ofView: self)
        scrollView.autoPinEdgeToSuperviewEdge(.Left)
        
        imageView.autoPinEdgeToSuperviewEdge(.Top)
        heightImageConstraints = imageView.autoMatchDimension(.Height, toDimension: .Height, ofView: self)
        imageView.autoMatchDimension(.Width, toDimension: .Width, ofView: self)
        imageView.autoPinEdgeToSuperviewEdge(.Left)
        
        bluredImageView.autoPinEdgeToSuperviewEdge(.Top)
        heightBluredImageConstraints = bluredImageView.autoMatchDimension(.Height, toDimension: .Height, ofView: self)
        bluredImageView.autoMatchDimension(.Width, toDimension: .Width, ofView: self)
        bluredImageView.autoPinEdgeToSuperviewEdge(.Left)
        
        refreshBlurViewForNewImage()
    }
    
    private func addUIElements(subView: UIView) {
        self.addSubview(scrollView)
        scrollView.addSubview(subView)
        scrollView.addSubview(bluredImageView)
        
        topHeaderConstraints = scrollView.autoPinEdgeToSuperviewEdge(.Top)
        heightHeaderConstraints = scrollView.autoMatchDimension(.Height, toDimension: .Height, ofView: self)
        scrollView.autoMatchDimension(.Width, toDimension: .Width, ofView: self)
        scrollView.autoPinEdgeToSuperviewEdge(.Left)
        
        subView.autoPinEdgeToSuperviewEdge(.Top)
        heightImageConstraints = subView.autoMatchDimension(.Height, toDimension: .Height, ofView: self)
        subView.autoMatchDimension(.Width, toDimension: .Width, ofView: self)
        subView.autoPinEdgeToSuperviewEdge(.Left)
        
        bluredImageView.autoPinEdgeToSuperviewEdge(.Top)
        heightBluredImageConstraints = bluredImageView.autoMatchDimension(.Height, toDimension: .Height, ofView: self)
        bluredImageView.autoMatchDimension(.Width, toDimension: .Width, ofView: self)
        bluredImageView.autoPinEdgeToSuperviewEdge(.Left)
        
        refreshBlurViewForNewImage()
    }
    
    private func screenShotOfView() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(kFrame.size, true, 0.0)
        self.drawViewHierarchyInRect(kFrame, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    //MARK: - Public Methods -
    func refreshBlurViewForNewImage() {
        var screenShot = screenShotOfView()
        screenShot = screenShot.applyBlurWithRadius(5, tintColor: UIColor(white: 0.6, alpha: 0.2), saturationDeltaFactor: 1.0)!
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