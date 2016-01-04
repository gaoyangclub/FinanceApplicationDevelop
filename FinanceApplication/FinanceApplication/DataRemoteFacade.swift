

//
//  DataRemoteFacade.swift
//  FinanceApplicationTest
//
//  Created by 高扬 on 15/10/31.
//  Copyright (c) 2015年 高扬. All rights reserved.
//

import UIKit

class DataRemoteFacade: NSObject {
   
    static var homeDataSource:NSMutableArray = [
        SoueceVo(data: [
            CellVo(cellHeight: 180, cellClass: HomePageBannerCell.self, cellData: "banner.jpg",isUnique:true)
            ]),
        SoueceVo(data: [
            CellVo(cellHeight: 36, cellClass: HomePageHotHeader.self, cellData: "投资热点"),
            CellVo(cellHeight: 64, cellClass: HomePageHotItemCell.self, cellData: HotItemVo(classId:1,title: "医疗健康", content: "攒钱养老，不如投资医疗!"),cellTag: 1),
            CellVo(cellHeight: 64, cellClass: HomePageHotItemCell.self, cellData: HotItemVo(classId:2,title: "国泰医药行业指数分级", content: "采用指数投资，掘金医药长牛!",rate: "36.05%",rateTitle: "今年收益")),
            CellVo(cellHeight: 64, cellClass: HomePageHotItemCell.self, cellData: HotItemVo(classId:3,title: "华夏医疗健康混合A", content: "清华博士力作，业绩同类拔尖!",rate: "12.41%",rateTitle: "月收益")),
            CellVo(cellHeight: 64, cellClass: HomePageHotItemCell.self, cellData: HotItemVo(classId:4,title: "中海医药精选灵活配置A", content: "埋首研医十余载，擅抓行业机遇!",rate: "13.30%",rateTitle: "今年收益"),cellTag: 2),
            CellVo(cellHeight: 36, cellClass: HomePageHotHeader.self, cellData: "投资热点"),
            CellVo(cellHeight: 64, cellClass: HomePageHotItemCell.self, cellData: HotItemVo(classId:5,title: "国企改革", content: "政府大力支持，板块蓄力腾飞!"),cellTag: 1),
            CellVo(cellHeight: 64, cellClass: HomePageHotItemCell.self, cellData: HotItemVo(classId:6,title: "易方达国企改革指数分级", content: "2015年下半年重大投资机遇!",rate: "12.38%",rateTitle: "月收益")),
            CellVo(cellHeight: 64, cellClass: HomePageHotItemCell.self, cellData: HotItemVo(classId:7,title: "光大国企改革主题股票", content: "火力全开，全力布局!",rate: "15.02%",rateTitle: "月收益")),
            CellVo(cellHeight: 64, cellClass: HomePageHotItemCell.self, cellData: HotItemVo(classId:8,title: "博时国企改革主题股票", content: "深耕细作，潜力巨大!",rate: "14.47%",rateTitle: "月收益"),cellTag: 2),
            CellVo(cellHeight: 64, cellClass: HomePageFooterCell.self, cellData: "证监会核准第三方销售机构")
            ])
        //,headerHeight: 36,headerClass: HomePageSearchBarHeader.self,headerData: ""
    ]
    
