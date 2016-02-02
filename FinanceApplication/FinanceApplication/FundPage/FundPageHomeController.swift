//
//  FundPageController.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/12/16.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class FundPageHomeController:BaseTableViewController,DetailsPageCellDelegate{
    
//    lazy var topArea:UIView = {
//        let view = UIView()
//        let normalColor:UIColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
//        view.backgroundColor = normalColor
//        self.view.addSubview(view)
//        view.snp_makeConstraints(closure: { (make) -> Void in
//            make.top.left.right.equalTo(self.view)
//            make.height.equalTo(30)
//        })
//        return view
//        }()
//    
//    lazy var netButton:UIButton = {
//        let btn = UIButton.buttonWithType(UIButtonType.InfoLight) as! UIButton
//        let title:NSString = "单位净值"
//        let normalColor:UIColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
//        btn.backgroundColor = normalColor
//        btn.setTitle(title as? String, forState: UIControlState.Normal)
//        btn.setTitleColor(UICreaterUtils.colorBlack, forState: UIControlState.Normal)
//        //        btn.setTitleColor(UICreaterUtils.colorFlat, forState: UIControlState.Highlighted)
//        self.topArea.addSubview(btn)
//        return btn
//        }()//self.createFilterButton("单位净值")
//    
//        override func refreshContanerMake(make:ConstraintMaker)-> Void{
//            make.left.right.bottom.equalTo(self.view)
//            make.top.equalTo(topArea.snp_bottom)
//        }
    
    lazy private var searchBar:UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "请输入基金代码"

        BatchLoaderUtil.loadFile("empty", callBack: { (image, params) -> Void in
            bar.backgroundImage = image // 需要用1像素的透明图片代替背景图 不然动画交互的时候会坑爹的闪现灰底
        })
        
        var topView: UIView = bar.subviews[0] 
        topView.userInteractionEnabled = false
        
        var atap = UITapGestureRecognizer(target: self, action: "searchBarTap:")
        atap.numberOfTapsRequired = 1//单击
        bar.addGestureRecognizer(atap)
        
        return bar
        }()
    
    private var hasSetUp:Bool = false
    func setupRefresh(){
        self.refreshContaner.addHeaderWithCallback(RefreshHeaderView.header(),callback: {
            let delayInSeconds:Int64 =  100000000  * 5
            
            let popTime:dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue(), {
                self.hasSetUp = true
                
                self.dataSource.removeAllObjects()
                let fundPageSource = self.getFundHomeSource()
                for i in 0..<fundPageSource.count{
                    self.dataSource.addObject(fundPageSource[i])
                }
                self.tableView.reloadData()
                self.refreshContaner.headerReset()
            })
        })
    }
    
    private func getFundHomeSource()->NSMutableArray{
        let svo = SoueceVo(data: [
            CellVo(cellHeight: FundPageHomeHotCell.cellHeight, cellClass: FundPageHomeHotCell.self)
            ])
        let fundHomeTitleList:[InfoFundHeader] = DataRemoteFacade.getFundHomeTitleList()
        for fvo in fundHomeTitleList{
            svo.data?.addObject(CellVo(cellHeight: FundPageHomeInfoCell.cellHeight, cellClass: FundPageHomeInfoCell.self,cellData:fvo))
        }
        return [svo]
    }
    
    func pushView(nc:NSNotification){
        let nextController = nc.object as! UIViewController
        self.navigationController?.pushViewController(nextController, animated: true)
    }
    
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pushView:", name: "FundHome:pushView",object:nil)
        
        super.viewDidLoad()
        
//        netButton.snp_makeConstraints { (make) -> Void in
//            make.left.right.top.bottom.equalTo(self.topArea)
//        }
        
        self.view.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        
        self.setupRefresh()
        self.refreshContaner.headerBeginRefreshing()
    }
    
    private func initTitleArea(){
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        self.tabBarController?.navigationItem.titleView = searchBar
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        initTitleArea()
        
        if hasSetUp {
            self.refreshContaner.scrollerView.contentOffset.y = 0
        }
    }
    
    func searchBarTap(target:AnyObject){
        self.navigationController?.pushViewController(SearchViewController(), animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section
//        var row = indexPath.row
        let source = dataSource[section] as! SoueceVo
        let cell:CellVo = source.data![indexPath.row] as! CellVo
        if cell.cellData is InfoFundHeader{
            //点击hot内容跳转
            let fvo = cell.cellData as! InfoFundHeader //点击到Fund详细页
//            println("点击跳转:" + fvo.title)
            let pageKindController = FundPageKindConrtoller()
            pageKindController.selectedIndex = fvo.kind
            
//             let drawerController = FundPageDrawerController(centerViewController: pageKindController, rightDrawerViewController: AViewController())
            
            self.navigationController?.pushViewController(pageKindController, animated: true)
        }
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
