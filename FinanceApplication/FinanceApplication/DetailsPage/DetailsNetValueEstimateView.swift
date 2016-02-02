//
//  DetailsNetValueEstimateView.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/12/5.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class DetailsNetValueEstimateView: PageDataView,TrendChartDelegate {

    override func layoutSubviews() {
        self.backgroundColor = UIColor.whiteColor()
        initInfoView()
        initChartView()
        loadChartDataSource()
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
                make.top.equalTo(self)
                make.left.equalTo(self).offset(18)
                make.right.equalTo(self).offset(-18)
                make.height.equalTo(48)
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
            
            let selectRateValueLabel = UICreaterUtils.createLabel(labelSize, labelColor, "涨幅:", true, chartInfoView)
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
                make.top.equalTo(chartInfoView.snp_bottom)
                make.left.right.equalTo(chartInfoView)
                make.bottom.equalTo(self).offset(-20)
            })
        }
    }
    
    func loadChartDataSource(){
        let count = 4 * 60 + 1
        var chartDataList:[CGFloat] = []
        let firstValue = CGFloat(arc4random_uniform(10)) + 100
        var prevValue:CGFloat = firstValue
        for _ in 0..<count{
            let random = CGFloat(arc4random_uniform(3)) - 1
            //            println("随机幅度:\(random)")
            let newValue:CGFloat = prevValue + random
            chartDataList.append(newValue)
            prevValue = newValue
        }

        let nowTem = Tempo()
//        let nowDate = nowTem.date
//        println(nowDate)
        
        let earlyTempo = Tempo { (newTemp) -> () in
            newTemp.years = nowTem.years
            newTemp.months = nowTem.months
            newTemp.days = nowTem.days
            newTemp.hours = 9
            newTemp.minutes = 30
            newTemp.seconds = 0
        }
        
        let timeGap:Double = 60
        let earlyTime = earlyTempo.date.timeIntervalSince1970
        var dateList:[NSDate] = []
        var tem:Tempo?
        var dateTime = earlyTime
        for j in 0..<count{
            let date = NSDate(timeIntervalSince1970: dateTime)
            dateList.append(date)
            
            let tem = Tempo(date: date)
            if tem.hours == 11 && tem.minutes == 30{
                dateTime += 90 * 60
            }
            dateTime += timeGap
        }
        
        chartView.chartType = .Line
        chartView.compareType = .Regular
        chartView.dateType = .Hour
        chartView.lineColor = UIColor(red: 246/255, green: 54/255, blue: 71/255, alpha: 1)
        chartView.compareRegularValue = firstValue //第一个自定义比较值
        chartView.chartDataList = chartDataList
        //        println("\(firstValue) \(chartDataList)")
        
        chartView.dateList = dateList
        //        chartView.lineColor = UICreaterUtils.colorRise
        chartView.timeGap = 3600
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
        fmt.dateFormat = "MM-dd HH:mm"
        
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