    private static let detailsDataList:NSMutableArray = [
        InfoFundHeader(kind:0,title: "开放式", iconUrl:"fundTag01", fundList: [
            InfoFundVo(id: 2, kind:0,title:"国泰医药行业指数分级",shortTitle:"国泰医药",code:"690009",rateDay: 0.0217, rateQuarter: 0.2142,updateTime: NSDate(), netValue: 1.7400, rank: "16/1089",
                discount:0.4,buyRateCurrent:0.006,enoughTag:1,stars:4,isFollow:false),
            ]),
        InfoFundHeader(kind:1,title: "股票式", iconUrl:"fundTag02", fundList: [
            InfoFundVo(id: 7, kind:1,title:"光大国企改革主题股票",shortTitle:"光大主题",code:"001047",rateDay: -0.0573, rateQuarter: -0.0715, updateTime: NSDate(), netValue: 0.9870, rank: "218/421", discount:0.4,buyRateCurrent:0.007),
            InfoFundVo(id: 8, kind:1,title:"博时国企改革主题股票",shortTitle:"博时主题",code:"001277",rateDay: 0.0620, rateQuarter: -0.039, updateTime: NSDate(), netValue: 0.8380, rank: "131/421", discount:0.4,buyRateCurrent:0.006,enoughTag:1,stars:1),
            InfoFundVo(id: 9, kind:1,title:"博时国企改革主题股票2",shortTitle:"博时主题2",code:"001279",rateDay: 0.1620, rateQuarter: 0.139, updateTime: NSDate(), netValue: 0.9380, rank: "156/411", discount:0.7,buyRateCurrent:0.016,enoughTag:2,stars:3),
            InfoFundVo(id: 10, kind:1,title:"华夏领先股票",shortTitle:"华夏领先",code:"001042",rateDay: 0.0174, rateQuarter: 0.4021, updateTime: NSDate(), netValue: 0.9330, rank: "20/196", discount:0.4,buyRateCurrent:0.016),
            InfoFundVo(id: 11, kind:1,title:"大摩品质生活精选股票",shortTitle:"大摩品质",code:"000309",rateDay: 0.0163, rateQuarter: 0.3738, updateTime: NSDate(), netValue: 1.6810, rank: "29/196", discount:0.4,buyRateCurrent:0.006),
            InfoFundVo(id: 12, kind:1,title:"南方国策动力股票",shortTitle:"南方国策",code:"001692",rateDay: 0.01631, rateQuarter: 0.3056, updateTime: NSDate(), netValue: 1.2640, rank: "66/196", discount:0.4,buyRateCurrent:0.006)
            ]),
        InfoFundHeader(kind:2,title: "债券型", iconUrl:"fundTag03", fundList: [
            InfoFundVo(id: 13, kind:1,title:"华泰铂锐稳本增利债券A",shortTitle:"华泰增利A",code:"519519",rateDay: 0.0077, rateQuarter: 0.0657, updateTime: NSDate(), netValue: 1.1505, rank: "67/787", discount:0.75,buyRateCurrent:0.006,enoughTag:1,stars:2),
            InfoFundVo(id: 13, kind:1,title:"华泰铂锐稳本增利债券B",shortTitle:"华泰增利B",code:"460003",rateDay: 0.0076, rateQuarter: 0.065, updateTime: NSDate(), netValue: 1.1208, rank: "68/784", discount:0.75,buyRateCurrent:0.006,enoughTag:1),
            InfoFundVo(id: 14, kind:1,title:"海富通稳固收益债券",shortTitle:"海富稳固",code:"519030",rateDay: -0.0030, rateQuarter: 0.0551, updateTime: NSDate(), netValue: 1.6620, rank: "91/784", discount:0.6,buyRateCurrent:0.006,enoughTag:1,stars:4),
            InfoFundVo(id: 15, kind:1,title:"信达澳银稳定增利债券",shortTitle:"信达增利",code:"166105",rateDay: -0.0030, rateQuarter: 0.0073, updateTime: NSDate(), netValue: 0.9970, rank: "707/784", discount:0.6,buyRateCurrent:0.006)
            ]),
        InfoFundHeader(kind:3,title: "混合型", iconUrl:"fundTag04", fundList: [
            InfoFundVo(id: 4, kind:3,title:"中海医药精选灵活配置A",shortTitle:"中海医药",code:"000878",rateDay: 0.00, rateQuarter: 0.2142, updateTime: NSDate(), netValue: 1.1880, rank: "1126/1150", discount:0.4,buyRateCurrent:0.006),
            InfoFundVo(id: 6, kind:3,title:"易方达国企改革指数分级",shortTitle:"易方达指数",code:"502008",rateDay: 0.0370, rateQuarter: 0.2142, updateTime: NSDate(), netValue: 1.2786, rank: "513/520", discount:0.4,buyRateCurrent:0.006,enoughTag:1,stars:3),
            InfoFundVo(id: 16, kind:3,title:"景顺长城能源基建混合",shortTitle:"景顺能源",code:"260112",rateDay: -0.0340, rateQuarter: 0.0607, updateTime: NSDate(), netValue: 2.0650, rank: "789/1118", discount:0.4,buyRateCurrent:0.006,enoughTag:1)
            ]),
        InfoFundHeader(kind:4,title: "货币基金", iconUrl:"fundTag05", fundList: [
            InfoFundVo(id: 16, kind:3,title:"华商现金增利货币A",shortTitle:"华商货币A",code:"630012",rateDay: 0.0146, rateQuarter: 0.0317, updateTime: NSDate(), netValue:0.3356, rank: "271/315", discount:0.4,buyRateCurrent:0.006,enoughTag:1)
            ]),
        InfoFundHeader(kind:5,title: "短期理财", iconUrl:"fundTag06", fundList: [
            InfoFundVo(id: 16, kind:3,title:"融通七天债A",shortTitle:"融通七天理财债券A",code:"161622",rateDay: 0.0071, rateQuarter: 0.0107, updateTime: NSDate(), netValue:0.1879, rank: "103/210", discount:0.4,buyRateCurrent:0.006,enoughTag:1)
            ]),
        InfoFundHeader(kind:6,title: "指数型", iconUrl:"fundTag07", fundList: [
            InfoFundVo(id: 16, kind:3,title:"易方达银行指数分级",shortTitle:"易方达银行",code:"161622",rateDay: -0.0081, rateQuarter: 0.1161, updateTime: NSDate(), netValue:0.8716, rank: "298/367", discount:0.4,buyRateCurrent:0.006,enoughTag:1)
            ]),
        InfoFundHeader(kind:7,title: "保本型", iconUrl:"fundTag08", fundList: [
            InfoFundVo(id: 16, kind:3,title:"长城保本混合",shortTitle:"长城保本",code:"161622",rateDay: -0.010, rateQuarter: 0.0070, updateTime: NSDate(), netValue:1.0070, rank: "61/67", discount:0.5,buyRateCurrent:0.006,enoughTag:1,stars:3)
            ]),
        InfoFundHeader(kind:8,title: "QDII", iconUrl:"fundTag10", fundList: [
            InfoFundVo(id: 16, kind:3,title:"易方达恒生ETF链接",shortTitle:"H股ETF链接",code:"110031",rateDay: -0.016, rateQuarter: 0.0006, updateTime: NSDate(), netValue:0.9705, rank: "72/117", discount:0.5,buyRateCurrent:0.006,enoughTag:1,stars:2)
            ]),
        InfoFundHeader(kind:9,title: "创新型", iconUrl:"fundTag11", fundList: [
            InfoFundVo(id: 3, kind:9,title:"华夏医疗健康混合A",shortTitle:"华夏医疗",code:"000945",rateDay: -0.0234, rateQuarter: 0.0028, updateTime: NSDate(), netValue: 1.4180, rank: "347/1150", discount:0.6,buyRateCurrent:0.005),
            ])
    ]
    
