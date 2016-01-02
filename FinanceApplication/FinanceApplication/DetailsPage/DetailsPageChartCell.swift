//
//  DetailsPageChartCell.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/11/15.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit
@objc public protocol DetailsPageCellDelegate {
    // MARK: - Delegate functions
    optional func willMoveToDetailsPage(indexPath: NSIndexPath)
    optional func didMoveToDetailsPage(indexPath: NSIndexPath)
}
class DetailsPageChartCell: BaseTableViewCell,CASectionPageMenuDelegate {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    weak var delegate:DetailsPageCellDelegate?
    var cellVo:CellVo?
    
    var pageSection:DetailsPageChartSection!{
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
            scrollView.contentSize = CGSizeMake(self.frame.width * 3, 0) //设置容器深度
            
//            var lineColor:UIColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1)
//            var topLine = UIView()
//            topLine.backgroundColor = lineColor
//            addSubview(topLine)
//            topLine.snp_makeConstraints(closure: { (make) -> Void in
//                make.top.left.right.equalTo(self)
//                make.height.equalTo(UICreaterUtils.normalLineWidth)
//            })
        }
        if pageSection != nil{
            if pageSection.pageMenu != nil{
                var pageMenu = pageSection.pageMenu
                pageMenu.controllerScrollView = self.scrollView
                pageMenu.delegate = self
            }else{
                pageSection.pageMenuInit = { pageMenu in
                    pageMenu.controllerScrollView = self.scrollView
//                    pageMenu.titleArray = ["净值增长率","日增长率","净值估算"]
                    pageMenu.delegate = self
                }
            }
        }
    }
    
    func willMoveToPage(index: Int){
//        var color:CGFloat = CGFloat(CGFloat(random())/CGFloat(RAND_MAX))
//        var color1:CGFloat = CGFloat(CGFloat(random())/CGFloat(RAND_MAX))
//        var color2:CGFloat = CGFloat(CGFloat(random())/CGFloat(RAND_MAX))
//        var color3:CGFloat = CGFloat(CGFloat(random())/CGFloat(RAND_MAX))
//        
//        var view:UIView = UIView(frame:CGRectMake(self.frame.width * CGFloat(index), 0, self.frame.width, self.frame.height))
//        view.backgroundColor = UIColor(red: color, green: color1, blue: color2, alpha: 1)
//        scrollView.addSubview(view)
//        
//        var data=[
//            PPiFlatSegmentItem(title: "一月", andIcon: nil),
//            PPiFlatSegmentItem(title: "一季", andIcon: nil),
//            PPiFlatSegmentItem(title: "半年", andIcon: nil),
//            PPiFlatSegmentItem(title: "一年", andIcon: nil)
//        ];
//        var segmentControl = PPiFlatSegmentedControl(frame:  CGRectZero, items: data, iconPosition: IconPositionRight, iconSeparation:0 ,target:self, andSelection:"segmentControlSelected:")
//        var tintColor:UIColor = UIColor(red: 232/255, green: 54/255, blue: 59/255, alpha: 1)
//        var lineColor:UIColor = UIColor(red: 184/255, green: 184/255, blue: 184/255, alpha: 1)
//        segmentControl.color = UIColor.blueColor()
//        segmentControl.borderWidth = 1
//        segmentControl.borderColor = lineColor
//        segmentControl.selectedColor = tintColor
//        segmentControl.color = UIColor.clearColor()
//        segmentControl.selectedTextAttributes=[NSFontAttributeName:UIFont.systemFontOfSize(13),
//            NSForegroundColorAttributeName:UIColor.whiteColor()]
//        segmentControl.textAttributes=[NSFontAttributeName:UIFont.systemFontOfSize(13),
//            NSForegroundColorAttributeName:UIColor.blackColor()]
//        view.addSubview(segmentControl)
//        
//        segmentControl.snp_makeConstraints { (make) -> Void in
//            make.left.equalTo(view).offset(18)
//            make.right.equalTo(view).offset(-18)
//            make.top.equalTo(view).offset(15)
//            make.height.equalTo(28)
//        }
        
        var pvo = DetailsPageChartCell.chartCellList[index]
        if !hasInstanceList[index] {//不存在
            var view:PageDataView? = pvo.view
            if view == nil{
                var cellClass = pvo.cellClass
                view = cellClass()
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
    
    private var hasInstanceList:[Bool] = [false,false,false];
    
    func didMoveToPage(index: Int){
        var pvo = DetailsPageChartCell.chartCellList[index]
        //撑开当前条目高度
        cellVo?.cellHeight = pvo.cellHeight//重新刷新条目高度
        delegate?.didMoveToDetailsPage?(self.indexPath)
    }

    private static var chartCellList = [
        ChartPageVo(cellClass: DetailsNetValueRateView.self, cellHeight: 304),
        ChartPageVo(cellClass: DetailsDayValueRateView.self, cellHeight: 302),
        ChartPageVo(cellClass: DetailsNetValueEstimateView.self, cellHeight: 296)
    ];
 
    static func getFirstPageHeight()->CGFloat{
        return chartCellList[0].cellHeight
    }
}
typealias PageCellRefreshHeightHandler = (view:UIView,height:CGFloat)->Void
class PageDataView:UIView{
    var refresh:Bool = false //重新刷新界面数据
    func refreshData()->Void{
        refresh = true
        setNeedsLayout()
    }
    override func layoutSubviews() {
        refresh = false
    }
    var data:Any?
//    var pageVo:ChartPageVo!
    var refreshHeightHandler:PageCellRefreshHeightHandler?
}
class ChartPageVo {
    init(cellClass:PageDataView.Type,cellHeight:CGFloat,view:PageDataView? = nil){
        self.cellClass = cellClass
        self.cellHeight = cellHeight
        self.view = view
    }
    var cellClass:PageDataView.Type!
    var cellHeight:CGFloat = 0.0
    var view:PageDataView?
}