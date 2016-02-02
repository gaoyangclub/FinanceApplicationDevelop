//
//  DetailInfoCell.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/11/8.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class DetailsPageInfoCell: BaseTableViewCell {
    
    override func layoutSubviews(){
        initContainer()
        initLine()
        initLabel()
    }
    
    private var rateDayText:UILabel!
    private var rateQuarterText:UILabel!
    private var updateTimeText:UILabel!
    private var netValueText:UILabel!
    private var rankText:UILabel!
    private var buyRateTagText:UILabel!
    private var buyRateOriginalText:UILabel!
    private var buyRateCurrentText:UILabel!
    
    private func initLabel(){
        let baseTextColor:UIColor = UIColor(red: 156/255, green: 156/255, blue: 156/255, alpha: 1)
        let baseTextSize:CGFloat = 14
        let dvo = data as! InfoFundVo//主数据
        
        if rateDayText == nil{
            rateDayText = UICreaterUtils.createLabel(20,UIColor(red: 213/255, green: 0, blue: 0, alpha: 1))
            rateContainer.addSubview(rateDayText)
            rateDayText.snp_makeConstraints(closure: { (make) -> Void in
                make.bottom.equalTo(topVerticalLine)
                make.left.equalTo(rateContainer).offset(margin)
            })
            let rateDayLabel = UICreaterUtils.createLabel(baseTextSize,baseTextColor,"日涨跌幅")
            rateContainer.addSubview(rateDayLabel)
            rateDayLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(topVerticalLine)
                make.left.equalTo(rateContainer).offset(margin)
            })
        }
        rateDayText.text = "\(dvo.rateDay * 100)%"
        if dvo.rateDay == 0{
            rateDayText.textColor = UIColor.blackColor()
        }else if dvo.rateDay > 0{
            rateDayText.textColor = UICreaterUtils.colorRise
        }else{
            rateDayText.textColor = UICreaterUtils.colorDrop
        }
        
        rateDayText.sizeToFit()
        
        if rateQuarterText == nil{
            rateQuarterText = UICreaterUtils.createLabel(20,UIColor.blackColor())
            rateContainer.addSubview(rateQuarterText)
            rateQuarterText.snp_makeConstraints(closure: { (make) -> Void in
                make.bottom.equalTo(topVerticalLine)
                make.left.equalTo(topVerticalLine).offset(margin)
            })
            let rateQuarterabel = UICreaterUtils.createLabel(baseTextSize,baseTextColor,"近三个月涨幅")
            rateContainer.addSubview(rateQuarterabel)
            rateQuarterabel.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(topVerticalLine)
                make.left.equalTo(topVerticalLine).offset(margin)
            })
        }
        rateQuarterText.text = String(format: "%.2f", dvo.rateQuarter * 100) + "%"
        rateQuarterText.sizeToFit()
        
        tagArea.removeAllSubViews()
        
        var tagArr:[String] = [DataRemoteFacade.getFundHeaderTitle(dvo.kind)]
        if dvo.enoughTag == 1{ //有折扣
            tagArr.append("百元起够")
        }else if dvo.enoughTag == 2{
            tagArr.append("500元起够")
        }
        if tagArr.count > 0{
            var leftView:UIView? = nil
            
//            var uiTextField = UITextField(frame: CGRectMake(0, 0, 50, 30))//createTextField(baseTextSize, UIColor.blackColor(), "aaaa")
////            uiTextField.placeholder = "aaaa"
//            //设置富文本
//            var attstr:NSMutableAttributedString = NSMutableAttributedString(string: "请输入姓名")
//            attstr.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: NSMakeRange(0, 5))
//            //NSMakeRange决定从第几个到第几个的文字应用效果
////            uiTextField.attributedPlaceholder = attstr
//            uiTextField.textAlignment = NSTextAlignment.Center;
//            uiTextField.borderStyle = UITextBorderStyle.RoundedRect //边框样式
//            uiTextField.backgroundColor = UIColor.clearColor()
//            tagArea.addSubview(uiTextField)
            for tag in tagArr{
                let label:UILabel = UICreaterUtils.createLabel(12, UIColor.blackColor(), tag)
                label.sizeToFit()
                
                let subView:UIView = UIView()
                tagArea.addSubview(subView)
                
                subView.addSubview(label)
                label.snp_makeConstraints { (make) -> Void in
                    make.center.equalTo(subView)
                }
                subView.layer.borderColor = baseTextColor.CGColor
                subView.layer.borderWidth = 0.6
                subView.layer.cornerRadius = 3
                subView.snp_makeConstraints { (make) -> Void in
                    make.width.equalTo(label).offset(10)
                    make.height.equalTo(label).offset(6)
                }
                //        subView.backgroundColor = UIColor.clearColor()
                
                if leftView == nil{
                    subView.snp_makeConstraints(closure: { (make) -> Void in
                        make.left.top.equalTo(tagArea)
                    })
                }else{
                    subView.snp_makeConstraints(closure: { (make) -> Void in
                        make.top.equalTo(tagArea)
                        make.left.equalTo(leftView!.snp_right).offset(10)
                    })
                }
                leftView = subView
            }
        }
