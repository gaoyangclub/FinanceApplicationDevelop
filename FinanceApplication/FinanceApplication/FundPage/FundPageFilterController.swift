
//
//  FundPageFilterController.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/12/19.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class FundPageFilterController: BaseTableViewController {
    
    enum SortNameKind:String{
        case NET_VALUE = "netValue"
        case RATE_DAY = "rateDay"
    }
    
    var fundHeader:InfoFundHeader!
    
    lazy var topArea:UIView = {
        let view = UIView()
        let normalColor:UIColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        view.backgroundColor = normalColor
        self.view.addSubview(view)
        view.snp_makeConstraints(closure: { (make) -> Void in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(30)
        })
        return view
        }()
    
    private lazy var bottomLine:UIView = self.createFilterLine()
    private lazy var topLine:UIView = self.createFilterLine()
    private lazy var middleLeftLine:UIView = self.createFilterLine()
    private lazy var middleRightLine:UIView = self.createFilterLine()
    
    lazy var nameButton:UIButton = {
        let btn = self.createFilterButton("基金名称")
        btn.userInteractionEnabled = false
        return btn
        }()
    
    lazy var netButton:UIButton = self.createFilterButton("单位净值")
    
    lazy var rateButton:UIButton = self.createFilterButton("日涨幅")
    
    
    private lazy var netArrowImage:UIFlatImageTabItem = {
        let tabItem = UIFlatImageTabItem()
        self.topArea.addSubview(tabItem)
        tabItem.userInteractionEnabled = false
        tabItem.sizeType = .FillWidth
        tabItem.normalColor = UICreaterUtils.colorRise
        tabItem.hidden = true
        //        tabItem.selectColor = UICreaterUtils.colorRise
        BatchLoaderForSwift.loadFile("arrow", callBack: { (image) -> Void in
            tabItem.image = image
        })
        return tabItem
        }()
    
    
    lazy var rateArrowImage:UIFlatImageTabItem = {
        let tabItem = UIFlatImageTabItem()
        self.topArea.addSubview(tabItem)
        tabItem.userInteractionEnabled = false
        tabItem.sizeType = .FillWidth
        tabItem.normalColor = UICreaterUtils.colorRise
        //        tabItem.selectColor = UICreaterUtils.colorRise
        BatchLoaderForSwift.loadFile("arrow", callBack: { (image) -> Void in
            tabItem.image = image
        })
        return tabItem
        }()
    
    func createFilterLine()->UIView{
        let view:UIView = UIView()
        view.backgroundColor = UICreaterUtils.normalLineColor
        self.topArea.addSubview(view)
        return view
    }
    
    private func createFilterButton(title:NSString)->UIButton{
        let btn = UIButton(type: UIButtonType.System)
        //        let title:NSString = "基金名称"
        //        let normalColor:UIColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        //        btn.backgroundColor = normalColor
        btn.setTitle(title as String, forState: UIControlState.Normal)
        btn.setTitleColor(UICreaterUtils.colorBlack, forState: UIControlState.Normal)
        //        btn.setTitleColor(UICreaterUtils.colorFlat, forState: UIControlState.Highlighted)
        self.topArea.addSubview(btn)
        
        let attstr:NSMutableAttributedString = NSMutableAttributedString(string: title as String)
        attstr.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, title.length))
        btn.titleLabel?.attributedText = attstr
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)//weight文字线条粗细
        btn.addTarget(self, action: "btnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }
    
    func btnClick(btn:UIButton){
        //        println("筛选按钮点击了")
        var transform:CGAffineTransform
        if btn == netButton{
            if currentNameKind != SortNameKind.NET_VALUE{
                self.netArrowImage.hidden = false
                self.rateArrowImage.hidden = true
                currentOrder = true
                transform = CGAffineTransformIdentity
            }else{
                currentOrder = !currentOrder
                transform = currentOrder ? CGAffineTransformIdentity : CGAffineTransformMakeRotation(CGFloat(M_PI ))
            }
            currentNameKind = SortNameKind.NET_VALUE
            self.netArrowImage.transform = transform
            
            sortHeaderReset()
        }else if btn == rateButton{
            if currentNameKind != SortNameKind.RATE_DAY{
                self.netArrowImage.hidden = true
                self.rateArrowImage.hidden = false
                currentOrder = true
                transform = CGAffineTransformIdentity
            }else{
                currentOrder = !currentOrder
                transform = currentOrder ? CGAffineTransformIdentity : CGAffineTransformMakeRotation(CGFloat(M_PI ))
            }
            currentNameKind = SortNameKind.RATE_DAY
            self.rateArrowImage.transform = transform
            
            sortHeaderReset()
        }
    }
    
    private func sortHeaderReset(){
        self.refreshHeader()
        self.tableView.reloadData()
//        self.headerReset()
    }
    
    static let leftpadding = 136
    static let rightpadding = 92
    private static let lineMargin = 4
    
    private func initTopArea(){
        nameButton.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.topArea)
            make.left.equalTo(self.topArea)
            make.right.equalTo(middleLeftLine.snp_centerX)
        }
        netButton.snp_makeConstraints { (make) -> Void in
            make.centerY.top.bottom.equalTo(self.topArea)
            make.left.equalTo(middleLeftLine.snp_centerX)
            make.right.equalTo(middleRightLine.snp_centerX)
        }
        rateButton.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(self.topArea)
            make.right.equalTo(self.topArea)
            make.left.equalTo(middleRightLine.snp_centerX)
        }
        topLine.snp_makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self.topArea)
            make.height.equalTo(UICreaterUtils.normalLineWidth)
        }
        bottomLine.snp_makeConstraints { (make) -> Void in
            make.bottom.left.right.equalTo(self.topArea)
            make.height.equalTo(UICreaterUtils.normalLineWidth)
        }
        middleLeftLine.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.topArea).offset(FundPageFilterController.lineMargin)
            make.bottom.equalTo(self.topArea).offset(-FundPageFilterController.lineMargin)
            make.width.equalTo(UICreaterUtils.normalLineWidth)
            make.centerX.equalTo(self.topArea.snp_left).offset(FundPageFilterController.leftpadding)
        }
        middleRightLine.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.topArea).offset(FundPageFilterController.lineMargin)
            make.bottom.equalTo(self.topArea).offset(-FundPageFilterController.lineMargin)
            make.width.equalTo(UICreaterUtils.normalLineWidth)
            make.centerX.equalTo(self.topArea.snp_right).offset(-FundPageFilterController.rightpadding)
        }
        netArrowImage.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(middleRightLine.snp_left).offset(-8)
            make.centerY.equalTo(self.topArea)
