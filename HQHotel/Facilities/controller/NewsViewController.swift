//
//  NewsViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/3.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {

    private var titleL=UILabel()
    private var timeL=UILabel()
    private var textView=UITextView()
    private var readL=UILabel()
    private var readnumL:UILabel!
    private var zanBT:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

       titleL=UILabel(frame: CGRectMake(5,70,self.view.bounds.width-10,50))
       titleL.text="不想惨遭盗号的话，这份指南你一定用得上｜有用功"
        titleL.numberOfLines=0
        
        
       timeL=UILabel(frame: CGRectMake(5,70+50+5,self.view.bounds.width/3,20))
        timeL.text="2016-04-02"
        timeL.textColor=UIColor.grayColor()
        textView=UITextView(frame: CGRectMake(5, 150, self.view.bounds.width-10, self.view.bounds.height-180))
        textView.editable=false
        textView.text="是绝代风华金额快速的减肥吧卡时间发货哈。kjxhgv.areuhg额日更何况如果结婚了看到黄金分割了客人给你。aelkrhgoihrflkvgane.r／连热裤结果／流口水的复合弓 i 很多个 i例如开花结果。旅客入境管理a/lerjg例如殴打了法律框架如果 i你人  不是想和 u 是你就回复 i 说 "
        textView.font=UIFont.systemFontOfSize(16)
        textView.textColor=UIColor.init(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        readL=UILabel(frame: CGRectMake(5,self.view.bounds.height-20,40,10))
        readL.text="阅读"
        readL.textColor=UIColor.grayColor()
        readL.font=UIFont.systemFontOfSize(16)
        readnumL=UILabel(frame: CGRectMake(50,self.view.bounds.height-22,80,13))
         readnumL.text="63672"
        readnumL.textColor=UIColor.grayColor()
        zanBT=UIButton(frame: CGRectMake(self.view.bounds.width-50, self.view.bounds.height-30, 20, 20))
        zanBT.imageView?.image=UIImage(named: "赞")
        
        
        
        self.view.addSubview(readnumL)
        self.view.addSubview(titleL)
        self.view.addSubview(readL)
        self.view.addSubview(timeL)
        self.view.addSubview(textView)
        self.view.addSubview(zanBT)
        
    }

    func getTextRectSize(text:NSString,fout:UIFont,size:CGSize) -> CGRect {
        let attributes = [NSFontAttributeName:fout]
        let option = NSStringDrawingOptions.UsesLineFragmentOrigin
        let rect:CGRect = text.boundingRectWithSize(size, options: option, attributes: attributes, context: nil)
        return rect
  
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
    }
    }
