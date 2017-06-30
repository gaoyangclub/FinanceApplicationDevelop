//
//  HomePageFooterCell.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/11/1.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit
import CoreLibrary

class HomePageFooterCell: BaseTableViewCell {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    override func layoutSubviews(){
        initLabel()
        initIcon()
        
    }
    
    private var icon:UILabel!
    private func initIcon(){
        if icon == nil{
            icon = UICreaterUtils.createLabel(UIConfig.ICON_FONT_NAME, 20, UICreaterUtils.colorRise);
            addSubview(icon!)
            icon.textAlignment = NSTextAlignment.Center;
            
            icon.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(self.titleLabel.snp_left).offset(-6)
                make.centerY.equalTo(self.titleLabel)
            })
            
            icon.text = UIConfig.ICON_ZHENG_JIAN_HUI;
//            let url:String = "money"
//            BatchLoaderForSwift.loadFile(url, callBack: { (image) -> Void in
//                self.icon!.image = image
//            })
        }
    }
    
    private var titleLabel:UILabel!
    private func initLabel(){
        if(titleLabel == nil){
            titleLabel = UILabel()
            titleLabel.font = UIFont.systemFontOfSize(14)
            titleLabel.textColor = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1)
            addSubview(titleLabel)
            titleLabel.snp_makeConstraints(closure: { (make) -> Void in
//                make.left.equalTo(self.square.snp_right).offset(20)
                make.center.equalTo(self)
            })
        }
        let info:String = data as! String
        titleLabel.text = info
        titleLabel.sizeToFit()
    }
    
}
