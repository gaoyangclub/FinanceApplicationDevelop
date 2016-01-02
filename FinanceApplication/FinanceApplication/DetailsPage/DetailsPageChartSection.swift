//
//  DetailsPageChartSection.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/11/15.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit
typealias pageMenuCompletionHandler = (pageMenu:CASectionPageMenu)->Void
class DetailsPageChartSection:BaseItemRenderer{

    var pageMenuInit:pageMenuCompletionHandler?
    
    var pageMenu:CASectionPageMenu!
    override func layoutSubviews() {
        initPageMenu()
    }
    
    private func initPageMenu(){
        if pageMenu == nil{
            
            self.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            
            let topLine = UIView()
            addSubview(topLine)
            topLine.backgroundColor = UICreaterUtils.normalLineColor
            topLine.snp_makeConstraints(closure: { (make) -> Void in
                make.left.right.top.equalTo(self)
                make.height.equalTo(UICreaterUtils.normalLineWidth)
            })
            
            let bottomLine = UIView()
            addSubview(bottomLine)
            bottomLine.backgroundColor = UICreaterUtils.normalLineColor
            bottomLine.snp_makeConstraints(closure: { (make) -> Void in
                make.left.right.bottom.equalTo(self)
                make.height.equalTo(UICreaterUtils.normalLineWidth)
            })
            let titleArray = ["净值增长率","日增长率","净值估算"]
            let menuItemWidth:CGFloat = 80
            let viewWidth = self.frame.width
            let padding:CGFloat = 20
            let menuMargin = (viewWidth - padding * 2 - menuItemWidth * CGFloat(titleArray.count)) / CGFloat(titleArray.count)
//            println("menuMargin:\(menuMargin)")
            
            var parameters: [CAPSPageMenuOption] = [
                .MenuItemWidth(menuItemWidth),
                .MenuMargin(menuMargin),
//                CAPSPageMenuOption.MenuItemWidthBasedOnTitleTextWidth(true),
                .ScrollMenuBackgroundColor(UIColor.clearColor()),
                .ViewBackgroundColor(UIColor.clearColor()),
                CAPSPageMenuOption.SelectionIndicatorColor(UIColor(red: 246/255, green: 54/255, blue: 71/255, alpha: 1)),
                //            CAPSPageMenuOption.MenuItemSeparatorColor(UIColor.orangeColor()),
                //            .BottomMenuHairlineColor(UIColor.grayColor()),
                //            .UseMenuLikeSegmentedControl(true),
                //            .MenuItemSeparatorPercentageHeight(0.5),
                .UnselectedMenuItemLabelColor(UIColor.blackColor()),
                .SelectedMenuItemLabelColor(UIColor.blackColor()),
                .MenuItemFont(UIFont.systemFontOfSize(14)),
                .SelectionIndicatorHeight(2),
                .CenterMenuItems(true),
                .AddBottomMenuHairline(false)
            ]
            pageMenu = CASectionPageMenu(pageMenuOptions: parameters)//,frame:CGRectMake(0, 0, self.frame.width, self.frame.height)
            addSubview(pageMenu)
            pageMenu.titleArray = titleArray
            
            pageMenu.snp_makeConstraints(closure: { (make) -> Void in
                make.left.right.top.bottom.equalTo(self)
            })
            
            if pageMenuInit != nil{
                pageMenuInit!(pageMenu: pageMenu)
            }
        }
    }
    
    
}
