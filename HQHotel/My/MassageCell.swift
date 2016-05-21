//
//  MassageCell.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/18.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class MassageCell: UITableViewCell {

    var iconIV = UIImageView()
    var titleL = UILabel()
    var contentL = UILabel()
    var timeL = UILabel()
    
    
    
    
    
    override func awakeFromNib() {
           }
   
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        super.awakeFromNib()
        iconIV.frame=CGRectMake(5, 5, 50, 50)
        self.addSubview(iconIV)
        titleL.frame=CGRectMake(60, 5, self.bounds.width/2, 20)
        timeL.textColor=wenziColor
        self.addSubview(titleL)
        timeL.frame=CGRectMake(self.bounds.width-70, 5, 65, 20)
        timeL.font=UIFont.systemFontOfSize(12)
        timeL.textColor=UIColor.grayColor()
        self.addSubview(timeL)
        contentL.frame=CGRectMake(65, 30, self.bounds.width-70, 20)
        contentL.textColor=UIColor.grayColor()
        contentL.font=UIFont.systemFontOfSize(13)
        self.addSubview(contentL)

    }
    class func cellWithTableView(tableView:UITableView)->MassageCell  {
        var cell = tableView.dequeueReusableCellWithIdentifier("a") as? MassageCell
        
        if cell==nil {
            cell = MassageCell(style: UITableViewCellStyle.Default, reuseIdentifier: "a")
        }
        return cell!
    }


}