    //随机3天内每组自定义FundVo
    private static var todayFundList:NSMutableArray = {
        let today = NSDate()
        let timeGap:Double = 24 * 3600 //间隔1天
        var fundAllList:NSMutableArray = []
        for i in 0..<detailsDataList.count{
            let header:InfoFundHeader = detailsDataList[i] as! InfoFundHeader
            var todayList:NSMutableArray = []
            let todayHeader = InfoFundHeader(kind:i ,title: header.title, iconUrl:header.iconUrl ,fundList: todayList)
            fundAllList.addObject(todayHeader)
            
            if header.fundList.count == 0{
                continue //不需要再次存入
            }
            let dayCount = arc4random_uniform(3) + 2
            for j in 0..<dayCount{
                let day = NSDate(timeInterval: -timeGap * Double(j), sinceDate: today)
                let fundCount = arc4random_uniform(12) + 5
                for k in 0..<fundCount{
                    let randomIndex = arc4random_uniform(UInt32(header.fundList.count))
                    let targetFund = header.fundList[Int(randomIndex)] as! InfoFundVo
                    let todayFund = targetFund.copy() as! InfoFundVo
                    todayFund.kind = i
                    todayFund.updateTime = day
                    todayList.addObject(todayFund)
                }
            }
        }
        return fundAllList
    }()
    
