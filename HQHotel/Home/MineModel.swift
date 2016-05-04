//
//  MineModel.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/4.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import Foundation

class MineModel: JSONJoy{
    var status:String?
    var data:UserInfomation?
    var errorData:String?
    var datastring:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        status = decoder["status"].string
        if status == "success"{
            data = UserInfomation(decoder["data"])
        }else{
            errorData = decoder["data"].string
        }
        
    }
}
class UserInfomation: JSONJoy {
    var id:String?
    var name:String?
    var avatar:String?
    var phoneNumber:String?
    init(){
    }
    required init(_ decoder:JSONDecoder){
        id = decoder["id"].string
        name = decoder["name"].string
        avatar = decoder["photo"].string
        phoneNumber = decoder["phone"].string
        
    }
}