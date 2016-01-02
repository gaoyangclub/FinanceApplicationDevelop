//
//  DetailsStockView.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/12/9.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class DetailsStockView: PageDataView, UITableViewDelegate, UITableViewDataSource  {

    static let padding:CGFloat = 18
    
    override func layoutSubviews() {
        initTableView()
        loadData()
        super.layoutSubviews()
    }
    
    private var stockSourceList:[[InfoStockVo]] = []
    private var maxPositionRatio:Float!
    private func loadData(){
        if refresh {
            stockSourceList = DataRemoteFacade.getStockSource()
            
            //获取positionRatio百分比最大值
            
            maxPositionRatio = 0.1
            for stockList in stockSourceList{
                for stockVo in stockList{
                    if stockVo.positionRatio > maxPositionRatio{
                        maxPositionRatio = stockVo.positionRatio
                    }
                }
            }
            if refreshHeightHandler != nil{
                var headerHight = CGFloat(stockSourceList.count) * (headerHeight + headerGap) - headerGap
                //重新计算整个view高度
                var cellHeight:CGFloat = 0
                for stockList in stockSourceList{
                    cellHeight += CGFloat(stockList.count) * StockCell.getCellHeight()
                }
                let totalHeight = headerHight + cellHeight //整个tabel占用高度
                refreshHeightHandler!(view: self,height: totalHeight) //重新计算整体高度
            }
            tableView.reloadData() //重新刷新
        }
    }
    
    lazy private var tableView:UITableView = {
        let tv = UITableView()
        self.addSubview(tv)
        tv.dataSource = self
        tv.delegate = self
        tv.separatorStyle = UITableViewCellSeparatorStyle.None //去掉Cell自带线条
        tv.scrollEnabled = false //不能滚动 但是可以点击
        //        tv.userInteractionEnabled = false
        return tv
        }()
    
    private func initTableView(){
        tableView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.bottom.equalTo(self)
        }
    }
    
    //种类个数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return stockSourceList.count
    }
    
    //标题栏视图
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        let totalRatio = getTotalRatio(section)
        var title = ""
        var offset:CGFloat = 0
        if section == 0{
            title = "股票持仓"
        }else{
            title = "债券持仓"
            offset = headerGap / 2
            var topView:UIView = UIView()
            topView.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
            header.addSubview(topView)
            topView.snp_makeConstraints(closure: { (make) -> Void in
                make.top.left.right.equalTo(header)
                make.height.equalTo(headerGap)
            })
            
            var topLine = UIView()
            topLine.backgroundColor = UICreaterUtils.normalLineColor
            topView.addSubview(topLine)
            topLine.snp_makeConstraints(closure: { (make) -> Void in
                make.left.right.top.equalTo(topView)
                make.height.equalTo(UICreaterUtils.normalLineWidth)
            })
            
            var bottomLine = UIView()
            bottomLine.backgroundColor = UICreaterUtils.normalLineColor
            topView.addSubview(bottomLine)
            bottomLine.snp_makeConstraints(closure: { (make) -> Void in
                make.left.right.bottom.equalTo(topView)
                make.height.equalTo(UICreaterUtils.normalLineWidth)
            })
        }
//        header.backgroundColor = UIColor.clearColor()
        var titleLabel:UILabel = UICreaterUtils.createLabel(16, UIColor.blackColor(), title + "    " + String(format: "%.2f", totalRatio * 100) + "%", true, header)
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(header).offset(offset)
            make.left.equalTo(DetailsStockView.padding)
        }
        return header
    }
    
    private func getTotalRatio(section:Int)->Float{
        var ratio:Float = 0
        let stockList = stockSourceList[section]
        for svo in stockList{
            ratio += svo.positionRatio
        }
        return ratio
    }
    
    private let headerHeight:CGFloat = 46
    private let headerGap:CGFloat = 6
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return headerHeight
        }else{
            return headerHeight + headerGap
        }
    }
    
//    private let cellHeight:CGFloat = 56
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return StockCell.getCellHeight()//cellHeight
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return stockSourceList[section].count//tableView.numberOfRowsInSection(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cellIdentifer = "StockCell"
        //cell标示符 表示一系列
        var cell:StockCell?
//        = tableView.dequeueReusableCellWithIdentifier(cellIdentifer) as? StockCell
//        if cell == nil{
            cell = StockCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifer)//
            //无色
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
//        }
        cell!.stockVo = stockSourceList[indexPath.section][indexPath.row]
        cell!.maxPositionRatio = maxPositionRatio
        return cell!
    }
    
}
private class StockCell:UITableViewCell {
    
    var stockVo:InfoStockVo!{
        didSet{
            setNeedsLayout()
        }
    }
    
    var maxPositionRatio:Float = 0.1{
        didSet{
            setNeedsLayout()
        }
    }
    
    private var rateView:UIView!
    
    override func layoutSubviews() {
        initRateView()
        initTextView()
    }
    
    private static let gapHeight:CGFloat = 18;
    static func getCellHeight()->CGFloat{
        return gapHeight * 3
    }
    
    private lazy var titleLabel:UILabel = UICreaterUtils.createLabel(14, UICreaterUtils.colorFlat, "", true, self.contentView)
    
    private lazy var rateDayLabel:UILabel = UICreaterUtils.createLabel(16, UICreaterUtils.colorFlat, "", true, self.contentView)
  
    private lazy var ratioLabel:UILabel = UICreaterUtils.createLabel(14, UIColor.blackColor(), "", true, self.contentView)
    
