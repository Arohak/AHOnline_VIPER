//
//  WebViewController.swift
//  AHOnline
//
//  Created by Ara Hakobyan on 7/9/16.
//  Copyright © 2016 AroHak LLC. All rights reserved.
//

//MARK: - class WebViewController -
class WebViewController: UIViewController {
    
    var resourceName: String!
    var url: NSURL!
    
    lazy var browser: UIWebView = {
        let view = UIWebView.newAutoLayout()
        view.delegate = self
        
        return view
    }()
    
    //MARK: - Initilize -
    init() {
        super.init(nibName: nil, bundle:nil)
    }
    
    convenience init(resourceName: String, url: NSURL) {
        self.init()
        
        self.resourceName = resourceName
        self.url = url
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(browser)
        browser.autoPinEdgesToSuperviewEdges()
        
        self.navigationItem.title = resourceName
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(WebViewController.close)), animated: true)
        
        UIHelper.showSpinner()
        browser.loadRequest(NSURLRequest(url: url as URL) as URLRequest)
    }
    
    //MARK: - Actions -
    func close() {
        UIHelper.hideSpinner()
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

//MARK: - extension for UIWebViewDelegate -
extension WebViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
       UIHelper.hideSpinner()
    }
}
