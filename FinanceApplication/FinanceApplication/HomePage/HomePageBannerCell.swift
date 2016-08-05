//
//  HomePageBannerCell.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/10/31.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit
import CoreLibrary

class HomePageBannerCell: BaseTableViewCell,SDCycleScrollViewDelegate {
   
    override func showSubviews(){
        initImage()
    }
    
//    private var imageArray:NSArray = [
//        "http://pica.nipic.com/2007-10-12/20071012203817959_2.jpg",
//        "http://img.taopic.com/uploads/allimg/130508/240394-13050PS54434.jpg",
////        "http://img1.3lian.com/img2008/06/019/ych.jpg",
//        "http://pic1.nipic.com/2009-02-02/2009228442757_2.jpg"
//    ]
    private var imageArray:NSArray = [
    "https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
    "https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
    "http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg",
        "http://www.91miaoda.com/static/uploads/201512046066803863784.jpg",
        "http://www.91miaoda.com/static/uploads/201512079917339252587.jpg",
    ];
    
    private var cycleScrollView:SDCycleScrollView!
//    private var imageSlide:ImageSlideView!
//    private var bannerView:UIImageView!
    private func initImage(){
        if cycleScrollView == nil{
            cycleScrollView = SDCycleScrollView()
            self.contentView.addSubview(cycleScrollView)
//            bannerView.contentMode = UIViewContentMode.ScaleAspectFill
//            imageSlide.backgroundColor = UIColor.clearColor()
            cycleScrollView.infiniteLoop = true;
            cycleScrollView.delegate = self
            cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
            //         --- 轮播时间间隔，默认1.0秒，可自定义
            cycleScrollView.autoScrollTimeInterval = 4.0;
            
            cycleScrollView.snp_makeConstraints(closure: { (make) -> Void in
                make.left.right.top.bottom.equalTo(self.contentView)
            })
        }
        cycleScrollView.imageURLStringsGroup = imageArray as [AnyObject];
//        imageSlide.dataSource = imageArray as? [String]
//        var url:String = data as! String
//        BatchLoaderUtil.loadFile(url, callBack: { (image, params) -> Void in
//            self.bannerView.image = image
//        })
//        self.contentView.clipsToBounds = true
    }

    func cycleScrollView(cycleScrollView: SDCycleScrollView!, didSelectItemAtIndex index: Int) {
        let webController = DetailsWebPageController()
        webController.linkUrl = "https://m.baidu.com/from=844b/s?word="
        
        let nc = NSNotification(name: "Home:pushView", object: webController)
        NSNotificationCenter.defaultCenter().postNotification(nc)
    }
}