    static func searchFundResult(name:String)->[InfoFundVo]{
        var result:[InfoFundVo] = []
        for headObj in todayFundList{
            let header:InfoFundHeader = headObj as! InfoFundHeader
            for fObj in header.fundList{
                let fvo = fObj as! InfoFundVo
                if (fvo.title.rangeOfString(name) != nil){ //是否存在这个名称
                    result.append(fvo)
                }
            }
        }
        return result
    }
    
    static func getFundHomeTitleList()->[InfoFundHeader]{
        var result:[InfoFundHeader] = []
        for headObj in todayFundList{
            let header:InfoFundHeader = headObj as! InfoFundHeader
            var deputyFundVo:InfoFundVo?
            for fObj in header.fundList{
                let fvo = fObj as! InfoFundVo
                if deputyFundVo == nil || deputyFundVo!.rateQuarter < fvo.rateQuarter{
                    deputyFundVo = fvo
                }
            }
            header.deputyFundVo = deputyFundVo
            result.append(header)
        }
        return result
    }
    
    static func getDetailsById(id:Int)->InfoFundVo?{
        for header in detailsDataList{
            var infoHeader = header as! InfoFundHeader
            for obj in infoHeader.fundList{
                var dvo:InfoFundVo = obj as! InfoFundVo
                if dvo.id == id{
                    return dvo
                }
            }
        }
        return nil
    }
    
    static func getFundHeaderTitle(kind:Int)->String{
        return (detailsDataList[kind] as! InfoFundHeader).title
    }
    
    static func getFundFilterResult(kind:Int,startIndex:Int,keyNameKind:String = "rateDay",order:Bool = true,count:Int = 10)->NSMutableArray{
        var header = todayFundList[kind] as! InfoFundHeader
        
        //1.分组
        var fundDic:Dictionary<String,NSMutableArray> = [:]
        var df:NSDateFormatter = NSDateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        for fund in header.fundList{
            var fvo = fund as! InfoFundVo
            let timeKey = df.stringFromDate(fvo.updateTime)
            var fArr:NSMutableArray? = fundDic[timeKey]
            if fArr == nil{
                fArr = []
                fundDic.updateValue(fArr!,forKey:timeKey)
            }
            fArr?.addObject(fvo)
        }
        var sortedKeysAndValues = sorted(fundDic) {
            var date1:NSDate = df.dateFromString($0.0)!
            var date2:NSDate = df.dateFromString($1.0)!
            if date1.compare(date2) == .OrderedDescending{
                return true
            }
            return false
        }
//        //2.遍历后排序
//        for i in 0..<sortedKeysAndValues.count{
//            let a = sortedKeysAndValues[i].1 as! NSMutableArray
//            let sortedArr = sorted(a){
//                var fund1:InfoFundVo = $0 as! InfoFundVo
//                var fund2:InfoFundVo = $1 as! InfoFundVo
//                var value1:Float
//                var value2:Float
//                if keyNameKind == 0{
//                    value1 = fund1.netValue
//                    value2 = fund2.netValue
//                }else{
//                    value1 = fund1.rateDay
//                    value2 = fund2.rateDay
//                }
//                return order ? value1 > value2 : value1 < value2
//            }
//            sortedKeysAndValues[i] = (sortedKeysAndValues[i].0,sortedArr)
//            var temp:[Float] = []
//            if startIndex == 0{
//                for obj in sortedArr{
//                    var fund:InfoFundVo = obj as! InfoFundVo
//                    temp.append(fund.rateDay)
//                }
//                println("timeKey:\(sortedKeysAndValues[i].0) list:\(temp)")
//            }
//        }
        //2.遍历后排序
        for (timeKey,fArr) in sortedKeysAndValues{
            fArr.sortUsingComparator({ (obj1, obj2) -> NSComparisonResult in
                var fund1:InfoFundVo = obj1 as! InfoFundVo
                var fund2:InfoFundVo = obj2 as! InfoFundVo
//                var value1:Float
//                var value2:Float
//                if keyNameKind == 0{
//                    value1 = fund1.valueForKey("netValue") as! Float//fund1.netValue
//                    value2 = fund2.valueForKey("netValue") as! Float//fund2.netValue
//                }else{
//                    value1 = fund1.valueForKey("rateDay") as! Float//fund1.rateDay
//                    value2 = fund2.valueForKey("rateDay") as! Float//fund2.rateDay
//                }
                let value1 = fund1.valueForKey(keyNameKind) as! Float
                let value2 = fund2.valueForKey(keyNameKind) as! Float
                if order && value1 < value2 || !order && value1 > value2{
                    return NSComparisonResult.OrderedDescending
                }else if order && value1 > value2 || !order && value1 < value2{
                    return NSComparisonResult.OrderedAscending
                }else{
                    return NSComparisonResult.OrderedSame
                }
            })
        }
        
        //3.按次序获取数据并返回
        var list:NSMutableArray = []
        var endIndex = startIndex + count
        var index = 0
        var fheader:FilterFundHeader!

out:    for (timeKey,fArr) in sortedKeysAndValues{
//            let sortedArr = fArr as! [AnyObject]
            for fund in fArr{
                if index > endIndex{//已经结束
                    break out
                }
                if index >= startIndex{//开始
                    let fvo = fund as! InfoFundVo
                    if fheader == nil || fheader.timeKey != timeKey{//日期变化
                        fheader = FilterFundHeader(kind: kind, timeKey: timeKey, fundList: [])
                        list.addObject(fheader)
                    }
                    fheader.fundList.addObject(fvo)
                }
                index++
            }
        }
        return list //直到结束为止
    }
    