//
        if updateTimeText == nil{
            updateTimeText = UICreaterUtils.createLabel(baseTextSize, baseTextColor)
            tagContainer.addSubview(updateTimeText)
            updateTimeText.snp_makeConstraints(closure: { (make) -> Void in
                make.centerY.equalTo(tagContainer)
                make.right.equalTo(tagContainer).offset(-margin)
            })
        }
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy.MM.dd";
        let dateName:String = fmt.stringFromDate(dvo.updateTime!)
        updateTimeText.text = dateName + "更新";
        updateTimeText.sizeToFit()
        
        if netValueText == nil{
            let rightArrow:UIArrowView = UIArrowView()
            rightArrow.direction = ArrowDirect.RIGHT
            rightArrow.lineColor = baseTextColor
            netContainer.addSubview(rightArrow)
            rightArrow.snp_makeConstraints(closure: { (make) -> Void in
                make.width.equalTo(8)
                make.height.equalTo(14)
//                make.size.equalTo(CGSize(width: 8, height: 14))
                make.centerY.equalTo(netContainer)
                make.right.equalTo(topVerticalLine).offset(-margin)
            })
            
            netValueText = UICreaterUtils.createLabel(18, UIColor.blackColor())
            netContainer.addSubview(netValueText)
            
            let measureUnitLabel = UICreaterUtils.createLabel(12, baseTextColor, "元")
            netContainer.addSubview(measureUnitLabel)
            measureUnitLabel.sizeToFit()
            measureUnitLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(rightArrow.snp_left).offset(-6)
                make.bottom.equalTo(netValueText).offset(-3)
//                make.centerY.equalTo(netContainer)
            })
            
            netValueText.snp_makeConstraints(closure: { (make) -> Void in
                make.centerY.equalTo(netContainer)
                make.right.equalTo(measureUnitLabel.snp_left)
            })
            
            let netValueLabel = UICreaterUtils.createLabel(baseTextSize, baseTextColor, "净值")
            netContainer.addSubview(netValueLabel)
            netValueLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.centerY.equalTo(netContainer)
                make.left.equalTo(netContainer).offset(margin)
            })
        }
        netValueText.text = String(format: "%.4f",dvo.netValue)
        netValueText.sizeToFit()
        
        if rankText == nil{
            let rightArrow:UIArrowView = UIArrowView()
            rightArrow.direction = ArrowDirect.RIGHT
            rightArrow.lineColor = baseTextColor
            netContainer.addSubview(rightArrow)
            rightArrow.snp_makeConstraints(closure: { (make) -> Void in
                make.width.equalTo(8)
                make.height.equalTo(14)
//                make.size.equalTo(CGSize(width: 8, height: 14))
                make.centerY.equalTo(netContainer)
                make.right.equalTo(netContainer).offset(-margin)
            })
            
            rankText = UICreaterUtils.createLabel(16, UIColor.blackColor())
            netContainer.addSubview(rankText)
            rankText.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(rightArrow.snp_left).offset(-6)
                make.centerY.equalTo(netContainer)
            })
            
            let bottomLabel = UICreaterUtils.createLabel(12, baseTextColor, "(季度同类)")
            netContainer.addSubview(bottomLabel)
            bottomLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.bottom.equalTo(netContainer.snp_centerY).offset(15)
                make.left.equalTo(topVerticalLine).offset(2)
            })
            let topLabel = UICreaterUtils.createLabel(baseTextSize, baseTextColor, "排名")
            netContainer.addSubview(topLabel)
            topLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(netContainer.snp_centerY).offset(-15)
                make.centerX.equalTo(bottomLabel)
            })
        }
        rankText.text = dvo.rank
        rankText.sizeToFit()
        
        if buyRateTagText == nil{
            let buyRateTagLabel = UICreaterUtils.createLabel(baseTextSize, baseTextColor, "购买费率")
            rateContainer.addSubview(buyRateTagLabel)
            buyRateTagLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(rateContainer).offset(margin)
                make.centerY.equalTo(rateContainer)
            })
            
            buyRateTagText = UICreaterUtils.createLabel(baseTextSize, UIColor.redColor())
            rateContainer.addSubview(buyRateTagText)
            buyRateTagText.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(buyRateTagLabel.snp_right).offset(2)
                make.centerY.equalTo(rateContainer)
            })
        }
        buyRateTagText.text = "\(dvo.discount * 10)折"
        buyRateTagText.sizeToFit()
        
        if buyRateOriginalText == nil{
            buyRateOriginalText = UICreaterUtils.createLabel(baseTextSize, UIColor.blackColor())
            rateContainer.addSubview(buyRateOriginalText)
            buyRateOriginalText.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(buyRateTagText.snp_right).offset(2)
                make.centerY.equalTo(rateContainer)
            })
            
            let originalLine = UIView()
            originalLine.backgroundColor = UIColor.blackColor()
            rateContainer.addSubview(originalLine)
            originalLine.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(1)
                make.left.width.equalTo(buyRateOriginalText)
                make.centerY.equalTo(rateContainer)
            })
        }
        buyRateOriginalText.text = String(format: "%.2f", dvo.buyRateCurrent / dvo.discount * 100) + "%"
        buyRateOriginalText.sizeToFit()
        
        if buyRateCurrentText == nil{
            let rightArrow:UIArrowView = UIArrowView()
            rightArrow.direction = ArrowDirect.RIGHT
            rightArrow.lineColor = baseTextColor
            rateContainer.addSubview(rightArrow)
            rightArrow.snp_makeConstraints(closure: { (make) -> Void in
                make.width.equalTo(8)
                make.height.equalTo(14)
//                make.size.equalTo(CGSize(width: 8, height: 14))
                make.centerY.equalTo(rateContainer)
                make.right.equalTo(rateContainer).offset(-margin)
            })
            
            buyRateCurrentText = UICreaterUtils.createLabel(20,UIColor(red: 213/255, green: 0, blue: 0, alpha: 1))
            rateContainer.addSubview(buyRateCurrentText)
            buyRateCurrentText.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(rightArrow.snp_left).offset(-6)
                make.centerY.equalTo(rateContainer)
            })
        }
        buyRateCurrentText.text = "\(dvo.buyRateCurrent * 100)%"
        buyRateCurrentText.sizeToFit()
    }
    
