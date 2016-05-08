//
//  CaterModel.swift
//  HQHotel
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation

class CaterModel: JSONJoy {
    var objectlist: [CaterInfo]
    var count: Int{
        return self.objectlist.count
    }
    
    init(){
        objectlist = Array<CaterInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        
        objectlist = Array<CaterInfo>()
        for useids: JSONDecoder in decoder.array!{
            objectlist.append(CaterInfo(useids))
        }
    }
    
    func append(list: [CaterInfo]){
        self.objectlist = list + self.objectlist
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
    var goodListtt:JSONDecoder?
    
    
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
        goodListtt = decoder["goodlist"]
    }
    
}
