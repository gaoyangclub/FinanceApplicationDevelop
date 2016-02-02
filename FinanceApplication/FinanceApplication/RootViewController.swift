//
//  ViewController.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/10/17.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class RootViewController: TabViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initData()
    }

    private func initData(){
//        let homePage = HomePageController()
//        homePage.navigationItem// = self.navigationItem
        dataProvider = [
//            TabData(data: TabRendererVo(title:"标题1",iconUrl:"icon_08"),controller: HomePageNavigationControl(rootViewController: HomePageController())),
            TabData(data: TabRendererVo(title:"精选",iconUrl:"icon_08"),controller: HomePageController()),
            TabData(data: TabRendererVo(title:"理财超市",iconUrl:"icon_02"),controller: FundPageHomeController()),
//            TabData(data: TabRendererVo(title:"标题3",iconUrl:"icon_01"),controller: AViewController()),
            TabData(data: TabRendererVo(title:"资产",iconUrl:"icon_06"),controller: AViewController()),
            TabData(data: TabRendererVo(title:"我的",iconUrl:"icon_05"),controller: AViewController())
        ]
        itemClass = MyTabItemRenderer.self
//        tabBarHeight = 40
        
//        self.navigationItem.hi
//        println(CalculateUtils.getChartGroupList(190, negativeValue: 500, segments: 5))
        
        
//        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
//        let leftItem = //UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "cancelClick")
//        UIBarButtonItem(title: "扫描", style: UIBarButtonItemStyle.Done, target: self, action: nil)
//        self.navigationItem.leftBarButtonItem = leftItem
//
//        let rightItem = UIBarButtonItem(title: "消息", style: UIBarButtonItemStyle.Done, target: self, action: nil)
//        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

