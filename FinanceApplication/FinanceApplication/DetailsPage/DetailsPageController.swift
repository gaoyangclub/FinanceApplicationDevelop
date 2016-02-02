//
//  DetailsPageController.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/11/10.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class DetailsPageController: BaseTableViewController,DetailsPageCellDelegate{

    var pageData:InfoFundVo!
    
    func setupRefresh(){
        self.refreshContaner.addHeaderWithCallback(RefreshHeaderView.header(),callback: {
            let delayInSeconds:Int64 =  1000000000  * 1
            
            let popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.dataSource.removeAllObjects()
                let detailsPageSource = self.getDetailsSource()
                for i in 0..<detailsPageSource.count{
                    self.dataSource.addObject(detailsPageSource[i])
                }
                self.tableView.reloadData()
                self.refreshContaner.headerReset()
            })
        })
    }

    private func getDetailsSource()->NSMutableArray{
        let source:NSMutableArray = [
            SoueceVo(data: [
                CellVo(cellHeight: DetailsPageInfoCell.cellHeight, cellClass: DetailsPageInfoCell.self, cellData: pageData)
                ]),
            SoueceVo(data: [
                CellVo(cellHeight: DetailsPageChartCell.getFirstPageHeight(), cellClass: DetailsPageChartCell.self, cellData: pageData)
                ],headerHeight:42,headerClass:DetailsPageChartSection.self),
            SoueceVo(data: [
                CellVo(cellHeight: DetailsPageMultipleCell.getFirstPageHeight(), cellClass: DetailsPageMultipleCell.self, cellData: pageData)
                ],headerHeight:42,headerClass:DetailsPageMultipleSection.self),
//            SoueceVo(data: [
//                CellVo(cellHeight: DetailsPageInfoCell.cellHeight, cellClass: DetailsPageInfoCell.self, cellData: pageData)
//                ],headerHeight:42,headerClass:DetailsPageMultipleSection.self)
        ]
        return source
    }
    
    private let operateHeight:CGFloat = 48
    lazy var operateArea:UIView = {
        let area:UIView = UIView()
        self.view.addSubview(area)
        area.snp_makeConstraints(closure: { (make) -> Void in
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(self.operateHeight)
        })
        return area
    }()
    
    lazy var castButton:UIButton = {
        let btn = UIButton(type: UIButtonType.System)
        let normalColor:UIColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        btn.backgroundColor = normalColor
        let title:NSString = "定投"
        btn.setTitle(title as String, forState: UIControlState.Normal)
        btn.setTitleColor(UIColor(red: 232/255, green: 55/255, blue: 59/255, alpha: 1), forState: UIControlState.Normal)
        self.operateArea.addSubview(btn)
        
        var attstr:NSMutableAttributedString = NSMutableAttributedString(string: title as String)
        attstr.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, title.length))
        btn.titleLabel?.attributedText = attstr
        btn.titleLabel?.font = UIFont.systemFontOfSize(18)//weight文字线条粗细 ,weight:2
        
        return btn
    }()
    
    lazy var applyButton:UIButton = {
        let btn = UIButton(type: UIButtonType.System)
        let normalColor:UIColor = UIColor(red: 232/255, green: 55/255, blue: 59/255, alpha: 1)
        btn.backgroundColor = normalColor
        let title:NSString = "申购"
        btn.setTitle(title as String, forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.operateArea.addSubview(btn)
        
        var attstr:NSMutableAttributedString = NSMutableAttributedString(string: title as String)
        attstr.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, title.length))
        btn.titleLabel?.attributedText = attstr
        btn.titleLabel?.font = UIFont.systemFontOfSize(18)//weight文字线条粗细 ,weight:2
        
        return btn
    }()
    
    lazy var favoriteArea:UIView = {
        let view = UIControl()
        view.backgroundColor = UIColor(red: 253/255, green: 253/255, blue: 253/255, alpha: 1)
        self.operateArea.addSubview(view)
        view.addTarget(self, action: "favoriteAreaClick", forControlEvents: UIControlEvents.TouchUpInside)
        
//        let btn = DOFavoriteButton()
//        btn.backgroundColor = UIColor.brownColor()
//        view.addSubview(btn)
//        btn.frame.size = CGSize(width: 24, height: 24)
//        btn.image = image
////        btn.setTitle("关注", forState: UIControlState.Normal)
//        btn.addTarget(self, action: Selector("tapped:"), forControlEvents: .TouchUpInside)
//        btn.snp_makeConstraints(closure: { (make) -> Void in
//            make.centerX.equalTo(view)
////            make.size.equalTo(CGSize(width: self.operateHeight / 2, height: self.operateHeight / 2))
////            make.centerY.equalTo(self.operateHeight / 4)
//            make.bottom.equalTo(view)
//        })
        
        //        let image = UIImage(named: "star")!
        
        
        BatchLoaderUtil.loadFile("star", callBack: { (image, params) -> Void in
            self.tabItem = UIFlatImageTabItem(image: image)
            //        tabItem.backgroundColor = UIColor.blackColor()
            view.addSubview(self.tabItem)
            self.tabItem.userInteractionEnabled = false
            self.tabItem.sizeType = .FillWidth
            self.tabItem.normalColor = UICreaterUtils.colorFlat
            self.tabItem.selectColor = UICreaterUtils.colorRise
            
            self.tabItem.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(18)
                make.left.right.equalTo(view)
                make.centerX.equalTo(view)
                make.bottom.equalTo(view.snp_centerY).offset(4)
            })
        })
        
        self.focusLabel = UICreaterUtils.createLabel(12, UICreaterUtils.colorFlat, "关注", true, view)
        self.focusLabel.snp_makeConstraints(closure: { (make) -> Void in
//            make.left.right.top.bottom.equalTo(view)
            make.centerX.equalTo(view)
//            make.centerY.equalTo(self.operateHeight * 3 / 4)
            make.top.equalTo(view.snp_centerY).offset(6)
        })
        return view
    }()
    
    lazy private var topLine:UIView = {
        let line = UIView()
        self.operateArea.addSubview(line)
        line.backgroundColor = UICreaterUtils.normalLineColor
        return line
    }()
    
    lazy private var tabLine:UIView = {
        let line = UIView()
        self.operateArea.addSubview(line)
        line.backgroundColor = UICreaterUtils.normalLineColor
        return line
    }()
    
    private var focusLabel:UILabel!
    private var tabItem:UIFlatImageTabItem!
    func favoriteAreaClick() {
        tabItem.select = !tabItem.select
        showStarLabel()
        self.pageData.isFollow = tabItem.select
        if tabItem.select {
            GoogleWearAlert.showAlert(title: "关注成功", image:nil, type: .Success, duration: 0.5, inViewController: self)
        }else{
            GoogleWearAlert.showAlert(title:"取消关注", image:nil, type: .Error, duration: 0.5, inViewController: self)
        }
    }
    
    private func showStarLabel(){
        focusLabel.textColor = tabItem.select ? tabItem.selectColor : tabItem.normalColor
    }
    
    private func initOperateArea(){
//        let buttomWidth = (self.view.frame.width - operateHeight) / 2
        
        castButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(operateHeight)
            make.top.bottom.equalTo(self.operateArea)
            make.width.equalTo(operateArea).dividedBy(2).offset(-operateHeight / 2)
        }
        
        applyButton.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(castButton.snp_right)
            make.top.bottom.right.equalTo(self.operateArea)
        }
        
        favoriteArea.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(operateHeight)
            make.top.bottom.left.equalTo(self.operateArea)
        }
        
        tabItem.select = self.pageData.isFollow
        showStarLabel()
        
        topLine.snp_makeConstraints(closure: { (make) -> Void in
            make.left.right.top.equalTo(self.operateArea)
            make.height.equalTo(UICreaterUtils.normalLineWidth)
        })
        
        tabLine.snp_makeConstraints(closure: { (make) -> Void in
            make.top.bottom.equalTo(self.operateArea)
            make.width.equalTo(UICreaterUtils.normalLineWidth)
            make.left.equalTo(favoriteArea.snp_right)
        })
    }
    
    //重写refreshContaner布局
    override func refreshContanerMake(make:ConstraintMaker)-> Void{
        make.left.right.top.equalTo(self.view)
        make.bottom.equalTo(self.operateArea.snp_top)
    }
    
    func pushView(nc:NSNotification){
        let nextController = nc.object as! UIViewController
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pushView:", name: "Details:pushView",object:nil)
        
        super.viewDidLoad()
        setupRefresh()
        
        initOperateArea()
        
//        refreshContaner.snp_makeConstraints { (make) -> Void in
//            make.left.right.top.equalTo(self.view)
//            make.bottom.equalTo(self.operateArea.snp_top)
//        }
//        tabBarController?.hidesBottomBarWhenPushed = true
        
        let leftItem = //UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "cancelClick")
        UIBarButtonItem(title: "嘿嘿", style: UIBarButtonItemStyle.Done, target: self, action: "cancelClick")
                let customView = UIArrowView(frame:CGRectMake(0, 0, 10, 22))
                customView.direction = .LEFT
        ////        customView.isClosed = true
                customView.lineColor = UIColor.whiteColor()
                customView.lineThinkness = 2
        ////        customView.fillColor = UIColor.blueColor()
                leftItem.customView = customView
        customView.addTarget(self, action: "cancelClick", forControlEvents: UIControlEvents.TouchDown)
        
        self.navigationItem.leftBarButtonItem = leftItem
        
        let titleView:UIView = UIView()
        
        let sublabel:UILabel = UILabel()
        sublabel.font = UIFont.systemFontOfSize(14)//20号
        sublabel.textColor = UIColor.whiteColor()
        sublabel.text = pageData.code
        sublabel.sizeToFit()
        titleView.addSubview(sublabel)
        sublabel.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(titleView).offset(15)
            make.centerX.equalTo(titleView)
        }
        
        let label:UILabel = UILabel()
        label.font = UIFont.systemFontOfSize(20)//20号 ,weight:2
        label.textColor = UIColor.whiteColor()
        label.text = pageData.title
        label.sizeToFit()
        
        titleView.addSubview(label)
        label.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(sublabel.snp_top)
            make.centerX.equalTo(titleView)
        }
        
