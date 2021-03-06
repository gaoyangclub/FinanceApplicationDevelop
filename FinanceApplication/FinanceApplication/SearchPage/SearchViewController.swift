//
//  SearchViewController.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/11/7.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit
import CoreLibrary

class SearchViewController: UITableViewController,UISearchBarDelegate {

    private var searchBar:UISearchBar!;
    private var cancelButton:UIButton!;
    
    lazy private var rightItem:UIBarButtonItem = UIBarButtonItem(title: "取消", style: UIBarButtonItemStyle.Done, target: self, action: "doCancel")
    
    override func viewWillAppear(animated: Bool) {
    
        if !hasObserver{
            tableView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New, context: nil)
            hasObserver = true
        }
//        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let leftItem = //UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "cancelClick")
//        UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Done, target: self, action: nil)
//        self.navigationItem.leftBarButtonItem = leftItem
        
        
        self.navigationItem.rightBarButtonItem = rightItem
        
//        self.navigationItem.hidesBackButton = true//直接隐藏back按钮
//        let tap = UIPanGestureRecognizer(target: self, action: "panHandler")
//        self.view.addGestureRecognizer(tap)
        
        self.navigationItem.hidesBackButton = true
        
        searchBar = UISearchBar()
        searchBar.placeholder = "请输入基金代码";
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()//直接获得焦点
        //        searchBar.translucent = false //是否透视效果
        //        searchBar.showsScopeBar = true//显示选择栏
        searchBar.sizeToFit()
        searchBar.tintColor=UIColor.blueColor()//会获取到光标
        searchBar.setShowsCancelButton(false, animated: true)
        
        let topView: UIView = searchBar.subviews[0] 
        for view in topView.subviews  {
            if view.isKindOfClass(NSClassFromString("UINavigationButton")!){
                cancelButton = view as? UIButton
//                cancelButton.hidden = true
            }
        }
        if (cancelButton != nil) {
//            cancelButton.buttonType
//            cancelButton.titleLabel?.font = UIFont.systemFontOfSize(18, weight: 2)
//            cancelButton.titleLabel?.text = "取消"
//            cancelButton.titleLabel?.sizeToFit()
            cancelButton.setTitle("取消", forState: UIControlState.Normal)
            cancelButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//            cancelButton.setTitleColor(UIColor.yellowColor(), forState: UIControlState.Selected)
        }
        cancelButton.addTarget(self, action: "doCancel", forControlEvents: UIControlEvents.TouchDown)
        
//        let searchView:UIView = UIView(frame: CGRectMake(0, 0, 100, 20))
//        searchView.addSubview(searchBar)
//        searchView.backgroundColor = UIColor.yellowColor()
        
        BatchLoaderForSwift.loadFile("empty", callBack: { (image) -> Void in
            self.searchBar.backgroundImage = image // 需要用1像素的透明图片代替背景图
        })
        
        searchBar.delegate = self
//        searchBar.barTintColor = UIColor.clearColor()
        
//        searchBar.snp_makeConstraints { (make) -> Void in
//            make.center.equalTo(searchView)
//        }
        
        self.navigationItem.titleView = searchBar
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None //去掉Cell自带线条
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()//注:在隐藏焦点的同时会自动将cancelButton.enabled=false
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        if hasObserver{
            tableView.removeObserver(self, forKeyPath: "contentOffset")
            hasObserver = false
        }
    }
    
    private var hasObserver = false
    
    func doCancel(){
        self.navigationController?.popViewControllerAnimated(true)//重新返回上一层
//        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
//    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
//        searchBar.resignFirstResponder()
//    }
    
//    func panHandler(){
//        searchBar.resignFirstResponder()//取消焦点
//    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "contentOffset" && tableView.dragging{
            searchBar.resignFirstResponder()//注:在隐藏焦点的同时会自动将cancelButton.enabled=false
//            self.searchBar.endEditing(true)
            if cancelButton != nil{
                cancelButton.enabled = true//继续可用
            }
        }
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        searchResult = DataRemoteFacade.searchFundResult(searchBar.text!)
        self.tableView.reloadData()
    }

    
//    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
//        println("搜索内容:" + searchBar.text)
//        
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private var searchResult:[InfoFundVo] = []
    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 0
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return searchResult.count
    }

    private static let cellHeight:CGFloat = 46
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return SearchViewController.cellHeight//cellHeight
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifer = "SearchFundCell"
        //cell标示符 表示一系列
        var cell:SearchFundCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifer) as? SearchFundCell
        
        if cell == nil{
            cell = SearchFundCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifer)//
//            cell = SearchFundCell()
            cell!.selectionStyle = UITableViewCellSelectionStyle.Blue//None
        }
        cell!.fundVo = searchResult[indexPath.row]
