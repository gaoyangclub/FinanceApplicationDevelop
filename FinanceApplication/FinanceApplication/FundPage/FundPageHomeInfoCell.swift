//
//  FundPageHomeInfoCell.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/12/17.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit
import CoreLibrary

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
        
        let tag = UICreaterUtils.createLabel(14, UIColor.grayColor(), "季度收益", true, self.contentView)
//        tag.sd_layout()
//            .rightSpaceToView(label,6)
//            .centerYEqualToView(label)
        
        tag.snp_makeConstraints{ (make) -> Void in
            make.right.equalTo(label.snp_left).offset(-6)
            make.centerY.equalTo(label)
        }
        return label
        }()
    
    private lazy var iconView:UILabel = {
        let tabItem = UICreaterUtils.createLabel(UIConfig.ICON_FONT_NAME, 26, UICreaterUtils.colorRise);
        tabItem.textAlignment = NSTextAlignment.Center;
        self.contentView.addSubview(tabItem)
//        tabItem.userInteractionEnabled = false
//        tabItem.sizeType = .FillWidth
//        tabItem.normalColor = UICreaterUtils.colorRise
        return tabItem
    }()
    
    private func initCell(){
        let fvo:InfoFundHeader = data as! InfoFundHeader
        
//        self.bottomLine.sd_layout()
//            .leftEqualToView(self.contentView)
//            .rightEqualToView(self.contentView)
//            .bottomEqualToView(self.contentView)
//            .heightIs(UICreaterUtils.normalLineWidth)
        
        self.bottomLine.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(UICreaterUtils.normalLineWidth)
        }
        
//        self.iconView.sd_layout()
//            .leftSpaceToView(self.contentView,2)
//            .widthIs(40)
//            .heightIs(24)
//            .centerYEqualToView(self.titleLabel)
        
        self.iconView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView).offset(2)
//            make.size.equalTo(CGSize(width: 40, height: 24))
            make.width.equalTo(40)
            make.height.equalTo(26)
            make.centerY.equalTo(titleLabel)
        }
        iconView.text = fvo.iconUrl;
//        BatchLoaderForSwift.loadFile(fvo.iconUrl, callBack: { (image) -> Void in
//            self.iconView.image = image
//        })
        
//        self.titleLabel.sd_layout()
//            .leftEqualToView(self.iconView)
//            .bottomSpaceToView(snp_centerY)
//            .heightIs(24)
        
        self.titleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.iconView.snp_right)
            make.bottom.equalTo(self.contentView.snp_centerY).offset(-2)
        }
        self.titleLabel.text = fvo.title
        self.titleLabel.sizeToFit()
        
//        self.fundLabel.sd_layout()
//            .leftEqualToView(self.titleLabel)
//            .topSpaceToView(snp_centerY)
        
        self.fundLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.titleLabel)
            make.top.equalTo(self.contentView.snp_centerY).offset(4)
        }
        self.fundLabel.text = fvo.deputyFundVo?.title
        self.fundLabel.sizeToFit()
        
        if fvo.deputyFundVo != nil{
//            self.rateLabel.sd_layout()
//                .centerYEqualToView(self.fundLabel)
//                .rightEqualToView(self.contentView)
//                .widthIs(66)
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
