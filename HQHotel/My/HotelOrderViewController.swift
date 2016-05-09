//
//  HotelOrderViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/4.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class HotelOrderViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    private var tableview:UITableView!

    var hotelSource = HotelOrderModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.automaticallyAdjustsScrollViewInsets=false
        tableview=UITableView(frame: CGRectMake(0, 64, self.view.bounds.width, self.view.bounds.height-64))
        tableview.delegate=self
        tableview.dataSource=self
        tableview.rowHeight=95
        tableview.registerNib((UINib(nibName: "HotelOrderCell",bundle: nil)) ,forCellReuseIdentifier: "cell")
 
        self.view.addSubview(tableview)
         GetorderDate()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return hotelSource.count
        
    }
    //cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        
        var cell = HotelOrderCell()
        cell=tableview.dequeueReusableCellWithIdentifier("cell") as! HotelOrderCell
        let hotelInfo = hotelSource.orderlist[indexPath.row]
        cell.fangxingL?.text=hotelInfo.ordername
        
        
        // 时间戳转时间
                let dateformate = NSDateFormatter()
                dateformate.dateFormat = "yyyy-MM-dd HH:mm"//获得日期
                let date = NSDate(timeIntervalSince1970: NSTimeInterval(hotelInfo.ordertime!)!)
                let str:String = dateformate.stringFromDate(date)
        
        
        cell.timeL?.text=str
        cell.shuliangL?.text=hotelInfo.ordernumber
        cell.zongjiaL?.text=hotelInfo.orderprice
        return cell
    }
    func GetorderDate(){
        let url = apiUrl+"getbookingorderlist"
        
//        let userid = NSUserDefaults.standardUserDefaults()
//        let uid = userid.stringForKey("userid")
        let param = [
            "userid":578
        ]
      
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
            }
            else{
                
                let status = Http(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    self.hotelSource = HotelOrderModel(status.data!)
                    self.tableview.reloadData()
                }
            }
        }
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
