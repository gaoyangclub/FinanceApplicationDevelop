//
//  FundPageHomeHotCell.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/12/16.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class FundPageHomeHotCell: BaseTableViewCell {
    
    
    static let cellHeight:CGFloat = 108
    
    private let hotList:[FundHotVo] = [
        FundHotVo(icon: "fundHot01", title: "大盘走势", link: "http://www.qq.com"),
        FundHotVo(icon: "fundHot02", title: "投资咨询", link: "http://www.qq.com"),
        FundHotVo(icon: "fundHot03", title: "收益排行", link: "http://www.qq.com"),
        FundHotVo(icon: "fundHot04", title: "我的关注", link: "http://www.qq.com")
    ]
    
//    private var iconContainer:UIView!
    override func layoutSubviews(){
        self.contentView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        initCell()
    }
    
    private lazy var bottomLine:UIView = {
        let view:UIView = UIView()
        view.backgroundColor = UICreaterUtils.normalLineColor
        self.addSubview(view)
        return view
        }()
    
    private func initCell(){
        self.contentView.removeAllSubViews() //先全部移除
        
        bottomLine.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(UICreaterUtils.normalLineWidth)
        }
        
        var preItem:UIView?
        for i in 0..<hotList.count{
            let area:UIControl = UIControl()
            area.tag = i
            area.addTarget(self, action: "hotClickHandler:", forControlEvents: UIControlEvents.TouchUpInside)
            self.contentView.addSubview(area)
            area.snp_makeConstraints(closure: { (make) -> Void in
                make.top.bottom.equalTo(self.contentView)
                make.width.equalTo(self.contentView).dividedBy(hotList.count)
//                make.left.equalTo(self.contentView.snp_width).multipliedBy(Double(i) / Double(hotList.count))
                if preItem != nil{
                    make.left.equalTo(preItem!.snp_right)
                }else{
                    make.left.equalTo(0)
                }
            })
            
            let titleLabel = UICreaterUtils.createLabel(12, UICreaterUtils.colorBlack, hotList[i].title, true, area)
            titleLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.centerX.equalTo(area)
                make.bottom.equalTo(-18)
            })
            
            let imageView = UIImageView()
            imageView.contentMode = UIViewContentMode.ScaleAspectFit //保持比例
            area.addSubview(imageView)
            imageView.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(46)
                make.centerX.equalTo(area)
                make.top.equalTo(18)
            })
            BatchLoaderForSwift.loadFile(hotList[i].icon, callBack: { (image) -> Void in
                imageView.image = image
            })
            preItem = area
        }
    }
    
    
    
    func hotClickHandler(area:UIControl){
        let link = hotList[area.tag].link
//        println("链接:" + link)
        let webController = DetailsWebPageController()
        webController.linkUrl = link//"https://m.baidu.com/from=844b/s?word=" + noticeVo.title
        
        let nc = NSNotification(name: "FundHome:pushView", object: webController)
        NSNotificationCenter.defaultCenter().postNotification(nc)
    }
    
    


}
class FundHotVo{
    
    init(icon:String,title:String,link:String){
        self.icon = icon
        self.title = title
        self.link = link
    }
    var icon:String!
    var title:String!
    var link:String!
    
    
}
