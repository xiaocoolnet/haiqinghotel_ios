//
//  RoomViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/18.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private var tableView=UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView=UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        tableView.dataSource=self
        tableView.delegate=self
        tableView.rowHeight=90
        
        self.view.addSubview(tableView)
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = FacilitiesTableViewCell.cellWithTableView(tableView)
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let roomVC = RoomDetailsViewController()
        self.navigationController?.pushViewController(roomVC, animated: true)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 20/255, green: 125/255, blue: 192/255, alpha: 1)
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
    }
}
