//
//  NewsTableViewCell.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/18.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    private var imageV=UIImageView()
    private var titleL=UILabel()
    private var jianjieL=UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        titleL.frame=CGRectMake(10, 5, self.bounds.width-20, 20)
        titleL.text="hahahahhahahahahahahahahahhaha"
        imageV.frame=CGRectMake(10, 25, self.bounds.width-20, 120)
        imageV.image=UIImage(named: "1.jpg")
        jianjieL.frame=CGRectMake(10, 140, self.bounds.width-20, 40)
        jianjieL.text="jhdgfbjhregfskdjfsrg jdhfgmvbcjhvbjdfhfhbcvhgdhdfbhbhbjbvfgnghnhjn"
        //添加标题名称
        self.addSubview(titleL)
        //添加图片
        self.addSubview(imageV)
        //添加简介内容
        self.addSubview(jianjieL)

    }

}