//        self.title = pageData.title
        self.navigationItem.titleView = titleView
        self.view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        
        self.refreshContaner.headerBeginRefreshing()
    }
    
    override func viewDidAppear(animated: Bool) {
        let searchIndex = self.navigationController!.viewControllers.count - 2
//        var viewControllers:[AnyObject] = self.navigationController!.viewControllers
        if (self.navigationController?.viewControllers[searchIndex] as? SearchViewController != nil){//上一层是SearchViewController就要移除掉
            self.navigationController?.viewControllers.removeAtIndex(searchIndex)
        }
    }
    
    func cancelClick(){
        self.navigationController?.popViewControllerAnimated(true)
//        self.navigationController?.popToRootViewControllerAnimated(true)
//        self.navigationController?.pop
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var detailsPageChartHeader:DetailsPageChartSection!
    private var detailsPageMultipleSection:DetailsPageMultipleSection!
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = super.tableView(tableView,viewForHeaderInSection:section)
        if header is DetailsPageChartSection{
            detailsPageChartHeader = header as! DetailsPageChartSection
            pageChartCell()
        }else if header is DetailsPageMultipleSection{
            detailsPageMultipleSection = header as! DetailsPageMultipleSection
            pageMultipleCell()
        }
        return header
    }
    private var detailsPageChartCell:DetailsPageChartCell!
    private var detailsPageMultipleCell:DetailsPageMultipleCell!
    //创建条目
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = super.tableView(tableView,cellForRowAtIndexPath:indexPath)
        let section = indexPath.section
        let row = indexPath.row
        let source = dataSource[section] as! SoueceVo
        let cellVo:CellVo = source.data![row] as! CellVo//获取的数据给cell显示
        if cell is DetailsPageChartCell{
            detailsPageChartCell = cell as! DetailsPageChartCell
            detailsPageChartCell.delegate = self
            detailsPageChartCell.cellVo = cellVo
            pageChartCell()
        }else if cell is DetailsPageMultipleCell{
            detailsPageMultipleCell = cell as! DetailsPageMultipleCell
            detailsPageMultipleCell.delegate = self
            detailsPageMultipleCell.cellVo = cellVo
            pageMultipleCell()
        }
        return cell
    }
    
    func willMoveToDetailsPage(indexPath: NSIndexPath) {
        didMoveToDetailsPage(indexPath)
    }
    
    func didMoveToDetailsPage(indexPath: NSIndexPath) {
//        self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //获取当前indexPath并判断对应的Cell是否被选中
        //最神奇的地方！！
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    private func pageChartCell(){
        if detailsPageChartHeader != nil && detailsPageChartCell != nil{
            detailsPageChartCell.pageSection = detailsPageChartHeader
        }
    }
    
    private func pageMultipleCell(){
        if detailsPageMultipleSection != nil && detailsPageMultipleCell != nil{
            detailsPageMultipleCell.pageSection = detailsPageMultipleSection
        }
    }


}
