//
//  HomePageScanController.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/12/28.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class HomePageScanController: LBXScanViewController {

    private func initTitleArea(){
        let leftItem =
        UIBarButtonItem(title: "嘿嘿", style: UIBarButtonItemStyle.Done, target: self, action: "cancelClick")
        var customView = UIArrowView(frame:CGRectMake(0, 0, 10, 22))
        customView.direction = .LEFT
        ////        customView.isClosed = true
        customView.lineColor = UIColor.whiteColor()
        customView.lineThinkness = 2
        ////        customView.fillColor = UIColor.blueColor()
        leftItem.customView = customView
        customView.addTarget(self, action: "cancelClick", forControlEvents: UIControlEvents.TouchDown)
        
        self.navigationItem.leftBarButtonItem = leftItem
        
        let titleView = UIView()
        let label:UILabel = UICreaterUtils.createLabel(20, UIColor.whiteColor(), "二维码扫描", true, titleView)
        label.font = UIFont.systemFontOfSize(20,weight:2)//20号
        
        titleView.addSubview(label)
        label.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(titleView)
        }
        
        self.navigationItem.titleView = titleView
    }
    
    func cancelClick(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTitleArea()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
