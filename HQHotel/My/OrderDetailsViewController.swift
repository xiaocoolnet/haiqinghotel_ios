//
//  OrderDetailsViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/11.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class OrderDetailsViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    private var tableview1=UITableView()
    private var tableview2=UITableView()
    internal var type=Int()
    internal var hang = Int()
    
    var hotelSource = HotelOrderModel()
    var FoodSource = FoodOrderModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=bkColor
        self.automaticallyAdjustsScrollViewInsets=false
        if type==1 {
            tableview1=UITableView(frame: CGRectMake(0, 58, self.view.bounds.width, 300), style: UITableViewStyle.Grouped)
            tableview1.delegate=self
            tableview1.dataSource=self
            tableview1.backgroundColor=bkColor
            tableview1.scrollEnabled=false
            self.view.addSubview(tableview1)
        }else if type==2{
            tableview2=UITableView(frame: CGRectMake(0, 58, self.view.bounds.width, 300), style: UITableViewStyle.Grouped)
            tableview2.delegate=self
            tableview2.dataSource=self
            tableview2.backgroundColor=bkColor
            tableview2.scrollEnabled=false
            self.view.addSubview(tableview2)
            GetfoodorderDate()
        }
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    {
        if section==0 {
            return 1
        }else if section==1{
            return 3
        }else{
            return 2
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if tableView==tableview1 {
            
        
        let  identifier = "cell1"
        let  cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        cell.textLabel?.textColor=textColor
        let lable = UILabel(frame: CGRectMake(self.view.bounds.width/4,5,self.view.bounds.width/4*3,34))
        lable.text="订单号"
        lable.textColor=textColor
         cell.addSubview(lable)

        if indexPath.section==0 {
            cell.textLabel?.text="订单号"
            
            lable.text="ga"
        }else if indexPath.section==1 {
            if indexPath.row==0 {
                cell.textLabel?.text="房型"
               
                 lable.text="订单号"
                
            }else if indexPath.row==1{
                cell.textLabel?.text="入住人"
             
            }
            else if indexPath.row==2{
                cell.textLabel?.text="房间数"
           
            }
        }else
        {
            if indexPath.row==0 {
                cell.textLabel?.text="联系方式"
       
            }else if indexPath.row==1
            {
                cell.textLabel?.text="备注"
                
            }
        }
        return cell
        }else{
            
            let  identifier2 = "cell2"
            let  cell = UITableViewCell(style: .Default, reuseIdentifier: identifier2)
            

//            let foodInfo = FoodSource.orderlist
            
            cell.textLabel?.textColor=textColor
            let lable = UILabel(frame: CGRectMake(self.view.bounds.width/4,5,self.view.bounds.width/4*3,34))
            lable.text="订单号"
            lable.textColor=textColor
            cell.addSubview(lable)
            
            if indexPath.section==0 {
                cell.textLabel?.text="订单号"
                
                lable.text="ga"
            }else if indexPath.section==1 {
                if indexPath.row==0 {
                    cell.textLabel?.text="类型"
                    
//                    lable.text=foodInfo.foodordername
                    
                }else if indexPath.row==1{
                    cell.textLabel?.text="预定人"
                    lable.text=""
                }
                else if indexPath.row==2{
                    cell.textLabel?.text="预定数量"
//                    lable.text=foodInfo.foodordernumber
                }
            }else
            {
                if indexPath.row==0 {
                    cell.textLabel?.text="联系方式"
//                    lable.text=foodInfo.foodordermobile
                    
                }else if indexPath.row==1
                {
                    cell.textLabel?.text="备注"
//                    lable.text=foodInfo.foodorderremarks
                    
                }

            }
            
            return cell
        }
    }
    func GetfoodorderDate(){
        let url = apiUrl+"getcateringorderlist"
        
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
                    self.FoodSource = FoodOrderModel(status.data!)
                    self.tableview2.reloadData()
                }
            }
        }
    }
    
    func GetroomorderDate(){
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
                    self.tableview1.reloadData()
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
