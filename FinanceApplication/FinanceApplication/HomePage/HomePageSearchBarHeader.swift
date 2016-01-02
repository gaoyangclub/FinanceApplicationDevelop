//
//  HomePageSearchBarHeader.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/11/1.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class HomePageSearchBarHeader: BaseItemRenderer {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    private var searchBar:UISearchBar!
    override func layoutSubviews() {
        initSearch()
    }

    var contentsController:HomePageController!{
        didSet{
            setNeedsLayout()
        }
    }
//    private var searchController:UISearchDisplayController!
    
    private func initSearch(){
        if searchBar == nil{
//            var result = SearchResultsTableViewController()
//            searchController = UISearchController(searchResultsController: nil)
//            searchController.searchResultsUpdater = result
//            self.searchController.dimsBackgroundDuringPresentation = false;
//            
//            searchBar = searchController.searchBar
            searchBar = UISearchBar()
            self.addSubview(searchBar)
            
//            searchBar.barStyle = UIBarStyle.BlackTranslucent //样式
            //        searchBar.text = "租房点评" //填入文字
            
//            searchBar.prompt = "请关注下面APP，各大市场均有下载" //提示副标题
            searchBar.placeholder = "请输入基金名称" //提示文字
            
//            searchBar.snp_makeConstraints { (make) -> Void in
////                make.left.equalTo(self).offset(15)
////                make.right.equalTo(self).offset(-15)
//                make.left.right.top.bottom.equalTo(self)
//            }
            
            searchBar.sizeToFit()
//            if contentsController != nil{
//                searchController = UISearchDisplayController(searchBar: searchBar, contentsController: contentsController)
////                searchController.displaysSearchBarInNavigationBar
////                searchController.displaysSearchBarInNavigationBar = true
//            }
        }
//        searchBar.frame = self.frame
    }
}
