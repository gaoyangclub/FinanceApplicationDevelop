//
//  BaseTableViewController.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/11/1.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class BaseTableViewController: RefreshTableViewController {

    var refreshAll:Bool = true
    var dataSource:NSMutableArray=[]//二维数组 [section][index]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //种类个数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var source = dataSource[section] as! SoueceVo
        return source.headerHeight
    }
    
    private lazy var nsSectionDic:Dictionary<Int,BaseItemRenderer> = [:]
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var source = dataSource[section] as! SoueceVo
        var headerClass = source.headerClass
        var headerView = nsSectionDic[section]
        if headerView == nil{
            if(headerClass != nil){
                headerView = headerClass!()
                nsSectionDic.updateValue(headerView!, forKey: section)
            }
        }
        headerView!.itemIndex = section
        headerView!.data = source.headerData
        return headerView
    }
    
    //每个Cell高度
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var section = indexPath.section
        var source = dataSource[section] as! SoueceVo
        var cell:CellVo = source.data![indexPath.row] as! CellVo
        return cell.cellHeight//source.sourceHeight
    }
    
    //种类对应条目个数
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        var source = dataSource[section] as! SoueceVo
        return source.data?.count ?? 0
        //tableView.numberOfRowsInSection(section)
    }
    var useCellIdentifer:Bool = true
    //创建条目
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var section = indexPath.section
        var row = indexPath.row
        var source = dataSource[section] as! SoueceVo
        var cellVo:CellVo = source.data![row] as! CellVo//获取的数据给cell显示
        var cellClass = cellVo.cellClass
        
        var cell:BaseTableViewCell?
        var isCreate:Bool = false
        if useCellIdentifer {
            var cellIdentifer:String!
            var classString:String = NSStringFromClass(cellClass)
            if cellVo.isUnique {//唯一
                cellIdentifer = classString + "_\(section)_\(row)"
            }else{
                cellIdentifer = classString
            }
            //        println("className:" + className)
            cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifer) as? BaseTableViewCell
            if cell == nil{
                cell = cellClass(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifer)
                isCreate = true
            }
        }else{
            cell = cellClass()
            isCreate = true
        }
//        else{
//            println("重用cell 类型:" + cellIdentifer)
//        }
        if isCreate{ //创建阶段设置
            cell!.selectionStyle = UITableViewCellSelectionStyle.None
            cell!.backgroundColor = UIColor.clearColor()//无色
        }
        if !refreshAll && !isCreate{//上啦刷新且非创建阶段
            cell?.needRefresh = false //不需要刷新
            return cell! //直接返回无需设置
        }else{
            cell?.needRefresh = true //需要刷新
        }
        var data: Any? = cellVo.cellData
        cell!.isFirst = cellVo.cellTag == 1//row == 0
        if source.data != nil{
            cell!.isLast = cellVo.cellTag == 2//row == source.data!.count - 1//索引在最后
        }
        cell!.data = data
        cell!.indexPath = indexPath
        return cell!//tableView.cellForRowAtIndexPath(indexPath)!
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
