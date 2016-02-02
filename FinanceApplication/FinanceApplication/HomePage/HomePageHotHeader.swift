//
//  HomePageHotHeader.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/11/1.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class HomePageHotHeader: BaseTableViewCell {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        initSquare()
        initLabel()
    }
    
    private var square:UIView!
    private func initSquare(){
        if square == nil{
            square = UIView()
            addSubview(square)
            square.backgroundColor = UIColor(red: 230/255, green: 54/255, blue: 60/255, alpha: 1)
            square.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self)
                make.centerY.equalTo(self)
//                make.size.equalTo(CGSize(width: 5, height: 18))
                make.width.equalTo(5)
                make.height.equalTo(18)
            })
        }
    }
    
    private var title:UILabel!
    private func initLabel(){
        if(title == nil){
            title = UILabel()
            title.font = UIFont.systemFontOfSize(14)
            title.textColor = UIColor(red: 127/255, green: 127/255, blue: 127/255, alpha: 1)
            addSubview(title)
            title.snp_makeConstraints(closure: { (make) -> Void in
                make.left.equalTo(self.square.snp_right).offset(20)
                make.centerY.equalTo(self)
            })
        }
        let info:String = data as! String
        title.text = info
        title.sizeToFit()
    }
    
}
