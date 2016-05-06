//
//  HotelOrderModel.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/6.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation


class HotelOrderModel: JSONJoy{
    var status:String?
    var data:HotelOrderInfo?
    var errorData:String?
    var datastring:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        status = decoder["status"].string
        if status == "success"{
            data = HotelOrderInfo(decoder["data"])
        }else{
            errorData = decoder["data"].string
        }
        
    }
}
class HotelOrderInfo: JSONJoy{
        
    var ordergid:String?
    var ordername: String?
    var orderid:String?
    var ordertime:String?
    var orderstate:String?
    var ordertype:String?
    var ordermobile : String?
    var orderprice:String?
    var orderpicture:String?
    var ordernumber:String?
    var ordermoney:String?
    var orderbegintime:String?
    var orderendtime:String?
    var orderarrivetime:String?
    var orderremarks:String?
    var orderpeoplenumber:String?

    
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
       
        ordergid = decoder["gid"].string
        ordername = decoder["name"].string
        orderid = decoder["rid"].string
        ordertime = decoder["time"].string
        orderstate = decoder["state"].string
        ordertype = decoder["type"].string
        ordermobile = decoder["mobile"].string
        orderprice = decoder["price"].string
        orderpicture = decoder["picture"].string
        ordernumber = decoder["number"].string
        ordermoney = decoder["money"].string
        orderbegintime = decoder["begintime"].string
        orderendtime = decoder["endtime"].string
        orderarrivetime = decoder["arrivetime"].string
        orderremarks = decoder["remarks"].string
        orderpeoplenumber = decoder["peoplenumber"].string

    }
    
}
