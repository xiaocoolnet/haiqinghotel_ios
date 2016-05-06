//
//  GoodListModel.swift
//  HQHotel
//
//  Created by apple on 16/5/6.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation

class PictureList: JSONJoy {
    var picturelist: [GoodListInfo]
    var count: Int{
        return self.picturelist.count
    }
    
    init(){
        picturelist = Array<GoodListInfo>()
    }
    required init(_ decoder: JSONDecoder) {
        //        status = decoder["status"].string
        picturelist = Array<GoodListInfo>()
        for childs: JSONDecoder in decoder.array!{
            picturelist.append(GoodListInfo(childs))
        }
    }
    
    func append(list: [GoodListInfo]){
        self.picturelist = list + self.picturelist
    }
}
class GoodListInfo: JSONJoy{
    var id:String?
    var name:String?
    var unit: String?
    var price: String?
    init() {
        
    }
    required init(_ decoder: JSONDecoder){
        name = decoder["name"].string
        id = decoder["id"].string
        unit = decoder["unit"].string
        price = decoder["price"].string
    }
    
}
