//
//  HomePageControl.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/10/18.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class HomePageNavigationControl: UINavigationController {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func viewWillAppear(animated: Bool){
//        self.navigationController?.navigationBar.translucent = false//    Bar的高斯模糊效果，默认为YES
        self.navigationBar.barTintColor = UIColor(red: 232 / 255, green: 50 / 255, blue: 85 / 255, alpha: 0.5) //
    }
    
    override func viewDidLoad() {
//        hidesBottomBarWhenPushed = true
//        toolbarHidden = true
//        setNavigationBarHidden(false, animated: false)
//        setToolbarHidden(true, animated: false)
//        navigationBar.hidden = true
    }

}
