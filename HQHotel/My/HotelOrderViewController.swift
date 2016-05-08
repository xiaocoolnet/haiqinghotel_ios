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

   
    override func viewDidLoad() {
        super.viewDidLoad()
        GetorderDate()
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
        let order = NSUserDefaults.standardUserDefaults()
        
        var cell = HotelOrderCell()
        cell=tableview.dequeueReusableCellWithIdentifier("cell") as! HotelOrderCell
        
        cell.fangxingL?.text=order.stringForKey("name")
        cell.timeL?.text=order.stringForKey("time")
        cell.shuliangL?.text=order.stringForKey("number")
        cell.zongjiaL?.text=order.stringForKey("money")
        return cell
    }
    func GetorderDate(){
        let url = apiUrl+"getbookingorderlist"
        
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let param = [
            "userid":uid!
        ]
      
        Alamofire.request(.GET, url, parameters: param ).response { request, response, json, error in
            if(error != nil){
            }
            else{
                
                let status = HotelOrderModel(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    print("Success")
                    let order = NSUserDefaults.standardUserDefaults()
                    
                    order.setValue(status.data?.ordername, forKey: "name")
                    order.setValue(status.data?.orderid, forKey: "rid")
                    order.setValue(status.data?.ordertime, forKey: "time")
                    
                    order.setValue(status.data?.orderstate, forKey: "state")
                    order.setValue(status.data?.ordertype, forKey: "type")
                    order.setValue(status.data?.ordermobile, forKey: "mobile")
                    order.setValue(status.data?.orderprice, forKey: "price")
                    order.setValue(status.data?.orderpicture, forKey: "picture")
                    order.setValue(status.data?.ordernumber, forKey: "number")
                    order.setValue(status.data?.ordermoney, forKey: "money")
                    order.setValue(status.data?.orderbegintime, forKey: "begintime")
                    order.setValue(status.data?.orderendtime, forKey: "endtime")
                    order.setValue(status.data?.orderarrivetime, forKey: "arrivetime")
                    order.setValue(status.data?.orderremarks, forKey: "remarks")
                    order.setValue(status.data?.orderpeoplenumber, forKey: "peoplenumber")
                    order.setValue(status.data?.ordergid, forKey: "gid")
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
