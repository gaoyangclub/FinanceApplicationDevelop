//
//  HomePageController.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/10/18.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit
import CoreLibrary

class HomePageController:BaseTableViewController,UISearchResultsUpdating,UISearchControllerDelegate {
    
    lazy private var leftItem:UIBarButtonItem = {
        var item = UIBarButtonItem(title: "扫描", style: UIBarButtonItemStyle.Done, target: self, action: "pushScanController")
        return item
    }()
    
    lazy private var rightItem:UIBarButtonItem = UIBarButtonItem(title: "消息", style: UIBarButtonItemStyle.Done, target: self, action: nil)
    
    lazy private var searchBar:UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "请输入基金代码"
//        bar.searchBarStyle = UISearchBarStyle.Minimal
//        bar.translucent = true //是否透视效果
        
        BatchLoaderForSwift.loadFile("empty", callBack: { (image) -> Void in
            bar.backgroundImage = image // 需要用1像素的透明图片代替背景图 不然动画交互的时候会坑爹的闪现灰底
        })
        
        var topView: UIView = bar.subviews[0] 
        topView.userInteractionEnabled = false
        
//        var ti:UITextField = topView.subviews[1] as! UITextField
//        ti.borderStyle = UITextBorderStyle.None //边框样式
//        ti.backgroundColor = UIColor.whiteColor()
//        ti.layer.cornerRadius = 4.5
        
        var atap = UITapGestureRecognizer(target: self, action: "searchBarTap:")
        atap.numberOfTapsRequired = 1//单击
        bar.addGestureRecognizer(atap)
        
        return bar
    }()
    
    //MARK: -----4个角在矩形框线上,网格动画
    func pushScanController()
    {
        //设置扫码区域参数
        var style = LBXScanViewStyle()
        style.centerUpOffset = 44;
        style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.On;
        style.photoframeLineW = 6;
        style.photoframeAngleW = 24;
        style.photoframeAngleH = 24;
        style.isNeedShowRetangle = true;
        
        style.anmiationStyle = LBXScanViewAnimationStyle.NetGrid;
        
        //使用的支付宝里面网格图片
//        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_part_net");
        BatchLoaderForSwift.loadFile("qrcode_scan_part_net", callBack: { (image) -> Void in
            style.animationImage = image
        })
        
        let vc = HomePageScanController();
        vc.scanStyle = style
        vc.isOpenInterestRect = true //区域扫描
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func initTitleArea(){
//        println(self.navigationItem)
        //        self.navigationController?.navigationBar.hidden = true
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        
//        let leftItem = //UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "cancelClick")
//        UIBarButtonItem(title: "扫描", style: UIBarButtonItemStyle.Done, target: self, action: nil)
        //        var customView = UIArrowView(frame:CGRectMake(0, 0, 22, 10))
        //        customView.direction = .DOWN
        ////        customView.isClosed = true
        //        customView.lineColor = UIColor.whiteColor()
        //        customView.lineThinkness = 1.5
        ////        customView.fillColor = UIColor.blueColor()
        //        leftItem.customView = customView
        self.tabBarController?.navigationItem.leftBarButtonItem = leftItem
        
//        let rightItem = UIBarButtonItem(title: "消息", style: UIBarButtonItemStyle.Done, target: self, action: nil)
        self.tabBarController?.navigationItem.rightBarButtonItem = rightItem
        
        //        var result = SearchResultsTableViewController()
        //        searchController = UISearchController(searchResultsController: result)
        //        searchController.searchResultsUpdater = result
        ////        self.searchController.
        //////        self.searchController.dimsBackgroundDuringPresentation = false
        //////        self.searchController.active = true
        //        self.searchController.hidesNavigationBarDuringPresentation = false
        //
//        searchBar = UISearchBar()
//        searchBar.placeholder = "请输入基金代码"
//        searchBar.searchBarStyle = UISearchBarStyle.Minimal
//        searchBar.translucent = true //是否透视效果
//        var topView: UIView = searchBar.subviews[0] as! UIView
//        topView.userInteractionEnabled = false
//        
//        var ti:UITextField = topView.subviews[1] as! UITextField
//        //        ti.backgroundColor = UIColor.blackColor()
//        //        ti.text = "AAAA"
//        ti.borderStyle = UITextBorderStyle.None //边框样式
//        ti.backgroundColor = UIColor.whiteColor()
//        ti.layer.cornerRadius = 4.5
        
        //        var subView:UIView = UIView()
        //        view.addSubview(subView)
        //
        //        var label:UILabel = UILabel()
        //        label.text = "嘿嘿"
        //        label.font = UIFont.systemFontOfSize(20)//20号
        //        label.sizeToFit()
        //        subView.addSubview(label)
        //
        //        label.snp_makeConstraints { (make) -> Void in
        //            make.center.equalTo(subView)
        //        }
        //
        //        subView.snp_makeConstraints { (make) -> Void in
        //            make.width.equalTo(label).offset(20)
        //            make.height.equalTo(label).offset(10)
        //        }
        ////        subView.backgroundColor = UIColor.clearColor()
        //        subView.layer.borderColor = UIColor.grayColor().CGColor
        //        subView.layer.borderWidth = 1
        //        subView.layer.cornerRadius = 5
//        var atap = UITapGestureRecognizer(target: self, action: "searchBarTap:")
//        atap.numberOfTapsRequired = 1//单击
//        searchBar.addGestureRecognizer(atap)
        
        self.tabBarController?.navigationItem.titleView = searchBar
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        initTitleArea()
        
        if hasSetUp {
            self.refreshContaner.scrollerView.contentOffset.y = 0
        }
    }
    
    private var hasSetUp:Bool = false
    private func setupRefresh(){
        self.refreshContaner.addHeaderWithCallback(RefreshHeaderView.header(),callback: {
            let delayInSeconds:Int64 =  1000000000  * 1
            
            let popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.hasSetUp = true
//                self.refreshAll = false
                self.dataSource.removeAllObjects()
                let homeDataSource = DataRemoteFacade.homeDataSource
                for i in 0..<homeDataSource.count{
                    self.dataSource.addObject(homeDataSource[i])
                }
                self.tableView.reloadData()
                self.refreshContaner.headerReset()
            })
        })
        
