//
//  ShowMessageViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/21.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class ShowMessageViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView=UITableView(frame: CGRectMake(0, 64, self.view.bounds.width, 168), style: .Grouped)
        tableView.delegate=self
        tableView.dataSource=self
        self.view.addSubview(tableView)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section==0 {
            return 1
        }else{
            return 2
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        return cell
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