    private static var summarysDataList:NSMutableArray = [
        InfoSummaryVo(classId: 2, manager: "朱晓亮", company: "汇添富基金管理股份有限公司", kind: "混合型", money: "26.99亿元", time: "2015-09-30"),
        InfoSummaryVo(classId: 3, manager: "天才", company: "汇添富基金管理股份有限公司", kind: "股票型", money: "10.13亿元", time: "2015-10-10")
    ]

    static func getSummarysById(id:Int)->InfoSummaryVo?{
        for obj in summarysDataList{
            var ivo:InfoSummaryVo = obj as! InfoSummaryVo
            if ivo.classId == id{
                return ivo
            }
        }
        return summarysDataList[0] as? InfoSummaryVo
    }
    
    private static var stocksDataList:NSMutableArray = [
        InfoStockVo(title: "怡亚通", code: "002183", positionRatio: 0.1399, rateDay: -0.0307),
        InfoStockVo(title: "宋城演义", code: "300144", positionRatio: 0.0862, rateDay: -0.0072),
        InfoStockVo(title: "瑞茂通", code: "600180", positionRatio: 0.0454, rateDay: -0.0414),
        InfoStockVo(title: "黄河旋风", code: "600172", positionRatio: 0.0404, rateDay: -0.0117),
        InfoStockVo(title: "全通教育", code: "300359", positionRatio: 0.0523, rateDay: -0.0437),
        InfoStockVo(title: "华信国际", code: "002018", positionRatio: 0.0722, rateDay: 0.0),
        InfoStockVo(title: "新南洋", code: "600661", positionRatio: 0.0622, rateDay: -0.0246),
        InfoStockVo(title: "先导股份", code: "300450", positionRatio: 0.0287, rateDay: 0.0535),
        InfoStockVo(title: "迪安诊断", code: "300244", positionRatio: 0.0452, rateDay: 0.0317),
        InfoStockVo(title: "达安基因", code: "002030", positionRatio: 0.0331, rateDay: -0.0170),
        InfoStockVo(title: "恒瑞医药", code: "600276", positionRatio: 0.0668, rateDay: -0.0038),
        InfoStockVo(title: "京新药业", code: "002020", positionRatio: 0.0288, rateDay: -0.0042),
        InfoStockVo(title: "嘉事堂", code: "002462", positionRatio: 0.0439, rateDay: -0.0058),
        InfoStockVo(title: "华东医药", code: "000963", positionRatio: 0.0274, rateDay: 0.0413),
        InfoStockVo(title: "通化东宝", code: "600867", positionRatio: 0.0391, rateDay: -0.0112),
        InfoStockVo(title: "香雪制药", code: "300147", positionRatio: 0.0236, rateDay: -0.0096),
        InfoStockVo(title: "爱尔眼科", code: "300015", positionRatio: 0.0346, rateDay: -0.0200),
        InfoStockVo(title: "东土科技", code: "300353", positionRatio: 0.1128, rateDay: -0.0486),
        InfoStockVo(title: "同有科技", code: "300302", positionRatio: 0.0441, rateDay: -0.0113),
        InfoStockVo(title: "启明星辰", code: "002439", positionRatio: 0.0344, rateDay: 0.0088),
        InfoStockVo(title: "海格通信", code: "002465", positionRatio: 0.0223, rateDay: -0.0292),
        InfoStockVo(title: "利亚德", code: "300296", positionRatio: 0.0513, rateDay: -0.0241),
        InfoStockVo(title: "三川股份", code: "300066", positionRatio: 0.0343, rateDay: 0.1002),
        InfoStockVo(title: "中直股份", code: "600038", positionRatio: 0.0215, rateDay: 0.0090),
        InfoStockVo(title: "威海广泰", code: "002111", positionRatio: 0.0534, rateDay: 0.0010),
        InfoStockVo(title: "川大智胜", code: "002253", positionRatio: 0.0273, rateDay: -0.0345),
        InfoStockVo(title: "伊利股份", code: "600887", positionRatio: 0.0399, rateDay: -0.0020),
        InfoStockVo(title: "15国开02", code: "150202", positionRatio: 0.0191, rateDay: 0.0,kind:1),
        InfoStockVo(title: "15进出11", code: "150311", positionRatio: 0.0268, rateDay: 0.0,kind:1),
        InfoStockVo(title: "歌尔转债", code: "128009", positionRatio: 0.0, rateDay: 0.0,kind:1),
        InfoStockVo(title: "12金螳01", code: "112118", positionRatio: 0.0, rateDay: 0.0,kind:1),
        InfoStockVo(title: "15农发16", code: "150416", positionRatio: 0.0403, rateDay: 0.0,kind:1),
        InfoStockVo(title: "13东吴债", code: "122288", positionRatio: 0.0481, rateDay: 0.0,kind:1),
        InfoStockVo(title: "国开1301", code: "018001", positionRatio: 0.0157, rateDay: 0.0,kind:1),
        InfoStockVo(title: "东华转债", code: "128002", positionRatio: 0.0005, rateDay: 0.0,kind:1),
        InfoStockVo(title: "15进出07", code: "150307", positionRatio: 0.0249, rateDay: 0.0,kind:1),
        InfoStockVo(title: "15国开11", code: "150211", positionRatio: 0.0349, rateDay: 0.0,kind:1)
    ]
    
