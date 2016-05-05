//
//  HotelOrderViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/4.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class HotelOrderViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    private var tableview:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets=false
        tableview=UITableView(frame: CGRectMake(0, 64, self.view.bounds.width, self.view.bounds.height-110))
        tableview.delegate=self
        tableview.dataSource=self
        tableview.rowHeight=95
        tableview.registerNib((UINib(nibName: "HotelOrderCell",bundle: nil)) ,forCellReuseIdentifier: "cell")
        self.view.addSubview(tableview)
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    //cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        var cell = HotelOrderCell()
        cell=tableview.dequeueReusableCellWithIdentifier("cell") as! HotelOrderCell
        return cell
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