//        else{
//            println("重用SearchFundCell")
//        }
        return cell!
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: false) //反选
        
        let fundVo:InfoFundVo = searchResult[indexPath.row]
        let detailsController = DetailsPageController()
        detailsController.pageData = fundVo
        self.navigationController?.pushViewController(detailsController, animated: true)
        
//        self.dismissViewControllerAnimated(true, completion: nil)
//        let nc = NSNotification(name: "Details:pushView", object: webController)
//        NSNotificationCenter.defaultCenter().postNotification(nc)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
class SearchFundCell:UITableViewCell{
    
    var fundVo:InfoFundVo!{
        didSet{
            setNeedsLayout()
        }
    }
    
    private lazy var bottomLine:UIView = {
        let view:UIView = UIView()
        view.backgroundColor = UICreaterUtils.normalLineColor
        self.contentView.addSubview(view)
        return view
        }()
    
    private var tabItem:UILabel!
    lazy var favoriteArea:UIView = {
        let view = UIView()
        self.contentView.addSubview(view)
//        BatchLoaderForSwift.loadFile("star", callBack: { (image) -> Void in
        self.tabItem = UICreaterUtils.createLabel(UIConfig.ICON_FONT_NAME, 20, UICreaterUtils.colorFlat);
        self.tabItem.textAlignment = NSTextAlignment.Center;
            view.addSubview(self.tabItem)
//            self.tabItem.userInteractionEnabled = false
//            self.tabItem.sizeType = .FillWidth
//            self.tabItem.normalColor = UICreaterUtils.colorFlat
//            self.tabItem.selectColor = UICreaterUtils.colorRise
        self.tabItem.text = UIConfig.ICON_STAR;
            self.tabItem.snp_makeConstraints(closure: { (make) -> Void in
                make.height.equalTo(20)
                make.left.right.equalTo(view)
                make.center.equalTo(view)
            })
//        })
        return view
    }()
    
    private lazy var titleLabel:UILabel = {
        let label = UICreaterUtils.createLabel(15, UICreaterUtils.colorBlack, "", true, self.contentView)
//        label.font = UIFont.systemFontOfSize(15, weight: 1.2)
        return label
    }()
    
    private lazy var iconView:UILabel = {
        let icon = UICreaterUtils.createLabel(UIConfig.ICON_FONT_NAME,26,UICreaterUtils.colorFlat);
        icon.textAlignment = NSTextAlignment.Center;
        self.contentView.addSubview(icon);
        return icon;
    }()
    
    private lazy var kindLabel:UILabel = UICreaterUtils.createLabel(12, UICreaterUtils.colorFlat, "", true, self.contentView)
    
    override func layoutSubviews() {
        initTextView()
    }
    
    private func initTextView(){
        
        bottomLine.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(self.contentView)
            make.height.equalTo(UICreaterUtils.normalLineWidth)
        }
        
        favoriteArea.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(36)
            make.left.top.bottom.equalTo(self.contentView)
        }
        tabItem.textColor = fundVo.isFollow ? UICreaterUtils.colorRise : UICreaterUtils.colorFlat;
        
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(favoriteArea.snp_right)
            make.right.equalTo(-46)
            make.bottom.equalTo(self.contentView.snp_centerY).offset(-2)
        }
        titleLabel.text = fundVo.code + "    " + fundVo.title
        titleLabel.sizeToFit()
        
        kindLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(favoriteArea.snp_right)
            make.top.equalTo(self.contentView.snp_centerY).offset(2)
        }
        
        let nowDate = NSDate()
        
        let fmt = NSDateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        let nowDateStr = fmt.stringFromDate(nowDate)
        let fundDateStr = fmt.stringFromDate(fundVo.updateTime)
        
//        var imageUrl = "";
        if nowDateStr == fundDateStr{
            iconView.text = UIConfig.ICON_HUO_BAO;
//            imageUrl = "fire"
            iconView.textColor = UICreaterUtils.colorRise
        }else{
            iconView.text = UIConfig.ICON_DENG_DAI;
//            imageUrl = "backup"
            iconView.textColor = UICreaterUtils.colorFlat
        }
        
        self.iconView.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(self.contentView)
//            make.size.equalTo(CGSize(width: 48, height: 24))
            make.width.equalTo(48)
            make.height.equalTo(26)
            make.centerY.equalTo(self.contentView)
        }
        
//        BatchLoaderForSwift.loadFile(imageUrl, callBack: { (image) -> Void in
//            self.iconView.image = image
//        })
        
        kindLabel.text = DataRemoteFacade.getFundHeaderTitle(fundVo.kind)
        kindLabel.sizeToFit()
    }
    
    
    
}