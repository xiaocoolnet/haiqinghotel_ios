//
//  RoomOrderViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/16.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class RoomOrderViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    var chuangxing = String()
    
    private var roomtableview=UITableView()
    var OrderRoomSource = OrderRoomModel()
    
    internal var roomStartTime=String()
    internal var roomEndTime=String()
    internal var roomTimeNum=Int()
    var idArray = NSMutableArray()
    var Rname = String()
    
    
    var count = Int()
    var photoSource = roomphotolistInfo()
    var photoAry = NSMutableArray()

    var SaleSource = SaleModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GetDate()
        roomtableview=UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height), style: .Plain)
        roomtableview.delegate=self
        roomtableview.dataSource=self
        roomtableview.rowHeight=85
        roomtableview.registerNib((UINib(nibName: "RoomOrdercell",bundle: nil)) ,forCellReuseIdentifier: "cell1")

        self.view.addSubview(roomtableview)
    }
    //酒店预订接口
    func GetDate(){
        let url = apiUrl+"getbedroomlist"
        //        let userid = NSUserDefaults.standardUserDefaults()
        //        let uid = userid.stringForKey("userid")
        //        let param = [
        //            "userid":uid!
        //        ]
        Alamofire.request(.GET, url, parameters: nil).response { request, response, json, error in
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
                    self.OrderRoomSource = OrderRoomModel(status.data!)
                    self.roomtableview.reloadData()
                }
            }
        }
    }
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return OrderRoomSource.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell = RoomOrdercell()
        cell=roomtableview.dequeueReusableCellWithIdentifier("cell1") as! RoomOrdercell
        let orderroomInfo = OrderRoomSource.objectlist[indexPath.row]

     
        
        cell.chuangxingL.text=chuangxing
        cell.nameL.text=orderroomInfo.name!
        cell.nameL.textColor=textColor
        cell.foodL.textColor=orangeColor
        if orderroomInfo.repast!=="1" {
            cell.foodL.text="含早餐"
            cell.foodIV.image=UIImage(named: "ic_zaocan-1")
        }else{
            cell.foodL.text="不含早餐"
            cell.foodIV.image=UIImage(named: "ic_zaocan")
        }
        cell.mianjiL.text=orderroomInfo.acreage
        cell.chicunL.text=orderroomInfo.size
        cell.chuangxingL.text=orderroomInfo.bed
        cell.youhuijiaL.text="¥"+orderroomInfo.price!
        cell.youhuijiaL.textColor=orangeColor
        cell.menshijiaL.text="¥"+orderroomInfo.oprice!
        cell.loucengL.text=orderroomInfo.floor
        var photo = String()
        photo=imageUrl+orderroomInfo.picture!
        cell.iconIV.sd_setImageWithURL(NSURL(string: photo), placeholderImage: UIImage(named: "food1.png"))
        cell.yudingBT.backgroundColor=orangeColor
        cell.yudingBT.layer.cornerRadius=3
        cell.yudingBT.tag=indexPath.row
        cell.yudingBT.addTarget(self, action: #selector(RoomOrderViewController.yuding(_:)), forControlEvents: .TouchUpInside)
        
        
        return cell
    }
   
    func yuding(sender:UIButton){
        print(sender.tag)
        let orderroomInfo = OrderRoomSource.objectlist[sender.tag]
        let orderVC = ReserveViewController()
        orderVC.startTime=roomStartTime
        orderVC.endTime=roomEndTime
        orderVC.roomnum=roomTimeNum
        
        orderVC.name=orderroomInfo.name!
        orderVC.bedsize1=orderroomInfo.bed!
        orderVC.network1=orderroomInfo.network!
        orderVC.repast=orderroomInfo.repast!
        var ppp = Int()
        ppp=Int(orderroomInfo.price!)!*roomTimeNum
        
        orderVC.price = String(ppp)


        self.navigationController?.pushViewController(orderVC, animated: true)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        self.navigationItem.title="立即预订"
        self.navigationController?.navigationBar.backItem?.title=""
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
    }
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   }
