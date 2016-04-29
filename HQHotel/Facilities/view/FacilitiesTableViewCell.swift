//
//  FacilitiesTableViewCell.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/28.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class FacilitiesTableViewCell: UITableViewCell {

    private var iconIV=UIImageView()
    private var titleL=UILabel()
    private var jieshaoL=UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        iconIV=UIImageView(frame: CGRectMake(10, 10, 70, 70))
        iconIV.image=UIImage(named: "青岛海情-001.JPG")
        self.addSubview(iconIV)
        titleL=UILabel(frame: CGRectMake(85,10,self.bounds.width-90,20))
        titleL.text="“大床房” 房间设施"
        self.addSubview(titleL)
        jieshaoL=UILabel(frame: CGRectMake(85,35,self.bounds.width-115,self.bounds.height-40))
        jieshaoL.text="i 如题运动家人看感觉哦额   日剧透哦 i 为 u 肉饭 i而哦光荣饿哦人家工人节 i 火热开放和 vi 设计单位复古货到付款就"
        jieshaoL.font=UIFont.systemFontOfSize(12)
        jieshaoL.lineBreakMode  = NSLineBreakMode.ByWordWrapping
        jieshaoL.numberOfLines=0
        self.addSubview(jieshaoL)
    }

    class func cellWithTableView(tableView:UITableView)->FacilitiesTableViewCell  {
        var cell = tableView.dequeueReusableCellWithIdentifier("a") as? FacilitiesTableViewCell
        
        if cell==nil {
            cell = FacilitiesTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "a")
        }
        return cell!
    }
}
