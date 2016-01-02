
//
//  DetailsNoticeView.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/12/12.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class DetailsNoticeView: PageDataView, UITableViewDelegate, UITableViewDataSource {

    override func layoutSubviews() {
        initTableView()
        loadData()
        super.layoutSubviews()
    }
    
    private var noticeList:[InfoNoticeVo] = []
    private func loadData(){
        if refresh {
            noticeList = DataRemoteFacade.getNoticeList()
            
            if refreshHeightHandler != nil{
                //重新计算整个view高度
                var detailsHeight = CGFloat(noticeList.count) * DetailsNoticeView.cellHeight
                if detailsHeight < DetailsNoticeView.defaultHeight{
                    detailsHeight = DetailsNoticeView.defaultHeight
                }
                refreshHeightHandler?(view: self,height: detailsHeight) //重新计算整体高度
            }
            tableView.reloadData() //重新刷新
        }
    }
    
    static let cellHeight:CGFloat = 86
    static let defaultHeight:CGFloat = 500
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
    
    //个数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return noticeList.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return DetailsNoticeView.cellHeight//cellHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cellIdentifer = "NoticeCell"
        //cell标示符 表示一系列
        var cell:NoticeCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifer) as? NoticeCell
        if cell == nil{
            cell = NoticeCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifer)//
            cell!.selectionStyle = UITableViewCellSelectionStyle.Blue
        }
        cell!.noticeVo = noticeList[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let noticeVo = noticeList[indexPath.row]
//        println("选中\(indexPath.row)条公告")
        let webController = DetailsWebPageController()
        webController.linkUrl = noticeVo.link//"https://m.baidu.com/from=844b/s?word=" + noticeVo.title
        
//        self.navigationController?.pushViewController(webController, animated: true)
        
        let nc = NSNotification(name: "Details:pushView", object: webController)
        NSNotificationCenter.defaultCenter().postNotification(nc)
        
//        self.tableView.reloadData() //重新刷新
        self.tableView.deselectRowAtIndexPath(indexPath, animated: false) //反选
    }
    
}
private class NoticeCell:UITableViewCell {

    var noticeVo:InfoNoticeVo!{
        didSet{
            setNeedsLayout()
        }
    }
    
    private lazy var titleLabel:UILabel = {
        let label = UICreaterUtils.createLabel(16, UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1), "", true, self.contentView)
        label.numberOfLines = 2
        return label
    }()
    
    private let leftpadding = 20
    private let toppadding = 14
    private lazy var dateLabel:UILabel = {
        let label = UICreaterUtils.createLabel(13, UICreaterUtils.colorFlat, "", true, self.contentView)
        return label
    }()
    
    private lazy var bottomLine:UIView = {
        let view:UIView = UIView()
        view.backgroundColor = UICreaterUtils.normalLineColor
        self.contentView.addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        initTextView()
    }
    
    private func initTextView(){
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.contentView).offset(toppadding)
            make.left.equalTo(self.contentView).offset(leftpadding)
            make.right.equalTo(self.contentView).offset(-leftpadding)
        }
        titleLabel.text = noticeVo.title
        titleLabel.sizeToFit()
        
        dateLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView).offset(leftpadding)
            make.bottom.equalTo(self.contentView).offset(-toppadding)
        }
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        
        dateLabel.text = fmt.stringFromDate(noticeVo.date)
        dateLabel.sizeToFit()
        
        bottomLine.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(UICreaterUtils.normalLineWidth)
        }
    }
    
    
    
}






