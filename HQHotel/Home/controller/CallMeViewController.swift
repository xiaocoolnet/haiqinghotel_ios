//
//  CallMeViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/20.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class CallMeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""

        self.view.backgroundColor=UIColor.whiteColor()
        for item in 1...3 {
            let tubiao_h = 25+65*CGFloat(item)
            if item==3 {
                let tubiao_imageV = UIImageView(frame: CGRectMake(20, tubiao_h,  12, 20))
                tubiao_imageV.image=UIImage(named: "callme-\(item)")
                self.view.addSubview(tubiao_imageV)
            }else{
            let tubiao_imageV = UIImageView(frame: CGRectMake(20, tubiao_h,  20, 20))
            tubiao_imageV.image=UIImage(named: "callme-\(item)")
            
            self.view.addSubview(tubiao_imageV)
            }
            let biaoti_Lable = UILabel(frame: CGRectMake(50, 25+65*CGFloat(item), 100, 20))
            biaoti_Lable.textColor=UIColor.init(colorLiteralRed: 82/255, green: 82/255, blue: 82/255, alpha: 1)
            switch item {
            case 1:
                biaoti_Lable.text="订房热线"
            case 2:
                biaoti_Lable.text="酒店官网"
            default:
                biaoti_Lable.text="酒店地址"
            }
            self.view.addSubview(biaoti_Lable)
            let neirong_lable = UILabel(frame: CGRectMake(20,30+65*CGFloat(item)+20,self.view.bounds.width,20))
            
            neirong_lable.font=UIFont.systemFontOfSize(14)
            neirong_lable.textColor=textColor
            
            switch item {
            case 1:
                neirong_lable.text="0532-85087238"
            case 2:
                neirong_lable.text="www.qingdaolvxing.com"
            default:
                neirong_lable.text="青岛市 市南区 东海中路11号甲（近台湾路）"
            }
            self.view.addSubview(neirong_lable)
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden=false
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        self.tabBarController?.tabBar.hidden=true
        self.title="联系我们"
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
