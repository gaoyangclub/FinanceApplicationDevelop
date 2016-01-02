//
//  FundPageHomeInfoCell.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/12/17.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class FundPageHomeInfoCell: BaseTableViewCell {

    static let cellHeight:CGFloat = 80
    
    override func layoutSubviews(){
        self.contentView.backgroundColor = UIColor.whiteColor()
        initCell()
    }
    
    private lazy var bottomLine:UIView = {
        let view:UIView = UIView()
        view.backgroundColor = UICreaterUtils.normalLineColor
        self.contentView.addSubview(view)
        return view
        }()
    
    
    private lazy var titleLabel:UILabel = {
        let label = UICreaterUtils.createLabel(18, UICreaterUtils.colorBlack, "", true, self.contentView)
        return label
        }()
    
    private lazy var fundLabel:UILabel = {
        let label = UICreaterUtils.createLabel(12, UIColor.grayColor(), "", true, self.contentView)
        return label
    }()
    
    private lazy var rateLabel:UILabel = {
        let label = UICreaterUtils.createLabel(15, UIColor.grayColor(), "", true, self.contentView)
//        label.font = UIFont.systemFontOfSize(14, weight: 1.05)
        
        var tag = UICreaterUtils.createLabel(14, UIColor.grayColor(), "季度收益", true, self.contentView)
        tag.snp_makeConstraints{ (make) -> Void in
            make.right.equalTo(label.snp_left).offset(-6)
            make.centerY.equalTo(label)
        }
        return label
        }()
    
    private lazy var iconView:UIFlatImageTabItem = {
        let tabItem = UIFlatImageTabItem()
        self.contentView.addSubview(tabItem)
        tabItem.userInteractionEnabled = false
        tabItem.sizeType = .FillWidth
        tabItem.normalColor = UICreaterUtils.colorRise
        return tabItem
    }()
    
    private func initCell(){
        let fvo:InfoFundHeader = data as! InfoFundHeader
        
        self.bottomLine.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(UICreaterUtils.normalLineWidth)
        }
        
        self.iconView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView).offset(2)
            make.size.equalTo(CGSize(width: 40, height: 24))
            make.centerY.equalTo(titleLabel)
        }
        BatchLoaderUtil.loadFile(fvo.iconUrl, callBack: { (image, params) -> Void in
            self.iconView.image = image
        })
        
        self.titleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.iconView.snp_right)
            make.bottom.equalTo(self.contentView.snp_centerY).offset(-2)
        }
        self.titleLabel.text = fvo.title
        self.titleLabel.sizeToFit()
        
        self.fundLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.titleLabel)
            make.top.equalTo(self.contentView.snp_centerY).offset(4)
        }
        self.fundLabel.text = fvo.deputyFundVo?.title
        self.fundLabel.sizeToFit()
        
        if fvo.deputyFundVo != nil{
            self.rateLabel.snp_makeConstraints { (make) -> Void in
                make.centerY.equalTo(self.fundLabel)
                make.right.equalTo(self.contentView)
                make.width.equalTo(66)
            }
            self.rateLabel.text = String(format: "%.2f", fvo.deputyFundVo!.rateQuarter * 100) + "%"
            self.rateLabel.sizeToFit()
        }
    }
    
}
