//
//  FoodOrderModel.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/10.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation
class FoodOrderModel: JSONJoy {
    var orderlist: [FoodOrderInfo]
    var count: Int{
        return self.orderlist.count
    }
    
    init(){
        orderlist = Array<FoodOrderInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        orderlist = Array<FoodOrderInfo>()
        for childs: JSONDecoder in decoder.array!{
            orderlist.append(FoodOrderInfo(childs))
        }
    }
    
    func append(list: [FoodOrderInfo]){
        self.orderlist = list + self.orderlist
    }
}
class FoodOrderInfo: JSONJoy{
    
    var foodordergid:String?
    var foodordername: String?
    var foodorderid:String?
    var foodordertime:String?
    var foodorderstate:String?
    var foodordertype:String?
    var foodordermobile : String?
    var foodorderprice:String?
    var foodorderpicture:String?
    var foodordernumber:String?
    var foodordermoney:String?
    var foodorderremarks:String?
    var foodorderrepasttime:String?
    
    
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        
        foodordergid = decoder["gid"].string
        foodordername = decoder["name"].string
        foodorderid = decoder["rid"].string
        foodordertime = decoder["time"].string
        foodorderstate = decoder["state"].string
        foodordertype = decoder["type"].string
        foodordermobile = decoder["mobile"].string
        foodorderprice = decoder["price"].string
        foodorderpicture = decoder["picture"].string
        foodordernumber = decoder["number"].string
        foodordermoney = decoder["money"].string
        foodorderremarks = decoder["remarks"].string
        foodorderrepasttime = decoder["repasttime"].string
        
    }
    
}
