//
//  SaleModel.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/5.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation


class SaleModel: JSONJoy{
    var status:String?
    var data:SaleInfo?
    var errorData:String?
    var datastring:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        status = decoder["status"].string
        if status == "success"{
            data = SaleInfo(decoder["data"])
        }else{
            errorData = decoder["data"].string
        }
        
    }
}
class SaleInfo: JSONJoy{
    var roomid:String?
    var roomname: String?
    var roomprice:String?
    var roomoprice:String?
    var roomcount:String?
    var roomdaynum:String?
    var roomdaysurplus : String?
    var roomsurplus:String?
    var roompicture:String?
    var roomshowid:String?
    var roomtime:String?
    
    
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        roomid = decoder["id"].string
        roomname = decoder["name"].string
        roomprice = decoder["price"].string
        roomoprice = decoder["oprice"].string
        roomcount = decoder["count"].string
        roomdaynum = decoder["daynum"].string
        roomdaysurplus = decoder["daysurplus"].string
        roomsurplus = decoder["surplus"].string
        roompicture = decoder["picture"].string
        roomshowid=decoder["showid"].string
        roomtime=decoder["time"].string
    }
    
}
