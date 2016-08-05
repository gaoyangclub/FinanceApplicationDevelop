//
//  DetailsPageMultipleCell.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/12/5.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit
import CoreLibrary

class DetailsPageMultipleCell: BaseTableViewCell,CASectionPageMenuDelegate {
    weak var delegate:DetailsPageCellDelegate?
//    var cellVo:CellVo?
    
    var pageSection:DetailsPageMultipleSection!{
        didSet{
            setNeedsLayout()
        }
    }
    
    private var scrollView:UIScrollView!
    
    override func layoutSubviews(){
        initScrollView()
    }
    
    private func initScrollView(){
        if scrollView == nil{
            scrollView = UIScrollView()
            addSubview(scrollView)
            scrollView.snp_makeConstraints(closure: { (make) -> Void in
                make.left.right.top.bottom.equalTo(self)
            })
            scrollView.contentSize = CGSizeMake(self.frame.width * 5, 0) //设置容器深度
            willMoveToPage(0)
        }
        if pageSection != nil{
            if pageSection.pageMenu != nil{
                let pageMenu = pageSection.pageMenu
                pageMenu.controllerScrollView = self.scrollView
                pageMenu.delegate = self
            }else{
                pageSection.pageMenuInit = { pageMenu in
                    pageMenu.controllerScrollView = self.scrollView
                    pageMenu.delegate = self
                }
            }
        }
    }
    
    func willMoveToPage(index: Int){
        let pvo = DetailsPageMultipleCell.chartCellList[index]
        if !hasInstanceList[index] {//不存在
            var view:PageDataView? = pvo.view
            if view == nil{
                let cellClass = pvo.cellClass
                view = cellClass.init()
                pvo.view = view
            }
            view?.data = data
            //            view?.pageVo = pvo
            view?.removeFromSuperview()//先从父容器移除
            view?.frame = CGRectMake(self.frame.width * CGFloat(index), 0, self.frame.width, pvo.cellHeight)
            scrollView.addSubview(view!) //添加到容器
            view?.refreshData()
            view?.refreshHeightHandler = { view,height in
                //重新计算测量高度
                view.frame.size.height = height
                pvo.cellHeight = height
                self.didMoveToPage(index)
            }
            hasInstanceList[index] = true
        }
        cellVo?.cellHeight = pvo.cellHeight//重新刷新条目高度
        delegate?.willMoveToDetailsPage?(self.indexPath)
    }
    
    func didMoveToPage(index: Int){
        let pvo = DetailsPageMultipleCell.chartCellList[index]
        //撑开当前条目高度
        cellVo?.cellHeight = pvo.cellHeight//重新刷新条目高度
        delegate?.didMoveToDetailsPage?(self.indexPath)
    }
    private var hasInstanceList:[Bool] = [false,false,false,false,false];
    private static var chartCellList = [
        ChartPageVo(cellClass: DetailsSummaryView.self, cellHeight: 504),
        ChartPageVo(cellClass: DetailsStockView.self, cellHeight: 470),
        ChartPageVo(cellClass: DetailsNoticeView.self, cellHeight: DetailsNoticeView.defaultHeight),
        ChartPageVo(cellClass: PageDataView.self, cellHeight: 600),
        ChartPageVo(cellClass: PageDataView.self, cellHeight: 400)
    ];
    
    static func getFirstPageHeight()->CGFloat{
        return chartCellList[0].cellHeight
    }
}
