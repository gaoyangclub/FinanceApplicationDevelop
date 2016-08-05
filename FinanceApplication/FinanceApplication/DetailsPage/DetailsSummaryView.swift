//
//  DetailsSummaryView.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/12/6.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit
import CoreLibrary

class DetailsSummaryView: PageDataView, UITableViewDelegate, UITableViewDataSource {
    
    override func layoutSubviews() {
        initTableView()
        loadData()
        super.layoutSubviews()
    }
    
    private func loadData(){
        if refresh {
            let ivo = data as! InfoFundVo
            
            let svo = DataRemoteFacade.getSummarysById(ivo.id)
            
            if svo != nil{
                summarySource.removeAll()//数据清空
                summarySource.append(SummaryVo(name: "基金经理", content: svo?.manager, hasDetail: true))
                summarySource.append(SummaryVo(name: "基金公司", content: svo?.company, hasDetail: true))
                summarySource.append(SummaryVo(name: "投资类型", content: svo?.kind, hasDetail: true))
                summarySource.append(SummaryVo(name: "资产规模", content: svo!.money + "(" + svo!.time + ")", hasDetail: false))
                //            ivo.id
                //通过id获取remote数据
                //根据内容高度重新测量 并提交给上级刷新 忽略...
                
                tableView.reloadData() //重新刷新
            }
            
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
    
    private var summarySource:[SummaryVo] = []
    
    private let cellHeight:CGFloat = 52
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return summarySource.count//tableView.numberOfRowsInSection(section)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cellIdentifer = "SummaryCell"
        //cell标示符 表示一系列
        var cell:SummaryCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifer) as? SummaryCell
        if cell == nil{
            cell = SummaryCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifer)//
            //无色
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
        }
        cell!.svo = summarySource[indexPath.row]
        return cell!
    }

}
private class SummaryCell:UITableViewCell{
    
    private static let labelColor:UIColor = UIColor(red: 66/255, green: 66/255, blue: 66/255, alpha: 1)
    private static let labelSize:CGFloat = 15
    
    
    var svo:SummaryVo!{
        didSet{
            setNeedsLayout()
        }
    }
    
    lazy var nameLabel:UILabel = {
        let label = UICreaterUtils.createLabel(SummaryCell.labelSize, SummaryCell.labelColor, "", true, self.contentView)
        label.textAlignment = NSTextAlignment.Center
        return label
    }()
    
    lazy var contentLabel:UILabel = {
        let label = UICreaterUtils.createLabel(SummaryCell.labelSize, SummaryCell.labelColor, "", true, self.contentView)
//        label.textAlignment = NSTextAlignment.Center;
        label.font = UIFont.systemFontOfSize(SummaryCell.labelSize)//, weight: 1.5
        return label
    }()
    
    lazy var arrowView:UIArrowView = {
        let arrow = UIArrowView()
        arrow.direction = ArrowDirect.RIGHT
        arrow.lineColor = UICreaterUtils.normalLineColor
        self.contentView.addSubview(arrow)
        return arrow
    }()
    
    lazy var bottomLine:UIView = {
        let line = UIView()
        self.contentView.addSubview(line)
        line.backgroundColor = UICreaterUtils.normalLineColor
        return line
    }()
    
    override func layoutSubviews() {
        initView()
    }
    
    private func initView(){
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(92)
            make.left.centerY.equalTo(self.contentView)
        }
        
        nameLabel.text = svo.name
        
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(nameLabel.snp_right)
            make.centerY.equalTo(self.contentView)
            make.right.equalTo(-46)
        }
        
        contentLabel.text = svo.content
        
        if svo.hasDetail {
            arrowView.snp_makeConstraints(closure: { (make) -> Void in
                make.width.equalTo(7)
                make.height.equalTo(13)
                //                make.size.equalTo(CGSize(width: 7, height: 13))
                make.right.equalTo(-20)
                make.centerY.equalTo(self.contentView)
            })
        }
        
        bottomLine.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(UICreaterUtils.normalLineWidth)
            make.left.right.bottom.equalTo(self.contentView)
        }
        
    }
    
}
private struct SummaryVo {
    var name:String!
    var content:String!
    var hasDetail:Bool = false
}