    static func getStockSource()->[[InfoStockVo]]{
        var stockList:[InfoStockVo] = []
        var loanList:[InfoStockVo] = []
        var indexList:[Int] = []
        var index:Int = 0
        for temp in stocksDataList{
            indexList.append(index)
            index++
        }
        //存储完index
        let count:Int = Int(arc4random_uniform(5)) + 11 //11 - 15
        
        for i in 0..<count{
            let randomIndex:Int = Int(arc4random_uniform(UInt32(indexList.count)))
            let sourceIndex:Int = indexList[randomIndex]
            indexList.removeAtIndex(randomIndex) //移除掉 下次使用
            let ivo:InfoStockVo = stocksDataList[sourceIndex] as! InfoStockVo
            if ivo.kind == 0{
                stockList.append(ivo)
            }else{
                loanList.append(ivo)
            }
        }
        if loanList.count == 0 { //无国债
            return [stockList] //仅证券
        }
        return [stockList,loanList];
    }
    
    static var noticesDataList:NSMutableArray = [
        InfoNoticeVo(title: "汇添富基金管理股份有限公司关于暂停受理现金宝快速取现及信用卡自助还款业务的公告", date: NSDate(), link: "http://www.baidu.com"),
        InfoNoticeVo(title: "关于汇添富现金宝快速取现临时调整额度的公告", date: NSDate(), link: "http://www.baidu.com"),
        InfoNoticeVo(title: "汇添富基金管理股份有限公司关于合作伙伴上海银行电子银行系统升级的公告", date: NSDate(), link: "http://www.qq.com"),
        InfoNoticeVo(title: "汇添富基金管理股份有限公司关于合作伙伴浦发银行电子银行系统升级的公告", date: NSDate(), link: "http://www.qq.com"),
        InfoNoticeVo(title: "汇添富基金管理股份有限公司关于暂停受理现金宝快速取现及信用卡自助还款业务的公告", date: NSDate(), link: "http://www.baidu.com"),
        InfoNoticeVo(title: "汇添富基金管理股份有限公司关于合作伙伴中国银行电子银行系统升级的公告", date: NSDate(), link: "http://www.baidu.com"),
        InfoNoticeVo(title: "汇添富基金管理股份有限公司关于合作伙伴建设银行电子银行系统升级的公告", date: NSDate(), link: "http://www.qq.com"),
        InfoNoticeVo(title: "汇添富基金管理股份有限公司关于客服电话系统升级维护的公告", date: NSDate(), link: "http://www.qq.com"),
        InfoNoticeVo(title: "汇添富基金管理股份有限公司关于合作伙伴建设银行电子银行系统升级的公告", date: NSDate(), link: "http://www.baidu.com"),
    ]
    