//    private func createTagView(size:CGFloat,_ color:UIColor,_ text:String = "")->UIView{
//        var label:UILabel = createLabel(size,color,text)
//        label.sizeToFit()
//    }
    
    private func createTextField(size:CGFloat,_ color:UIColor,_ text:String = "")->UITextField{
        let uiTextField = UITextField(frame: CGRectMake(0, 0, 50, 30))
        uiTextField.minimumFontSize = 18.0;//设置最小显示字体
        uiTextField.placeholder = "请输入姓名"
        uiTextField.userInteractionEnabled = false
        uiTextField.font = UIFont.systemFontOfSize(size)//20号
//        uiTextField.textColor = color
        uiTextField.text = "aa"//text
        uiTextField.textAlignment = NSTextAlignment.Center;
        uiTextField.borderStyle = UITextBorderStyle.RoundedRect //边框样式
//        uiTextField.backgroundColor = UIColor.clearColor()//UIColor.magentaColor()
        //        ti.layer.cornerRadius = 2//圆角
//        uiTextField.adjustsFontSizeToFitWidth = true;//文本字体自适应整体宽度
//        uiTextField.sizeToFit()
        return uiTextField
    }
    
    private var topVerticalLine:UIView!
    private func initLine(){
        if topVerticalLine == nil{
            let lineColor:UIColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1)
            
            topVerticalLine = UIView()
            topVerticalLine.backgroundColor = lineColor
            topContainer.addSubview(topVerticalLine)
            topVerticalLine.snp_makeConstraints(closure: { (make) -> Void in
                make.center.equalTo(self.topContainer)
//                make.size.equalTo(CGSize(width: UICreaterUtils.normalLineWidth, height: DetailsPageInfoCell.topHeight * 3 / 5))
                make.width.equalTo(UICreaterUtils.normalLineWidth)
                make.height.equalTo(DetailsPageInfoCell.topHeight * 3 / 5)
            })
            
            let topLine = UIView()
            addSubview(topLine)
            topLine.backgroundColor = lineColor
            topLine.snp_makeConstraints(closure: { (make) -> Void in
                make.top.left.right.equalTo(self)
                make.height.equalTo(UICreaterUtils.normalLineWidth)
            })
            
            let fLine = UIView()
            addSubview(fLine)
            fLine.backgroundColor = lineColor
            fLine.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self).offset(margin)
                make.right.equalTo(self).offset(-margin)
                make.height.equalTo(UICreaterUtils.normalLineWidth)
                make.bottom.equalTo(self.tagContainer)
            })
            
            let sLine = UIView()
            addSubview(sLine)
            sLine.backgroundColor = lineColor
            sLine.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self).offset(margin)
                make.right.equalTo(self).offset(-margin)
                make.height.equalTo(UICreaterUtils.normalLineWidth)
                make.bottom.equalTo(self.netContainer)
            })
            