//            make.size.equalTo(CGSize(width: 8, height: 24))
            make.width.equalTo(8)
            make.height.equalTo(24)
        }
        
        rateArrowImage.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(self.topArea).offset(-10)
            make.centerY.equalTo(self.topArea)
//            make.size.equalTo(CGSize(width: 8, height: 24))
            make.width.equalTo(8)
            make.height.equalTo(24)
        }
        
    }
    
    //重写refreshContaner布局
    //    override func refreshContanerMake(make:ConstraintMaker)-> Void{
    //        make.left.right.top.equalTo(self.view)
    //        make.bottom.equalTo(self.topArea.snp_top)
    //    }
    
    override func refreshContanerMake(make:ConstraintMaker)-> Void{
        make.bottom.left.right.equalTo(self.view)
        //        make.bottom.left.right.equalTo(self.view).offset(-50)
        make.top.equalTo(topArea.snp_bottom)
    }
    
    private func headerReset(){
        let delayInSeconds:Int64 =  1000000000  * 1
        
        let popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
        dispatch_after(popTime, dispatch_get_main_queue(), {
            self.startIndex = 0
            self.dataSource = self.getFundFilterSource()
            self.tableView?.reloadData()
            self.refreshContaner?.headerReset()
        })
    }
    
    private var startIndex:Int = 0
    private var hasSetUp:Bool = false
    private func setupRefresh(){
        self.hasSetUp = true
        
        self.refreshContaner.addHeaderWithCallback(RefreshHeaderView.header(),callback: {
            self.headerReset()
        })
        
        self.refreshContaner.addFooterWithCallback(RefreshFooterView.footer(),callback: {
            let delayInSeconds:Int64 =  1000000000  * 1
            
            let popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                if self.addFundFilterSource(){
                    self.tableView.reloadData()
                    self.refreshContaner.footerReset()
                }else{
//                    self.tableView.reloadData()
                    self.refreshContaner.footerNodata()
                }
            })
        })
    }
    
    private var currentNameKind:SortNameKind = SortNameKind.RATE_DAY
    private var currentOrder:Bool = true
    private func addFundFilterSource()->Bool{
        let fundFilterResult = DataRemoteFacade.getFundFilterResult(fundHeader.kind, startIndex: startIndex, keyNameKind: currentNameKind.rawValue,order:currentOrder)//keyName:
        if fundFilterResult.count == 0{
            return false
        }
        if dataSource.count == 0{
            print("添加数据但是原始数据居长度然是0！！！")
            return false
        }
        let lastSection = dataSource.count - 1
        let lastSource:SoueceVo = self.dataSource[lastSection] as! SoueceVo
        let firstHeader = fundFilterResult[0] as! FilterFundHeader
        var svo:SoueceVo?
        if (lastSource.headerData as! String) == firstHeader.timeKey{//头部是末尾的追踪
            svo = lastSource
        }
        for head in fundFilterResult{
            let hvo = head as! FilterFundHeader
            var data:NSMutableArray!
            if svo == nil{
                data = []
                svo = SoueceVo(data: data, headerHeight: FundPageFilterHeader.headerHeight, headerClass: FundPageFilterHeader.self, headerData: hvo.timeKey)
                self.dataSource.addObject(svo!)
                //                tableView.insertSections(NSIndexSet(index: lastSection), withRowAnimation: UITableViewRowAnimation.None)
            }else{
                data = svo?.data
            }
//            var row = 0
            for info in hvo.fundList{
                let fvo = info as! InfoFundVo
                data.addObject(CellVo(cellHeight: FundPageFilterCell.cellHeight, cellClass: FundPageFilterCell.self, cellData: fvo))
                //                tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: row, inSection: lastSection)], withRowAnimation: UITableViewRowAnimation.None)
//                row++
                startIndex++
            }
//            lastSection++
            svo = nil //清空
        }
        //        tableView.beginUpdates()
        //        tableView.endUpdates()
        return true
    }
    
    private func getFundFilterSource()->NSMutableArray{
        let fundFilterResult = DataRemoteFacade.getFundFilterResult(fundHeader.kind, startIndex: startIndex, keyNameKind: currentNameKind.rawValue,order:currentOrder)//keyName: "rateDay"
        let source:NSMutableArray = []
        for head in fundFilterResult{
            let hvo = head as! FilterFundHeader
            let data:NSMutableArray = []
            let svo = SoueceVo(data: data, headerHeight: FundPageFilterHeader.headerHeight, headerClass: FundPageFilterHeader.self, headerData: hvo.timeKey)
            source.addObject(svo)
            for info in hvo.fundList{
                let fvo = info as! InfoFundVo
                data.addObject(CellVo(cellHeight: FundPageFilterCell.cellHeight, cellClass: FundPageFilterCell.self, cellData: fvo))
                
                startIndex++
            }
        }
        return source
    }
    
    override func viewDidLoad() {
//                useCellIdentifer = false
        
        super.viewDidLoad()
        //        self.automaticallyAdjustsScrollViewInsets = true//YES表示自动测量导航栏高度占用的Insets偏移
        
        initTopArea()
        // Do any additional setup after loading the view.
        //        self.refreshContaner.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        if animated {
            if !hasSetUp && refreshContaner != nil{ //未进行初始化
                self.refreshContaner.headerBeginRefreshing()
                self.setupRefresh()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        print("FundPageFilterController内存释放警告")
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section
        let source = dataSource[section] as! SoueceVo
        let cell:CellVo = source.data![indexPath.row] as! CellVo
        let fvo:InfoFundVo = cell.cellData as! InfoFundVo
        let vc = DetailsPageController()
        vc.pageData = fvo
        
        let nc = NSNotification(name: "FundFilter:pushView", object: vc)
        NSNotificationCenter.defaultCenter().postNotification(nc)
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
private class FundPageFilterHeader:BaseItemRenderer{
    
    static let headerHeight:CGFloat = 14
    
    private lazy var titleLabel:UILabel = UICreaterUtils.createLabel(12,UICreaterUtils.normalLineColor,"",true,self)
    
    private lazy var bottomLine:UIView = {
        let view:UIView = UIView()
        view.backgroundColor = UICreaterUtils.normalLineColor
        self.addSubview(view)
        return view
        }()
    
    override func layoutSubviews() {
        self.backgroundColor = UIColor.whiteColor()
        
        bottomLine.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(UICreaterUtils.normalLineWidth)
        }
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
        titleLabel.text = data as? String
        titleLabel.sizeToFit()
    }
}
private class FundPageFilterCell:BaseTableViewCell{
    static let cellHeight:CGFloat  = 78
    
    private lazy var bottomLine:UIView = {
        let view:UIView = UIView()
        view.backgroundColor = UICreaterUtils.normalLineColor
        self.contentView.addSubview(view)
        return view
        }()
    
    private lazy var titleLabel:UILabel = {
        let label = UICreaterUtils.createLabel(15,UICreaterUtils.colorBlack,"",true,self.contentView)
        label.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.iconView.snp_right)
            //            make.left.equalTo(50)
            make.bottom.equalTo(self.contentView.snp_centerY).offset(-10)
        }
        return label
        }()
    
    private lazy var codeLabel:UILabel = {
        let label = UICreaterUtils.createLabel(12,UICreaterUtils.normalLineColor,"",true,self.contentView)
        label.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.iconView.snp_right)
            make.centerY.equalTo(self.contentView)
        }
        return label
        }()
    
    private lazy var tagArea:UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
        view.snp_makeConstraints { (make) -> Void in
            make.left.right.top.bottom.equalTo(self.contentView)
        }
        return view
        }()
    
    private lazy var netLabel:UILabel = {
        let label = UICreaterUtils.createLabel(16,UICreaterUtils.colorBlack,"",true,self)
        //        label.font = UIFont.systemFontOfSize(16, weight: 1.2)
        label.textAlignment = NSTextAlignment.Center;
        
        label.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(FundPageFilterController.leftpadding)
            make.right.equalTo(self).offset(-FundPageFilterController.rightpadding)
            make.centerY.equalTo(self)
        }
        return label
        }()
    
    private lazy var rateLabel:UILabel = {
        let label = UICreaterUtils.createLabel(16,UICreaterUtils.colorBlack,"",true,self.contentView)
        //        label.font = UIFont.systemFontOfSize(16, weight: 1.2)
        label.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(self.contentView).offset(-5)
            make.centerY.equalTo(self.contentView)
        }
        return label
        }()
    
    private lazy var iconView:UIFlatImageTabItem = {
        let tabItem = UIFlatImageTabItem()
        self.contentView.addSubview(tabItem)
        tabItem.userInteractionEnabled = false
        tabItem.sizeType = .FillWidth
        tabItem.normalColor = UICreaterUtils.colorFlat
        tabItem.selectColor = UICreaterUtils.colorRise
        tabItem.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(self.contentView).offset(2)
//            make.size.equalTo(CGSize(width: 40, height: 18))
            make.width.equalTo(40)
            make.height.equalTo(18)
            make.centerY.equalTo(self.contentView).offset(-6)
        }
        return tabItem
        }()
    
    override func layoutSubviews() {
        let view:UIView? = self
        if view == nil{
            return
        }
        self.backgroundColor = UIColor.whiteColor()
        initText()
        initTagArea()
    }
    
    private func initText(){
        let fvo:InfoFundVo = data as! InfoFundVo
        
        iconView.select = fvo.isFollow
        
        bottomLine.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(UICreaterUtils.normalLineWidth)
        }
        
        self.iconView.image = nil
        BatchLoaderForSwift.loadFile("star", callBack: { (image) -> Void in
            self.iconView.image = image
        })
        
        titleLabel.text = fvo.shortTitle
        titleLabel.sizeToFit()
        
        codeLabel.text = fvo.code
        codeLabel.sizeToFit()
        
        netLabel.text = String(format: "%.4f", fvo.netValue)
        
        var sign = ""
        var color:UIColor
        if fvo.rateDay > 0{
            sign = "+"
            color = UICreaterUtils.colorRise
        }else if fvo.rateDay < 0{
            color = UICreaterUtils.colorDrop
        }else{
            color = UICreaterUtils.colorFlat
        }
        rateLabel.text = sign + String(format: "%.2f", fvo.rateDay * 100) + "%"
        rateLabel.textColor = color
        rateLabel.sizeToFit()
    }
    
    private func initTagArea(){
        
        let fvo:InfoFundVo = data as! InfoFundVo
        var tagArr:[String] = []
        if fvo.discount != 1{//有折扣
            tagArr.append("\(fvo.discount * 10)折")
        }
        if fvo.enoughTag == 1{
            tagArr.append("百元起够")
        }else if fvo.enoughTag == 2{
            tagArr.append("500元起够")
        }
        
        tagArea.removeAllSubViews()
        
        let indexView = self.createRoundTag(10, tagColor: UICreaterUtils.colorFlat, tag: "\(self.indexPath.row + 1)", parent: tagArea)
        indexView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(iconView)
            make.top.equalTo(self.contentView.snp_centerY).offset(14)
        }
        var leftView:UIView?
        let tagColor = UIColor(red: 252/255, green: 52/255, blue: 30/255, alpha: 1)
        for tag in tagArr{
            let subView:UIView = createRoundTag(12, tagColor: tagColor, tag: tag, parent: tagArea)
            //        subView.backgroundColor = UIColor.clearColor()
            if leftView == nil{
                subView.snp_makeConstraints(closure: { (make) -> Void in
                    make.left.equalTo(self.titleLabel)
                    make.centerY.equalTo(indexView)
                })
            }else{
                subView.snp_makeConstraints(closure: { (make) -> Void in
                    make.left.equalTo(leftView!.snp_right).offset(10)
                    make.centerY.equalTo(indexView)
                })
            }
            leftView = subView
        }
        
        var rightView:UIView?// = rateLabel
        if fvo.stars > 0{//银河评级
            let selectColor = UIColor(red: 253/255, green: 176/255, blue: 86/255, alpha: 1)
            for(var i:Int = 4 ;i >= 0; i--){
                let tabItem = UIFlatImageTabItem()
                self.tagArea.addSubview(tabItem)
                tabItem.userInteractionEnabled = false
                tabItem.sizeType = .FillWidth
                tabItem.normalColor = UICreaterUtils.normalLineColor
                tabItem.selectColor = selectColor
                tabItem.select = fvo.stars > i //点亮
                BatchLoaderForSwift.loadFile("star", callBack: { (image) -> Void in
                    tabItem.image = image
                })
                tabItem.snp_makeConstraints { (make) -> Void in
                    if rightView == nil{
                        make.right.equalTo(self.rateLabel)
                    }else{
                        make.right.equalTo(rightView!.snp_left)
                    }
//                    make.size.equalTo(CGSize(width: 13, height: 11))
                    make.width.equalTo(13)
                    make.height.equalTo(11)
                    make.centerY.equalTo(indexView)
                }
                rightView = tabItem
            }
        }else{
            let tempTips = UICreaterUtils.createLabel(12, UICreaterUtils.colorFlat, "无评级", true, tagArea)
            tempTips.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(self.rateLabel)
                make.centerY.equalTo(indexView)
            })
            rightView = tempTips
        }
        if rightView != nil{
            let tips = UICreaterUtils.createLabel(12, UICreaterUtils.colorFlat, "银河评级", true, tagArea)
            tips.snp_makeConstraints(closure: { (make) -> Void in
                make.right.equalTo(rightView!.snp_left).offset(-4)
                make.centerY.equalTo(indexView)
            })
        }
    }
    
    private func createRoundTag(size:CGFloat,tagColor:UIColor,tag:String,parent:UIView)->UIView{
        let label:UILabel = UICreaterUtils.createLabel(size, tagColor, tag)
        label.sizeToFit()
        
        let subView:UIView = UIView()
        parent.addSubview(subView)
        
        subView.addSubview(label)
        label.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(subView)
        }
        
        subView.layer.borderColor = tagColor.CGColor
        subView.layer.borderWidth = 0.6
        subView.layer.cornerRadius = 3
        subView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(label).offset(6)
            make.height.equalTo(label).offset(2)
        }
        
        return subView
        
    }
    
    
    
    
    
}
