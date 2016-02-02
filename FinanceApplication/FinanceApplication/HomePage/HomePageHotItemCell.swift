//
//  HomePageHotItemCell.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/11/1.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class HomePageHotItemCell: BaseTableViewCell {

//    override func drawRect(rect: CGRect) {
//        //设置圆角矩形范围
////        var path = UIBezierPath(roundedRect: rect,
////            byRoundingCorners: UIRectCorner.AllCorners,
////            cornerRadii: CGSize(width: 10.0, height: 10.0))
//        var make:CGRect = CGRectMake(rect.origin.x + margin, rect.origin.y, rect.width - margin * 2, rect.height)
//        var path = UIBezierPath(rect: make);
//        UIColor.whiteColor().setFill()
//        path.fill()
//        
//        var lineWidth:CGFloat = 1
//        var linePath = UIBezierPath()
//        linePath.lineWidth = lineWidth
//        
//        if(isFirst){
//            linePath.moveToPoint(CGPoint(x:margin,y:rect.origin.y))
//            linePath.addLineToPoint(CGPoint(x:rect.width - margin,y:rect.origin.y))
//        }
//        if(isLast){
//            linePath.moveToPoint(CGPoint(x:margin,y:rect.origin.y + rect.height))
//        }else{
//            linePath.moveToPoint(CGPoint(x:leftpadding,y:rect.origin.y + rect.height))
//        }
//        linePath.addLineToPoint(CGPoint(x:rect.width - margin,y:rect.origin.y + rect.height))
//
//        var lineColor:UIColor = UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
//        lineColor.setStroke()
//        linePath.stroke()
//        
////        linePath.lineWidth = 0.6
////        linePath.moveToPoint(CGPoint(x:margin,y:rect.origin.y))
////        linePath.addLineToPoint(CGPoint(x:margin,y:rect.origin.y + rect.height))
////        linePath.moveToPoint(CGPoint(x:rect.width - margin,y:rect.origin.y))
////        linePath.addLineToPoint(CGPoint(x:rect.width - margin,y:rect.origin.y + rect.height))
////
////        lineColor.setStroke()
////        linePath.stroke()
//        
////        path.addClip()//减去(遮罩)成为圆角矩形
//    }
    
    override func layoutSubviews(){
        initBack()
        initLabel()
    }
    
    private var lineColor = UICreaterUtils.normalLineColor//UIColor(red: 217/255, green: 217/255, blue: 217/255, alpha: 1)
//    private var lineWidth:CGFloat = 0.5
    private var leftLine:UIView!
    private var rightLine:UIView!
    private var topLine:UIView?
    private var bottomLine:UIView!
    private var backView:UIView!
    
    private func initBack(){
        
        if backView == nil{
            backView = UIView()
            self.contentView.addSubview(backView)
            backView.backgroundColor = UIColor.whiteColor()
            backView.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self.contentView).offset(margin)
                make.right.equalTo(self.contentView).offset(-margin)
                make.top.bottom.equalTo(self.contentView)
            })
        }
        if isFirst{
            if topLine == nil{
                topLine = UIView()
                self.contentView.addSubview(topLine!)
                topLine?.backgroundColor = lineColor
                topLine?.snp_makeConstraints(closure: { (make) -> Void in
                    make.top.left.right.equalTo(self.backView)
                    make.height.equalTo(UICreaterUtils.normalLineWidth)
                })
            }
            topLine?.hidden = false
        }else{
            topLine?.hidden = true
        }
        
        if leftLine == nil{
            leftLine = UIView()
            self.contentView.addSubview(leftLine)
            leftLine.backgroundColor = lineColor
            
            leftLine.snp_makeConstraints(closure: { (make) -> Void in
                make.top.bottom.left.equalTo(self.backView)
                make.width.equalTo(UICreaterUtils.normalLineWidth)
            })
        }
        if rightLine == nil{
            rightLine = UIView()
            self.contentView.addSubview(rightLine)
            rightLine.backgroundColor = lineColor
            
            rightLine.snp_makeConstraints(closure: { (make) -> Void in
                make.top.bottom.right.equalTo(self.backView)
                make.width.equalTo(UICreaterUtils.normalLineWidth)
            })
        }
        if bottomLine == nil{
            bottomLine = UIView()
            self.contentView.addSubview(bottomLine)
            bottomLine.backgroundColor = lineColor
            bottomLine.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(UICreaterUtils.normalLineWidth)
            })
        }
        bottomLine.snp_updateConstraints(closure: { (make) -> Void in
            if isLast{
                make.left.right.bottom.equalTo(self.backView)
            }else{
                make.right.bottom.equalTo(self.backView)
                make.left.equalTo(self.backView).offset(leftpadding)
            }
        })
    }
    
    private var titleLabel:UILabel!
    private var contentLabel:UILabel!
    private var rateLabel:UILabel!
    private var rateTitleLabel:UILabel!