    static func getNoticeList()->[InfoNoticeVo]{
        //存储完index
        var noticeList:[InfoNoticeVo] = []
        let count:Int = Int(arc4random_uniform(15)) + 1 //1 - 15
        for i in 0..<count{
            let randomIndex:Int = Int(arc4random_uniform(UInt32(noticesDataList.count)))
            noticeList.append(noticesDataList[randomIndex] as! InfoNoticeVo)
        }
        return noticeList
    }
    
}
class SoueceVo{
    init(data:NSMutableArray?,headerHeight:CGFloat = 0,headerClass:BaseItemRenderer.Type? = nil,headerData:Any? = nil,isUnique:Bool = false){
//        sourceHeight:CGFloat,cellClass:BaseTableViewCell.Type,data:NSMutableArray?,
//        self.sourceHeight = sourceHeight
//        self.cellClass = cellClass
        self.headerHeight = headerHeight
        self.headerClass = headerClass
        self.headerData = headerData
        self.data = data
        self.isUnique = isUnique
    }
//    var sourceHeight:CGFloat = 0.0
//    var cellClass:BaseTableViewCell.Type
    var data:NSMutableArray?//数据源
    var headerHeight:CGFloat = 0.0
    var headerClass:BaseItemRenderer.Type?
    var headerData:Any?//标题的数据源
    var isUnique:Bool = false
}
class CellVo{
    init(cellHeight:CGFloat = 0,cellClass:BaseTableViewCell.Type,cellData:Any? = nil,cellTag:Int = 0,isUnique:Bool = false){
        self.cellHeight = cellHeight
        self.cellClass = cellClass
        self.cellData = cellData
        self.cellTag = cellTag
        self.isUnique = isUnique
    }
    var cellHeight:CGFloat = 0.0
    var cellClass:BaseTableViewCell.Type
    var cellData:Any?//栏目的数据源
    var cellTag:Int = 0//1,2
    var isUnique:Bool = false
}
class HotItemVo {
    init(classId:Int,title:String,content:String,rate:String = "",rateTitle:String = ""){
        self.classId = classId
        self.title = title
        self.content = content
        self.rate = rate
        self.rateTitle = rateTitle
    }
    var classId:Int = 0
    var title:String!
    var content:String!
    var rate:String!
    var rateTitle:String!
}
class FilterFundHeader{
    init(kind:Int,timeKey:String,fundList:NSMutableArray){
        self.kind = kind
        self.timeKey = timeKey
        self.fundList = fundList
    }
    var kind:Int!
    var timeKey:String!
    var fundList:NSMutableArray!
}
class InfoFundHeader{
    