//        self.refreshContaner.addFooterWithCallback(RefreshFooterView.footer(),callback: {
//            let delayInSeconds:Int64 = 1000000000 * 1
//            var popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
//            dispatch_after(popTime, dispatch_get_main_queue(), {
////                self.footerPullCount++
//                if false {
////                    for (var i:Int = 0; i<10; i++) {
////                        var text:String = "内容"+String( arc4random_uniform(10000))
////                        self.fakeData!.addObject(text)
////                    }
//                    self.tableView.reloadData()
//                    self.refreshContaner.footerReset()
//                    //                    self.tableView.setFooterHidden(true) //再也不会显示
//                }else{
//                    self.tableView.reloadData()
//                    self.refreshContaner.footerNodata()
//                }
//            })
//        })
    }
    func pushView(nc:NSNotification){
        let nextController = nc.object as! UIViewController
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pushView:", name: "Home:pushView",object:nil)
        
        super.viewDidLoad()
        
//        initTitleArea()
        //        self.title = "欢迎来到主页"
        //        var someDic:NSDictionary = NSDictionary(objectsAndKeys: UIColor.whiteColor(),NSForegroundColorAttributeName)
        //        self.navigationController?.navigationBar.titleTextAttributes = someDic as [NSObject : AnyObject]
        
        self.view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        //        tableView.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        
        self.setupRefresh()
        self.refreshContaner.headerBeginRefreshing()
        
//        searchBar.showsCancelButton = true
//        searchBar.becomeFirstResponder()//直接获得焦点
////        searchBar.translucent = false //是否透视效果
////        searchBar.showsScopeBar = true//显示选择栏
//        
//        var cancelButton: UIButton?
//        var topView: UIView = searchBar.subviews[0] as! UIView
//        for view in topView.subviews  {
//            if view.isKindOfClass(NSClassFromString("UINavigationButton")){
//                cancelButton =  view as? UIButton
//            }
//        }
//        
//        if (cancelButton != nil) {
//            cancelButton?.setTitle("取消", forState: UIControlState.Normal)
//            cancelButton?.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        }
//        
//        searchBar.frame.origin.y = 60
//        searchController = UISearchDisplayController(searchBar: searchBar, contentsController: self)
//        searchController.displaysSearchBarInNavigationBar = true
//        self.view.addSubview(searchBar)
        
//        searchBar.sizeToFit()
        
//        tableView.tableHeaderView = searchBar
//        definesPresentationContext = true //非常重要
        
//        searchBar.snp_makeConstraints { (make) -> Void in
//            make.left.right.equalTo(self.view)
//            make.height.equalTo(30)
//        }
        
//        refreshContaner.snp_makeConstraints { (make) -> Void in
//            make.top.equalTo(self.view).offset(150)
//        }
        
//        var searchBar = searchController.searchBar
//        //            searchBar.prompt = "请关注下面APP，各大市场均有下载" //提示副标题
//        searchBar.placeholder = "请输入基金名称" //提示文字
//        searchBar.sizeToFit()
//        self.tableView.tableHeaderView = searchBar
        
//        println(self.view.frame)
//        initScrollView()
        // Do any additional setup after loading the view.
    }

    func searchBarTap(target:AnyObject){
//        println("点击searchBar")
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
//        self.presentViewController(SearchViewController(), animated: true) { () -> Void in
//            
//        }
    }
    
    var searchController:UISearchController!//UISearchDisplayController!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section
//        var row = indexPath.row
        let source = dataSource[section] as! SourceVo
        let cell:CellVo = source.data![indexPath.row] as! CellVo
        if cell.cellData is HotItemVo{
            //点击hot内容跳转
            let hvo = cell.cellData as! HotItemVo
            if hvo.rate != nil{
                let dvo:InfoFundVo? = DataRemoteFacade.getDetailsById(hvo.classId)
                if dvo != nil{
//                    println("点击hot内容跳转")
                    let dc:DetailsPageController = DetailsPageController()
                    dc.pageData = dvo!
//                    dc.hidesBottomBarWhenPushed = true
                    self.tabBarController?.tabBar.hidden = true
                    self.navigationController?.pushViewController(dc, animated: true)
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = super.tableView(tableView, viewForHeaderInSection: section)
        if header is HomePageSearchBarHeader{
//            var sc = UISearchDisplayController(searchBar: <#UISearchBar!#>, contentsController: <#UIViewController!#>)
            (header as! HomePageSearchBarHeader).contentsController = self
        }
        return header
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
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
