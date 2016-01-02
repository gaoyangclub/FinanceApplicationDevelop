//
//  DetailsDayValueRateView.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/12/5.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class DetailsDayValueRateView: PageDataView,TrendChartDelegate{

    private var segmentControl:PPiFlatSegmentedControl!
    override func layoutSubviews() {
        self.backgroundColor = UIColor.whiteColor()
        initSegmentControl()
        initInfoView()
        initChartView()
        segmentControlSelected(0)
    }
    
    private var chartInfoView:UIView!
    private var selectDateLabel:UILabel!
    private var selectNetValueText:UILabel!//净值估算
    private var selectRateValueText:UILabel!//涨幅
    
    //显示交互信息
    private func initInfoView(){
        if chartInfoView == nil{
            let labelSize:CGFloat = 12
            let labelColor:UIColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1)
            
            chartInfoView = UIView()
            addSubview(chartInfoView)
            chartInfoView.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(segmentControl.snp_bottom).offset(14)
                make.left.right.equalTo(segmentControl)
                make.height.equalTo(20)
            })
            
            selectDateLabel = UICreaterUtils.createLabel(labelSize, labelColor, "", true, chartInfoView)
            selectDateLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.left.centerY.equalTo(chartInfoView)
            })
            
            selectNetValueText = UICreaterUtils.createLabel(labelSize, labelColor, "", true, chartInfoView)
            selectNetValueText.snp_makeConstraints(closure: { (make) -> Void in
                make.center.equalTo(chartInfoView)
            })
            
            selectRateValueText = UICreaterUtils.createLabel(labelSize, labelColor, "", true, chartInfoView)
            selectRateValueText.snp_makeConstraints(closure: { (make) -> Void in
                make.right.centerY.equalTo(chartInfoView)
            })
            
            let selectRateValueLabel = UICreaterUtils.createLabel(labelSize, labelColor, "当日涨幅:", true, chartInfoView)
            selectRateValueLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(selectRateValueText.snp_left)
                make.centerY.equalTo(chartInfoView)
            })
        }
    }
    
    private var chartView:UIColumnChart!
    private func initChartView(){
        if chartView == nil{
            chartView = UIColumnChart()
            chartView.chartType = .Column
//            chartView.compareRegularValue = 
            addSubview(chartView)
            chartView.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(chartInfoView.snp_bottom).offset(4)
                make.left.right.equalTo(segmentControl)
                make.bottom.equalTo(self).offset(-10)
            })
        }
    }
    
    let dateCountArray = [30,91,182,365]
    let timeGapArray:[Double] = [24 * 3600 * 7,24 * 3600 * 30,24 * 3600 * 30,24 * 3600 * 30 * 3]
    private func initSegmentControl(){
        if segmentControl == nil{
            var data=[
                PPiFlatSegmentItem(title: "一月", andIcon: nil),
                PPiFlatSegmentItem(title: "一季", andIcon: nil),
                PPiFlatSegmentItem(title: "半年", andIcon: nil),
                PPiFlatSegmentItem(title: "一年", andIcon: nil)
            ];
            segmentControl = PPiFlatSegmentedControl(frame:  CGRectZero, items: data, iconPosition: IconPositionRight, iconSeparation:0 ,target:self, andSelection:"segmentControlSelected:")
            var tintColor:UIColor = UIColor(red: 232/255, green: 54/255, blue: 59/255, alpha: 1)
            var lineColor:UIColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
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
        var count = dateCountArray[Int(index as! NSNumber)]
        var chartDataList:[CGFloat] = []
        let firstValue = CGFloat(arc4random_uniform(10)) + 100
        var prevValue:CGFloat = firstValue
        for j in 0..<count{
            let random = CGFloat(arc4random_uniform(10)) - 4.5
//            println("随机幅度:\(random)")
            var newValue:CGFloat = prevValue + random
            chartDataList.append(newValue)
            prevValue = newValue
        }
        let timeGap:Double = 24 * 3600
        let nowDate = NSDate()//NSDate(timeIntervalSinceNow: 3600 * 24 * 100)
        let nowTime = nowDate.timeIntervalSince1970
        var dateList:[NSDate] = []
        for j in 0..<count{
            let dateTime = nowTime - Double(count - j) * timeGap
            dateList.append(NSDate(timeIntervalSince1970: dateTime))
        }
        chartView.compareRegularValue = firstValue //第一个自定义比较值
        chartView.chartDataList = chartDataList
//        println("\(firstValue) \(chartDataList)")
        
        chartView.dateList = dateList
//        chartView.lineColor = UICreaterUtils.colorRise
        var pageData:InfoFundVo = data as! InfoFundVo
        chartView.timeGap = timeGapArray[Int(index as! NSNumber)]
        chartView.delegate = self
        
        touchChartLineEnd()
    }
    func touchChartLineBegin(index: Int) {
        showSelectInfo(index)//显示选中数据
    }
    
    func touchChartLineEnd() {
        showSelectInfo(chartView.chartDataList.count - 1)//显示最后一条数据
    }
    
    private func showSelectInfo(index:Int){
        let selectDate = chartView.dateList[index]
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        
        selectDateLabel.text = fmt.stringFromDate(selectDate)
        selectDateLabel.sizeToFit()
        
        let netValue = chartView.chartDataList[index]
        selectNetValueText.text = "净值:\(netValue)"
        let compareValue = chartView.getCompareValue(index)
        
        let rateValue = (netValue / compareValue - 1) * 100
        var labelColor:UIColor
        if rateValue > 0 {
            labelColor = UICreaterUtils.colorRise
        }else if rateValue < 0{
            labelColor = UICreaterUtils.colorDrop
        }else{
            labelColor = UICreaterUtils.colorFlat
        }
        selectRateValueText.text = String(format: "%.2f", rateValue) + "%" //保留两位小数
        selectRateValueText.textColor = labelColor
        selectRateValueText.sizeToFit()
    }
}
