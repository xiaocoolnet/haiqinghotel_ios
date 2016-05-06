//
//  CaterModel.swift
//  HQHotel
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation

class CaterModel: JSONJoy{
    var status:String?
    var data:CaterInfo?
    var errorData:String?
    var datastring:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        status = decoder["status"].string
        if status == "success"{
            data = CaterInfo(decoder["data"])
        }else{
            errorData = decoder["data"].string
        }
        
    }
}
class CaterInfo: JSONJoy{
    var foodId:String?
    var foodName: String?
    var foodPrice:String?
    var foodOprice:String?
    var foodUnit:String?
    var foodDescription : String?
    var foodPicture:String?
    var foodShowid:String?
    var foodTime:String?
    var goodList:GoodListInfo?
    
    
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        foodId = decoder["id"].string
        foodName = decoder["name"].string
        foodPrice = decoder["price"].string
        foodOprice = decoder["oprice"].string
        foodUnit = decoder["unit"].string
        foodDescription = decoder["description"].string
        foodPicture = decoder["picture"].string
        foodShowid=decoder["showid"].string
        foodTime=decoder["time"].string
        goodList = decoder["goodlist"]
    }
    
}