//            var bottomLine = UIView()
//            addSubview(bottomLine)
//            bottomLine.backgroundColor = lineColor
//            bottomLine.snp_makeConstraints(closure: { (make) -> Void in
//                make.bottom.left.right.equalTo(self)
//                make.height.equalTo(UICreaterUtils.normalLineWidth)
//            })
        }
    }
    
    private static let topHeight:CGFloat = 80
    private static let tagHeight:CGFloat = 50
    private let margin = 18
    
    static var cellHeight:CGFloat{
        get{
            return topHeight + tagHeight * 3
        }
    }
    
    private var topContainer:UIView!
    private var tagContainer:UIView!
    private var netContainer:UIView!
    private var rateContainer:UIView!
    
    private var tagArea:UIView!
    
    private func initContainer(){
    
        if topContainer == nil{
            topContainer = UIView()
            addSubview(topContainer)
            topContainer.backgroundColor = UIColor.whiteColor()
            topContainer.snp_makeConstraints(closure: { (make) -> Void in
                make.top.left.right.equalTo(self)
                make.height.equalTo(DetailsPageInfoCell.topHeight)
            })
        }
        if tagContainer == nil{
            tagContainer = UIView()
            tagContainer.backgroundColor = UIColor.whiteColor()
            addSubview(tagContainer)
            tagContainer.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(self.topContainer.snp_bottom)
                make.left.right.equalTo(self)
                make.height.equalTo(DetailsPageInfoCell.tagHeight)
            })
        }
        
        if tagArea == nil{
            tagArea = UIView(frame: CGRectMake(CGFloat(margin), 0, 300, 200))
            tagContainer.addSubview(tagArea)
            tagArea.snp_makeConstraints(closure: { (make) -> Void in
                make.top.bottom.equalTo(self.tagContainer)
                make.left.equalTo(self.tagContainer).offset(margin)
                make.right.equalTo(self.tagContainer).offset(-margin)
            })
        }
        
        if netContainer == nil{
            netContainer = UIView()
            addSubview(netContainer)
            netContainer.backgroundColor = UIColor.whiteColor()
            netContainer.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(self.tagContainer.snp_bottom)
                make.left.right.equalTo(self)
                make.height.equalTo(DetailsPageInfoCell.tagHeight)
            })
        }
        if rateContainer == nil{
            rateContainer = UIView()
            addSubview(rateContainer)
            rateContainer.backgroundColor = UIColor.whiteColor()
            rateContainer.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(self.netContainer.snp_bottom)
                make.left.right.equalTo(self)
                make.height.equalTo(DetailsPageInfoCell.tagHeight)
            })
        }
    }
    
    
    
}
