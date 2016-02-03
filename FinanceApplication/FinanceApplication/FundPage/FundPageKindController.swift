//
//  FundPageKindConrtollerViewController.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/12/18.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class FundPageKindConrtoller: UIViewController {

    var selectedIndex:Int = 0
    
    private var pageMenu:CAPSPageMenu!
    
    private func initTitleView(){
//        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        let leftItem = //UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "cancelClick")
        UIBarButtonItem(title: "嘿嘿", style: UIBarButtonItemStyle.Done, target: self, action: "cancelClick")
        let customView = UIArrowView(frame:CGRectMake(0, 0, 10, 22))
        customView.direction = .LEFT
        customView.lineColor = UIColor.whiteColor()
        customView.lineThinkness = 2
        leftItem.customView = customView
        customView.addTarget(self, action: "cancelClick", forControlEvents: UIControlEvents.TouchDown)
        
        let tabItem1 = UIFlatImageTabItem()
        tabItem1.frame = CGRectMake(0, 0, 30, 24)
        tabItem1.sizeType = .FillWidth
        tabItem1.normalColor = UIColor.whiteColor()
        //        tabItem.selectColor = UICreaterUtils.colorRise
        BatchLoaderForSwift.loadFile("magnifie", callBack: { (image) -> Void in
            tabItem1.image = image
        })
        tabItem1.addTarget(self, action: "searchClick", forControlEvents: UIControlEvents.TouchDown)
        let rightItem1 =
        UIBarButtonItem(title: "嘿嘿", style: UIBarButtonItemStyle.Done, target: self, action: "searchClick")
        rightItem1.customView = tabItem1
        
        let tabItem2 = UIFlatImageTabItem()
        tabItem2.frame = CGRectMake(0, 0, 30, 24)
        tabItem2.sizeType = .FillWidth
        tabItem2.normalColor = UIColor.whiteColor()
        //        tabItem.selectColor = UICreaterUtils.colorRise
        BatchLoaderForSwift.loadFile("campaign", callBack: { (image) -> Void in
            tabItem2.image = image
        })
        tabItem2.addTarget(self, action: "setupClick", forControlEvents: UIControlEvents.TouchDown)
        let rightItem2 =
        UIBarButtonItem(title: "嘿嘿", style: UIBarButtonItemStyle.Done, target: self, action: "setupClick")
        rightItem2.customView = tabItem2
        
        self.navigationItem.leftBarButtonItem = leftItem
//        self.navigationItem.rightBarButtonItem = rightItem
        self.navigationItem.rightBarButtonItems = [rightItem2,rightItem1]
        self.title = "基金筛选"
        
        self.view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        let titleView = UIView()
        let label:UILabel = UICreaterUtils.createLabel(20, UIColor.whiteColor(), "基金筛选", true, titleView)
        label.font = UIFont.systemFontOfSize(20)//20号 ,weight:2
        
        titleView.addSubview(label)
        label.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(titleView)
        }
        
        self.navigationItem.titleView = titleView
    }
    
    func pushView(nc:NSNotification){
        let nextController = nc.object as! UIViewController
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTitleView()
        
        self.view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pushView:", name: "FundFilter:pushView",object:nil)
        self.automaticallyAdjustsScrollViewInsets = false//YES表示自动测量导航栏高度占用的Insets偏移

        var controllerArray : [UIViewController] = []
        let titleList:[InfoFundHeader] = DataRemoteFacade.getFundHomeTitleList()
        for header in titleList{
            let controller:FundPageFilterController = FundPageFilterController()
            controller.title = header.title
            controller.fundHeader = header
            controllerArray.append(controller)
        }
        // Initialize page menu with controller array, frame, and optional parameters
        let parameters: [CAPSPageMenuOption] = [
//            .MenuHeight(100),
            .MenuItemWidth(60),
            .MenuMargin(10),
            //                CAPSPageMenuOption.MenuItemWidthBasedOnTitleTextWidth(true),
            .ScrollMenuBackgroundColor(UIColor.clearColor()),
            .ViewBackgroundColor(UIColor.clearColor()),
            CAPSPageMenuOption.SelectionIndicatorColor(UICreaterUtils.colorRise),
            //            CAPSPageMenuOption.MenuItemSeparatorColor(UIColor.orangeColor()),
            //            .BottomMenuHairlineColor(UIColor.grayColor()),
            //            .UseMenuLikeSegmentedControl(true),
            //            .MenuItemSeparatorPercentageHeight(0.5),
            .UnselectedMenuItemLabelColor(UICreaterUtils.colorBlack),
            .SelectedMenuItemLabelColor(UICreaterUtils.colorRise),
            CAPSPageMenuOption.MenuItemSeparatorUnderline(true),
            .MenuItemFont(UIFont.systemFontOfSize(14)),//,weight:1.2
            .SelectionIndicatorHeight(2),
            .CenterMenuItems(true),
            .AddBottomMenuHairline(false)
        ]
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
//        pageMenu.currentPageIndex = selectedIndex
        pageMenu.moveToPage(selectedIndex)//动作切换完毕
        
//        pageMenu.moveToPage(selectedIndex)
        self.view.addSubview(pageMenu!.view)
    }

//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
////        pageMenu.moveToPage(selectedIndex)//动作切换完毕
//    }
    
    func cancelClick(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func searchClick(){
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
    }
    
    func setupClick(){
        self.drawerController.toggleDrawerSide(MMDrawerSide.Right, animated: true, completion: { _ -> Void in
            
        })
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
