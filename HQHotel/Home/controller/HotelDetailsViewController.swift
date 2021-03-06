//
//  HotelDetailsViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/20.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class HotelDetailsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""

        self.view.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        let topview = UIView(frame: CGRectMake(0,44,self.view.bounds.width,self.view.bounds.width*0.59+40))
        topview.backgroundColor=UIColor.whiteColor()
        let imageV = UIImageView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.width*0.59))
        imageV.image=UIImage(named: "酒店详情.jpg")
        topview.addSubview(imageV)
        let starL = UILabel(frame: CGRectMake(10,self.view.bounds.width*0.59+10,80,20))
        starL.text="酒店星级"
        starL.font=UIFont.systemFontOfSize(15)
        starL.textColor=UIColor.init(colorLiteralRed: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        topview.addSubview(starL)
        
        let starimageV = UIImageView(frame: CGRectMake((self.view.bounds.width-120), self.view.bounds.width*0.59+10, 110, 18))
        starimageV.image=UIImage(named: "ic_star")
        topview.addSubview(starimageV)
        
        self.view.addSubview(topview)
        let textView = UITextView(frame: CGRectMake(0, self.view.bounds.width*0.59+90, self.view.bounds.width, self.view.bounds.height-self.view.bounds.width*0.59+90))
        textView.text=""
        textView.textColor=textColor
        self.view.addSubview(textView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden=false
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        self.tabBarController?.tabBar.hidden=true
        self.title="酒店详情"
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
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
