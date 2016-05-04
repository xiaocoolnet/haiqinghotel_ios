//
//  MallCollectionViewCell.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/18.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class MallCollectionViewCell: UICollectionViewCell {

     var imageView: UIImageView!
    
     var nameL: UILabel!
    
     var jianjieL: UILabel!
    
     var priceL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView=UIImageView(frame: CGRectMake(0, 0, frame.width, frame.height-80))
        imageView.image=UIImage(named: "海参.jpg")
        nameL=UILabel(frame: CGRectMake(0, frame.height-80, frame.width, 30))
        nameL.text="野生海参"
        nameL.adjustsFontSizeToFitWidth=true
        nameL.baselineAdjustment = UIBaselineAdjustment.AlignBaselines
        jianjieL=UILabel(frame: CGRectMake(0, frame.height-50, frame.width, 10))
        jianjieL.text="生鲜送礼佳品"
        jianjieL.font=UIFont.systemFontOfSize(12)
        jianjieL.adjustsFontSizeToFitWidth=true
        priceL=UILabel(frame: CGRectMake(0, frame.height-35, frame.width, 30))
        priceL.text="100"
        priceL.textColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        priceL.font=UIFont.systemFontOfSize(15)
        priceL.adjustsFontSizeToFitWidth=true
        
        self.addSubview(imageView)
        self.addSubview(nameL)
        self.addSubview(jianjieL)
        self.addSubview(priceL)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}
