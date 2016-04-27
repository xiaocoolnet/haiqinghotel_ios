//
//  LBNvc.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/16.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class LBNvc: UINavigationController {
    //666
    override func viewDidLoad() {
        super.viewDidLoad()

        let navigationTitleAttribute : NSDictionary = NSDictionary(object: UIColor.redColor(),forKey: NSForegroundColorAttributeName)
        self.navigationBar.titleTextAttributes = navigationTitleAttribute as [NSObject : AnyObject] as? [String : AnyObject]
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