    private func initTextView(){
        titleLabel.text = stockVo.title + "    " + stockVo.code
        titleLabel.sizeToFit()
        
        titleLabel.snp_makeConstraints{ (make) -> Void in
            make.left.equalTo(self.contentView).offset(DetailsStockView.padding)
            make.bottom.equalTo(inView.snp_top).offset(-rateViewMargin)
        }
        
        var rateDayColor:UIColor
        if stockVo.rateDay > 0 {
            rateDayColor = UICreaterUtils.colorRise
        }else if stockVo.rateDay < 0{
            rateDayColor = UICreaterUtils.colorDrop
        }else{
            rateDayColor = UICreaterUtils.colorFlat
        }
        
        if stockVo.kind == 0{//股票才有
            rateDayLabel.textColor = rateDayColor
            rateDayLabel.text = String(format: "%.2f", stockVo.rateDay * 100) + "%"
            rateDayLabel.sizeToFit()
            rateDayLabel.snp_makeConstraints{ (make) -> Void in
                make.right.equalTo(self.contentView).offset(-DetailsStockView.padding)
                make.bottom.equalTo(titleLabel.snp_bottom)
            }
        }
        
        ratioLabel.text = String(format: "%.2f", stockVo.positionRatio * 100) + "%"
        ratioLabel.sizeToFit()
        
        
        
        let rateViewWidth = (self.frame.width - DetailsStockView.padding * 2 - rateViewMargin * 2) * CGFloat(stockVo.positionRatio / maxPositionRatio)
        let rateViewRight:CGFloat = DetailsStockView.padding + rateViewMargin + rateViewWidth
        if rateViewRight + ratioLabel.frame.width + 10 > self.frame.width - DetailsStockView.padding - rateViewMargin{ //超出
            ratioLabel.snp_makeConstraints { (make) -> Void in
                make.right.equalTo(rateView.snp_right).offset(-20)
                make.centerY.equalTo(rateView)
            }
        }else{
            ratioLabel.snp_makeConstraints { (make) -> Void in
                make.left.equalTo(rateView.snp_right).offset(10)
                make.centerY.equalTo(rateView)
            }
        }
    }
    
    private let rateViewMargin:CGFloat = 2
    private var inView:UIView!
    private func initRateView(){
        if rateView == nil{
            
            let outView = UIView()
            contentView.addSubview(outView)
            outView.layer.cornerRadius = StockCell.gapHeight / 2
            outView.layer.borderColor = UICreaterUtils.normalLineColor.CGColor
            outView.layer.borderWidth = 1//UICreaterUtils.normalLineWidth
            
            outView.snp_makeConstraints { (make) -> Void in
                make.top.equalTo(StockCell.gapHeight)
                make.left.equalTo(self.contentView).offset(DetailsStockView.padding)
                make.right.equalTo(self.contentView).offset(-DetailsStockView.padding)
                make.height.equalTo(StockCell.gapHeight)
            }
            
            inView = UIView()//中间过渡用来测量的容器
            outView.addSubview(inView)
            inView.snp_makeConstraints { (make) -> Void in
                make.edges.equalTo(outView).inset(UIEdgeInsets(top: rateViewMargin, left: rateViewMargin, bottom: rateViewMargin, right: rateViewMargin))
            }
            
            rateView = UIView()
            inView.addSubview(rateView)
            rateView.layer.cornerRadius = (StockCell.gapHeight - rateViewMargin*2) / 2
            rateView.backgroundColor = UIColor(red: 243/255, green: 200/255, blue: 56/255, alpha: 1)
        }
        
//        if isAni {
//            return
//        }
//        isAni = true
        
        let maxWidth = (self.frame.width - DetailsStockView.padding * 2 - rateViewMargin * 2) * CGFloat(self.stockVo.positionRatio / self.maxPositionRatio)
        self.rateView.frame = CGRectMake(0,0, 0, StockCell.gapHeight - 2 * rateViewMargin)
        
        let delayInSeconds:Double = 4
        var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds));
        dispatch_after(popTime, dispatch_get_main_queue(), {
        
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(1)
//            UIView.setAnimationDelay(3)
            self.rateView.frame.size.width = maxWidth//CGRectMake(0,0, maxWidth, StockCell.gapHeight - 2 * self.rateViewMargin)
//            self.rateView.alpha = 0
            UIView.setAnimationCurve(UIViewAnimationCurve.EaseOut) //设置动画相对速度
            UIView.setAnimationDelegate(self)
            UIView.setAnimationDidStopSelector("aniComplete")
            UIView.commitAnimations()
//            UIView.animateWithDuration(5.1, animations: {
//                self.rateView.alpha = 0//rCGRectMake(0,0, maxWidth, StockCell.gapHeight - 2 * self.rateViewMargin)
//                },completion:{ _ in
//                    //                self.rateView.snp_makeConstraints { (make) -> Void in
//                    //                    make.left.bottom.top.equalTo(self.inView)
//                    //                    make.width.equalTo(self.inView).multipliedBy(self.stockVo.positionRatio / self.maxPositionRatio)
//                    //                }
//            })
        })
        
        
        
    }
    
    func aniComplete(){
        self.rateView.snp_makeConstraints { (make) -> Void in
            make.left.bottom.top.equalTo(self.inView)
            make.width.equalTo(self.inView).multipliedBy(self.stockVo.positionRatio / self.maxPositionRatio)
        }
    }
    
//    private var isAni:Bool = false
    
    
}

