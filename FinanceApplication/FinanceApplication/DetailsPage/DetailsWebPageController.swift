//
//  DetailsWebPageView.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/12/12.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit
import WebKit

class DetailsWebPageController: UIViewController {

    var linkUrl:String!
    
    private lazy var webView:WKWebView = {
        let view = WKWebView()
        self.view.addSubview(view)
        view.snp_makeConstraints{ (make) -> Void in
            make.left.right.top.bottom.equalTo(self.view)
        }
        return view
    }()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let searchIndex = self.navigationController!.viewControllers.count - 2
        if (self.navigationController?.viewControllers[searchIndex] as? HomePageScanController != nil){//上一层是HomePageScanController就要移除掉
            self.navigationController?.viewControllers.removeAtIndex(searchIndex)
        }
    }
    
//    override func viewWillAppear(animated: Bool){
//        
//    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        if hasObserver{
            webView.removeObserver(self, forKeyPath: "estimatedProgress")
            hasObserver = false
        }
        
    }
    
    private var hasObserver = false
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if linkUrl != nil{
            let url = NSURL(string:linkUrl)
            if url != nil{
                webView.loadRequest(NSURLRequest(URL: url!))
                webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
                hasObserver = true
            }
        }
        
        let leftItem =
        UIBarButtonItem(title: "嘿嘿", style: UIBarButtonItemStyle.Done, target: self, action: "cancelClick")
        let customView = UIArrowView(frame:CGRectMake(0, 0, 10, 22))
        customView.direction = .LEFT
        ////        customView.isClosed = true
        customView.lineColor = UIColor.whiteColor()
        customView.lineThinkness = 2
        ////        customView.fillColor = UIColor.blueColor()
        leftItem.customView = customView
        customView.addTarget(self, action: "cancelClick", forControlEvents: UIControlEvents.TouchDown)
        
        self.navigationItem.leftBarButtonItem = leftItem
    }
    
    private lazy var progressView:UIProgressView = {
        let pView = UIProgressView()
        pView.trackTintColor = FlatUIColors.silverColor(1)//UIColor.orangeColor()
        pView.progressTintColor = UIColor.clearColor()
        self.view.addSubview(pView)
        pView.snp_makeConstraints(closure: { (make) -> Void in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(3)
        })
        return pView
    }()
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if (keyPath == "estimatedProgress") {
            progressView.hidden = webView.estimatedProgress == 1
            progressView.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    func cancelClick(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
