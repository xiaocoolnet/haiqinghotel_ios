//
//  GoodsViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/19.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class GoodsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        self.view.backgroundColor=UIColor.redColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