//    private var icon:UIImageView?
    
    private let margin:CGFloat = 5.0
    private let leftpadding:CGFloat = 35
    private let rightpadding:CGFloat = 20
    
    private lazy var iconView:UIFlatImageTabItem = {
        let icon = UIFlatImageTabItem()
        icon.userInteractionEnabled = false
        icon.sizeType = .FillWidth
        icon.normalColor = UICreaterUtils.colorRise
        self.contentView.addSubview(icon)
        return icon
        }()
    
    private func initLabel(){
        if titleLabel == nil {
            titleLabel = UILabel()
            titleLabel.textColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1)
            if(isFirst){
                titleLabel.font = UIFont.systemFontOfSize(16)
            }else{
                titleLabel.font = UIFont.systemFontOfSize(14)
            }
            self.contentView.addSubview(titleLabel)
            titleLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self.contentView).offset(leftpadding)
                make.bottom.equalTo(self.contentView.snp_centerY)
            })
        }
        if contentLabel == nil {
            contentLabel = UILabel()
            contentLabel.textColor = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
            contentLabel.font = UIFont.systemFontOfSize(12)
            self.contentView.addSubview(contentLabel)
            contentLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self.titleLabel)
                make.top.equalTo(self.snp_centerY).offset(5)
            })
        }
        if rateLabel == nil {
            rateLabel = UILabel()
            rateLabel.textColor = UIColor(red: 209/255, green: 0/255, blue: 0/255, alpha: 1)
            rateLabel.font = UIFont.systemFontOfSize(14)
            self.contentView.addSubview(rateLabel)
            rateLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(self.contentView).offset(-rightpadding)
                make.bottom.equalTo(self.titleLabel)
            })
        }
        if rateTitleLabel == nil {
            rateTitleLabel = UILabel()
            rateTitleLabel.textColor = UIColor(red: 168/255, green: 168/255, blue: 168/255, alpha: 1)
            rateTitleLabel.font = UIFont.systemFontOfSize(14)
            self.contentView.addSubview(rateTitleLabel)
            rateTitleLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(self.rateLabel)
                make.top.equalTo(self.contentLabel)
            })
        }
        
        let hvo:HotItemVo = data as! HotItemVo
        titleLabel.text = hvo.title
        contentLabel.text = hvo.content
        rateLabel.text = hvo.rate
        rateTitleLabel.text = hvo.rateTitle
        
        titleLabel.sizeToFit()
        contentLabel.sizeToFit()
        rateLabel.sizeToFit()
        rateTitleLabel.sizeToFit()
        
        if isFirst{
            
//            if icon == nil{
//                icon = UIImageView()
//                addSubview(icon!)
//                icon?.snp_makeConstraints(closure: { (make) -> Void in
//                    make.right.equalTo(self.titleLabel.snp_left).offset(-6)
//                    make.centerY.equalTo(self.titleLabel)
//                })
//            }
            iconView.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(18)
//                make.size.equalTo(CGSize(width: 48, height: 24))
                make.left.equalTo(self.backView)
                make.right.equalTo(self.titleLabel.snp_left)
                make.centerY.equalTo(self.titleLabel)
            })
            
            let url:String = "like"//"lightning"
            BatchLoaderUtil.loadFile(url, callBack: { (image, params) -> Void in
                self.iconView.image = image
            })
            iconView.hidden = false
        }else{
            iconView.hidden = true
        }
        
        
        backgroundColor = UIColor.clearColor()
        
//        setNeedsDisplay()
    }
    
    
    
}
