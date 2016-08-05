

//
//  DetailsNetValueRateView.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/11/20.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit
import CoreLibrary

class DetailsNetValueRateView: PageDataView,TrendChartDelegate{
    
    private var segmentControl:PPiFlatSegmentedControl!
    override func layoutSubviews() {
        self.backgroundColor = UIColor.whiteColor()
        initSegmentControl()
        initInfoView()
        initChartView()
        segmentControlSelected(0)
    }
    
    private var chartInfoView:UIView!
    private var selectInfoView:UIView!
    
    private var chartDateStartLabel:UILabel!
    private var chartDateEndLabel:UILabel!
    private var chartSelfValueText:UILabel!
    private var chartKindValueText:UILabel!//同类平均
    private var chartCSIValueText:UILabel!//沪深300
    
    private var selectDateLabel:UILabel!
    private var selectSelfValueText:UILabel!
    private var selectKindValueText:UILabel!//同类平均
    private var selectCSIValueText:UILabel!//沪深300
    
    //显示交互信息
    private func initInfoView(){
        let labelSize:CGFloat = 10
        let labelColor:UIColor = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        if chartInfoView == nil{
            chartInfoView = UIView()
            addSubview(chartInfoView)
            
            
//            chartInfoView.sd_layout()
//                .leftEqualToView(segmentControl)
//                .rightEqualToView(segmentControl)
//                .topSpaceToView(segmentControl,14)
//                .heightIs(28)
            
            chartInfoView.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(segmentControl.snp_bottom).offset(14)
                make.left.right.equalTo(segmentControl)
                make.height.equalTo(28)
            })
//            chartInfoView.backgroundColor = UIColor.brownColor()
            
            chartDateStartLabel = UICreaterUtils.createLabel(labelSize, UICreaterUtils.colorFlat, "", true, chartInfoView)
//            chartDateStartLabel.sd_layout()
//                .leftEqualToView(chartInfoView)
//                .topEqualToView(chartInfoView)
            
            chartDateStartLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.left.top.equalTo(chartInfoView)
            })
            let chartSelfValueLabel = UICreaterUtils.createLabel(labelSize, labelColor, "期间涨跌:", true, chartInfoView)
//            chartSelfValueLabel.sd_layout()
//                .leftEqualToView(chartInfoView)
//                .bottomEqualToView(chartInfoView)
            chartSelfValueLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.left.bottom.equalTo(chartInfoView)
            })
            
            chartSelfValueText = UICreaterUtils.createLabel(labelSize, labelColor, "", true, chartInfoView)
//            chartSelfValueText.sd_layout()
//                .leftEqualToView(chartSelfValueLabel)
//                .centerYEqualToView(chartSelfValueLabel)
            chartSelfValueText.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(chartSelfValueLabel.snp_right)
                make.centerY.equalTo(chartSelfValueLabel)
            })
            
            let chartKindValueLabel = UICreaterUtils.createLabel(labelSize, labelColor, "同类平均:",true,chartInfoView)
