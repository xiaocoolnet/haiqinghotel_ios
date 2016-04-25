//
//  HotelmallTableViewCell.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/15.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class HotelmallTableViewCell: UITableViewCell {

    private var imageV=UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        imageV.frame=CGRectMake(10, 5, self.bounds.width-20, 140)
        imageV.backgroundColor=UIColor.blueColor()
        imageV.image=UIImage(named: "1.jpg")
        self.addSubview(imageV)
        
    }
    
   class func cellWithTableView(tableView:UITableView)->HotelmallTableViewCell  {
        var cell = tableView.dequeueReusableCellWithIdentifier("a") as? HotelmallTableViewCell
        
        if cell==nil {
            cell = HotelmallTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "a")
        }
        return cell!
    }

}