    init(kind:Int,title:String,iconUrl:String,fundList:NSMutableArray){
        self.kind = kind
        self.title = title
        self.fundList = fundList
        self.iconUrl = iconUrl
    }
    var kind:Int!
    var title:String!
    var iconUrl:String!
    var fundList:NSMutableArray!
    var deputyFundVo:InfoFundVo? //代表数据
}
//数据详细信息
class InfoFundVo:NSObject {
    
    override func copy()->AnyObject{
        return InfoFundVo(id: self.id, kind: self.kind, title: self.title, shortTitle: self.shortTitle, code: self.code, rateDay: self.rateDay, rateQuarter: self.rateQuarter, updateTime: self.updateTime, netValue: self.netValue, rank: self.rank, discount: self.discount, buyRateCurrent: self.buyRateCurrent, enoughTag: self.enoughTag, stars: self.stars, isFollow: self.isFollow)
    }

init(id:Int,kind:Int,title:String,shortTitle:String,code:String,rateDay:Float,rateQuarter:Float,updateTime:NSDate,netValue:Float,rank:String,discount:Float,buyRateCurrent:Float,enoughTag:Int = 0,stars:Int = 0,isFollow:Bool = false){
        self.id = id
        self.kind = kind
        self.title = title
        self.shortTitle = shortTitle
        self.code = code
        self.rateDay = rateDay
        self.rateQuarter = rateQuarter;
//        self.tagArr = tagArr
        self.updateTime = updateTime
        self.netValue = netValue
        self.rank = rank
//        self.buyRateTag = buyRateTag
//        self.buyRateOriginal = buyRateOriginal
        self.discount = discount
        self.buyRateCurrent = buyRateCurrent
        self.enoughTag = enoughTag
        self.stars = stars
        self.isFollow = isFollow
    }
    var id:Int = 0
    var kind:Int!//父类型对应索引值
    var title:String!//名称
    var shortTitle:String!//简称
    var code:String!//股票代码
    var rateDay:Float = 0
    var rateQuarter:Float = 0 //一季度
//    var tagArr:[String]!
    var updateTime:NSDate!
    var netValue:Float = 0//净值
    var rank:String!//排名
//    var buyRateTag:String!//购买费率tag
//    var buyRateOriginal:String!//购买费率原先 buyRateCurrent / discount
    var discount:Float!//折扣
    var buyRateCurrent:Float!//购买费率当前
    
    var enoughTag:Int!//..元起购 1百元 2五百元
    var stars:Int!//星级
    var isFollow:Bool = false//是否关注
}
class InfoSummaryVo {
    init(classId:Int,manager:String,company:String,kind:String,money:String,time:String){
        self.classId = classId
        self.manager = manager
        self.company = company
        self.kind = kind
        self.money = money
        self.time = time
    }
    var classId:Int = 0
    var manager:String!
    var company:String!
    var kind:String!
    var money:String!
    var time:String!
}
class InfoStockVo{
    init(title:String,code:String,positionRatio:Float,rateDay:Float,kind:Int8 = 0){
        self.title = title
        self.code = code
        self.positionRatio = positionRatio
        self.rateDay = rateDay
        self.kind = kind
    }
    var title:String!//名称
    var code:String!//股票代码
    var positionRatio:Float!//持仓比例
    var rateDay:Float!//涨跌幅
    var kind:Int8 = 0//类型 0股票 1债券
}
class InfoNoticeVo{
    
    init(title:String,date:NSDate,link:String){
        self.title = title
        self.date = date
        self.link = link
    }
    var title:String!//名称
    var date:NSDate!
    var link:String!//链接网址
}