//            chartKindValueLabel.sd_layout()
//                .bottomEqualToView(chartInfoView)
//                .rightEqualToView(chartInfoView.snp_centerX)
            chartKindValueLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.bottom.equalTo(chartInfoView)
                make.right.equalTo(chartInfoView.snp_centerX)
            })
            
            chartKindValueText = UICreaterUtils.createLabel(labelSize, labelColor, "", true, chartInfoView)
            chartKindValueText.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(chartKindValueLabel.snp_right)
                make.centerY.equalTo(chartKindValueLabel)
            })
            
            chartCSIValueText = UICreaterUtils.createLabel(labelSize, labelColor, "", true, chartInfoView)
            chartCSIValueText.snp_makeConstraints(closure: { (make) -> Void in
                make.bottom.right.equalTo(chartInfoView)
            })
            let chartCSIValueLabel = UICreaterUtils.createLabel(labelSize, labelColor, "沪深300:", true, chartInfoView)
            chartCSIValueLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(chartCSIValueText.snp_left)
                make.centerY.equalTo(chartCSIValueText)
            })
            
            chartDateEndLabel = UICreaterUtils.createLabel(labelSize, UICreaterUtils.colorFlat, "", false, chartInfoView)
            chartDateEndLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(chartInfoView)
                make.left.equalTo(chartKindValueLabel)
            })
        }
        if selectInfoView == nil{
            selectInfoView = UIView()
            addSubview(selectInfoView)
            selectInfoView.hidden = true
//            selectInfoView.backgroundColor = UIColor.blueColor()
            selectInfoView.snp_makeConstraints(closure: { (make) -> Void in
                make.left.right.top.bottom.equalTo(chartInfoView)
            })
            
            selectDateLabel = UICreaterUtils.createLabel(labelSize, UICreaterUtils.colorFlat, "", true, selectInfoView)
            selectDateLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.left.top.equalTo(selectInfoView)
            })
            selectSelfValueText = UICreaterUtils.createLabel(labelSize, UICreaterUtils.colorFlat, "", true, selectInfoView)
            selectSelfValueText.snp_makeConstraints(closure: { (make) -> Void in
                make.right.top.equalTo(selectInfoView)
            })
            let selectSelfValueLabel = UICreaterUtils.createLabel(labelSize, UICreaterUtils.colorFlat, "单位净值:", true, selectInfoView)
            selectSelfValueLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(selectSelfValueText.snp_left)
                make.centerY.equalTo(selectSelfValueText)
            })
            
            let selectKindValueLabel = UICreaterUtils.createLabel(labelSize, UICreaterUtils.colorFlat, "同类平均:", true, selectInfoView)
            selectKindValueLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.left.bottom.equalTo(selectInfoView)
            })
            
            selectKindValueText = UICreaterUtils.createLabel(labelSize, UICreaterUtils.colorFlat, "", true, selectInfoView)
            selectKindValueText.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(selectKindValueLabel.snp_right)
                make.centerY.equalTo(selectKindValueLabel)
            })
            
            selectCSIValueText = UICreaterUtils.createLabel(labelSize, UICreaterUtils.colorFlat, "", true, selectInfoView)
            selectCSIValueText.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(selectInfoView)
                make.bottom.equalTo(selectInfoView)
            })
            
            let selectCSIValueLabel = UICreaterUtils.createLabel(labelSize, UICreaterUtils.colorFlat, "沪深300:", true, selectInfoView)
            selectCSIValueLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(selectCSIValueText.snp_left)
                make.centerY.equalTo(selectCSIValueText)
            })
        } 
    }
    
    private var chartView:UIGroupLineChart!
    private func initChartView(){
        if chartView == nil{
            chartView = UIGroupLineChart()
            addSubview(chartView)
            chartView.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(chartInfoView.snp_bottom).offset(4)
                make.left.right.equalTo(segmentControl)
                make.bottom.equalTo(self)
            })
        }
    }
    
    let dateCountArray = [30,91,182,365]
    let timeGapArray:[Double] = [24 * 3600 * 7,24 * 3600 * 30,24 * 3600 * 30,24 * 3600 * 30 * 3]
    
    private func initSegmentControl(){
        if segmentControl == nil{
            let data=[
                PPiFlatSegmentItem(title: "一月", andIcon: nil),
                PPiFlatSegmentItem(title: "一季", andIcon: nil),
                PPiFlatSegmentItem(title: "半年", andIcon: nil),
                PPiFlatSegmentItem(title: "一年", andIcon: nil)
            ];
            segmentControl = PPiFlatSegmentedControl(frame:  CGRectZero, items: data, iconPosition: IconPositionRight, iconSeparation:0 ,target:self, andSelection:"segmentControlSelected:")
            let tintColor:UIColor = UIColor(red: 232/255, green: 54/255, blue: 59/255, alpha: 1)
            let lineColor:UIColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
            segmentControl.color = UIColor.blueColor()
            segmentControl.borderWidth = 0.5
            segmentControl.borderColor = lineColor
            segmentControl.selectedColor = tintColor
            segmentControl.color = UIColor.clearColor()
            segmentControl.selectedTextAttributes=[NSFontAttributeName:UIFont.systemFontOfSize(13),
                NSForegroundColorAttributeName:UIColor.whiteColor()]
            segmentControl.textAttributes=[NSFontAttributeName:UIFont.systemFontOfSize(13),
                NSForegroundColorAttributeName:UIColor.blackColor()]
            addSubview(segmentControl)
            
            segmentControl.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(self).offset(18)
                make.right.equalTo(self).offset(-18)
                make.top.equalTo(self).offset(15)
                make.height.equalTo(28)
            }
        }
        
    }
    
    func segmentControlSelected(index:AnyObject){
//        println("选中索引值:\(index)")
        //        if(index.intValue==0){
        //            //switchToFoundation()
        //        }else{
        //            //switchToP2P()
        //        }
        let count = dateCountArray[Int(index as! NSNumber)]
        var chartDataSource:[[CGFloat]] = []
        for i in 0..<3{
            var tmp:[CGFloat] = []
            var prevValue:CGFloat = CGFloat(arc4random_uniform(10)) + 20//CGFloat(arc4random_uniform(200)) + 500
            for j in 0..<count{
                var newValue:CGFloat// = prevValue + CGFloat(arc4random_uniform(10)) - 4.5
                if j / 5 == 2{
                    newValue = prevValue
                }else{
                    newValue = prevValue + CGFloat(arc4random_uniform(10)) - 4.5
                }
                tmp.append(newValue)
                prevValue = newValue
            }
            chartDataSource.append(tmp)
        }
        let timeGap:Double = 24 * 3600
        let nowDate = NSDate()//NSDate(timeIntervalSinceNow: 3600 * 24 * 100)
        let nowTime = nowDate.timeIntervalSince1970
        var dateList:[NSDate] = []
        for j in 0..<count{
            let dateTime = nowTime - Double(count - j) * timeGap
            dateList.append(NSDate(timeIntervalSince1970: dateTime))
        }
        chartView.chartDataSource = chartDataSource//[[15,18,19,25,10,9,5,6,11,17,20,25,30],[15,18,19,25,10,9,5,6,11,17,20,25,30],[15,18,19,25,10,9,5,6,11,17,20,25,30]]
        chartView.dateList = dateList//[NSDate(),NSDate(),NSDate(),NSDate(),NSDate(),NSDate(),NSDate(),NSDate(),NSDate(),NSDate(),NSDate(),NSDate()]
        chartView.lineColorList = [UIColor(red: 252/255, green: 58/255, blue: 86/255, alpha: 1),UIColor(red: 250/255, green: 176/255, blue: 87/255, alpha: 1),UIColor(red: 129/255, green: 167/255, blue: 218/255, alpha: 1)]
        chartView.lineWidthList = [1.6,0.8,0.8]
        let pageData:InfoFundVo = data as! InfoFundVo
        chartView.titleList = [pageData.shortTitle,"沪深300","同类平均"]
        chartView.timeGap = timeGapArray[Int(index as! NSNumber)]
        chartView.delegate = self
        
        showChartInfo()
        
//        showSelectInfo(10)
    }
    
    func touchChartLineBegin(index: Int) {
        showSelectInfo(index)
    }
    
    func touchChartLineEnd() {
        showChartInfo()
    }
    
    private func showChartInfo(){
        chartInfoView.hidden = false
        selectInfoView.hidden = true
        
        let startDate = chartView.dateList[0]
        let endDate = chartView.dateList[chartView.dateList.count - 1]
        
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        
        chartDateStartLabel.text = fmt.stringFromDate(startDate) + "起"
        chartDateStartLabel.sizeToFit()
        
        chartDateEndLabel.text = fmt.stringFromDate(endDate) + "止"
        chartDateEndLabel.sizeToFit()
        
        
        let chartDataSource = chartView.chartDataSource
        let labelList = [chartSelfValueText,chartCSIValueText,chartKindValueText]
        
        for i in 0..<chartDataSource.count{
            let dataSoucre = chartDataSource[i]
            let label = labelList[i]
            
            let firstValue = dataSoucre[0]
            let endValue = dataSoucre[dataSoucre.count - 1]
            let rateValue = (endValue / firstValue - 1) * 100
            var labelColor:UIColor
            if rateValue > 0 {
                labelColor = UICreaterUtils.colorRise
            }else if rateValue < 0{
                labelColor = UICreaterUtils.colorDrop
            }else{
                labelColor = UICreaterUtils.colorFlat
            }
            let rateLabel = String(format: "%.2f", rateValue) //保留两位小数
            label.text = rateLabel + "%"
            label.textColor = labelColor
            label.sizeToFit()
        }
    }
    
    private func showSelectInfo(index:Int){
        chartInfoView.hidden = true
        selectInfoView.hidden = false
        
        let selectDate = chartView.dateList[index]
        
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        
        selectDateLabel.text = fmt.stringFromDate(selectDate)
        selectDateLabel.sizeToFit()
        
        let chartDataSource = chartView.chartDataSource
        let labelList = [selectSelfValueText,selectCSIValueText,selectKindValueText]
        
        for i in 0..<chartDataSource.count{
            let dataSoucre = chartDataSource[i]
            let label = labelList[i]
            var prevValue:CGFloat
            if index - 1 < 0 {
                prevValue = dataSoucre[0]
            }else{
                prevValue = dataSoucre[index - 1]
            }
            let selectValue = dataSoucre[index]
            let rateValue = (selectValue / prevValue - 1) * 100
            var labelColor:UIColor
            if rateValue > 0 {
                labelColor = UICreaterUtils.colorRise
            }else if rateValue < 0{
                labelColor = UICreaterUtils.colorDrop
            }else{
                labelColor = UICreaterUtils.colorFlat
            }
            let rateLabel = String(format: "%.2f", rateValue) //保留两位小数
            label.text = "\(selectValue)(" + rateLabel + "%" + ")"
            label.textColor = labelColor
            label.sizeToFit()
        }
        
    }
    

}
