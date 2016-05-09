//
//  ReserveViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/28.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class ReserveViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var roomname = UILabel()

    @IBOutlet weak var bed = UILabel()
    
    @IBOutlet weak var wifi = UILabel()
    
    @IBOutlet weak var food = UILabel()
    
    @IBOutlet weak var foodIV: UIImageView!
    
 
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var phoneTF: UITextField!
    
    @IBOutlet weak var beizhuTV: UITextView!
    
    
    @IBOutlet weak var roomNumL: UILabel!
    
    @IBOutlet weak var getToL: UILabel!
    
    internal var name=String()
    internal var bedsize=String()
    internal var repast=String()
    internal var network=String()
    internal var startTime=String()
    internal var endTime=String()
    internal var price=String()
    
    private var tableView1=UITableView()
    private var tableView2=UITableView()
    
    private var numArray=NSArray()
    private var timeArray=NSArray()
    private var button=UIButton()
    var startzheng=Int()
    var endzheng=Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.view.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        tableView.delegate=self
        tableView.dataSource=self
        tableView.scrollEnabled=false
        roomname?.text=name
        bed?.text=bedsize
        wifi?.text=network
        
        if repast=="1" {
            food?.text="含早餐"
            foodIV.image=UIImage(named: "ic_zaocan-1")
        }else{
            food?.text="不含早餐"
            foodIV.image=UIImage(named: "ic_zaocan")
        }
        numArray=["1间","2间","3间","4间","5间","6间"]
        timeArray=["18:00之前","20:00之前","23:59之前","次日凌晨六点之前"]
        self.automaticallyAdjustsScrollViewInsets=false
        let priceL = UILabel(frame: CGRectMake(0,self.view.bounds.height-40,self.view.bounds.width/2,40))
        priceL.backgroundColor=UIColor.whiteColor()
        priceL.text="  总价："
        self.view.addSubview(priceL)
        let zongjiaL = UILabel(frame: CGRectMake(70,self.view.bounds.height-40,self.view.bounds.width/2-70,40))
        zongjiaL.backgroundColor=UIColor.whiteColor()
        zongjiaL.text=price
        self.view.addSubview(zongjiaL)
        let yudingBT = UIButton(frame: CGRectMake(self.view.bounds.width/2,self.view.bounds.height-40,self.view.bounds.width/2,40))
        yudingBT.backgroundColor=UIColor.init(red: 250/255, green: 140/255, blue: 61/255, alpha: 1)
        yudingBT.setTitle("立即预订", forState: UIControlState.Normal)
        yudingBT.addTarget(self, action: #selector(nowYuding), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(yudingBT)
        
        beizhuTV.layer.borderWidth=1
        beizhuTV.layer.borderColor=UIColor.grayColor().CGColor
        beizhuTV.layer.masksToBounds=true
        beizhuTV.layer.cornerRadius=6
        
        //时间转时间戳
         let dateformate = NSDateFormatter()
         dateformate.dateFormat = "yyyy-MM-dd"
         let date = dateformate.dateFromString(startTime)
         let time:NSTimeInterval = (date?.timeIntervalSince1970)!
         startzheng = Int(time)
         print(startzheng)
        let dateformate1 = NSDateFormatter()
        dateformate1.dateFormat = "yyyy-MM-dd"
        let date1 = dateformate1.dateFromString(endTime)
        let time1:NSTimeInterval = (date1?.timeIntervalSince1970)!
        endzheng = Int(time1)
        print(endzheng)
   
        
    }

   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if tableView==tableView1 {
            return numArray.count
        }
        else if tableView==tableView2{
            return timeArray.count
        }
        else{
            return 3
        }
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if tableView==tableView1 {
            let cell = UITableViewCell()
            cell.textLabel?.text=numArray.objectAtIndex(indexPath.row) as? String
            
            return cell
            
        }
        else if tableView==tableView2{
            let cell = UITableViewCell()
            cell.textLabel?.text=timeArray.objectAtIndex(indexPath.row) as? String
            return cell
            
        }
        else{
        let cell = UITableViewCell()
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        
               switch indexPath.row {
        case 0:
            
            cell.textLabel?.text=startTime+"入住"+endTime+"离店"
        case 1:
            cell.textLabel?.text="房间数"
                cell.textLabel?.textColor=UIColor.grayColor()
        default:
            
             cell.textLabel?.text="预计到达"
                cell.textLabel?.textColor=UIColor.grayColor()
            }
            return cell}
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView==tableView1 {
            roomNumL.text=numArray.objectAtIndex(indexPath.row) as? String
            button.frame=CGRectMake(0, 0, 0, 0)
            tableView.frame=CGRectMake(0, 0, 0, 0)
        }
        else if tableView==tableView2{
            getToL.text=timeArray.objectAtIndex(indexPath.row) as? String
            button.frame=CGRectMake(0, 0, 0, 0)
            tableView.frame=CGRectMake(0, 0, 0, 0)
        }
        else{
        switch indexPath.row {
        case 0:
            break
        case 1:
            tableView1=UITableView(frame: CGRectMake(0, self.view.bounds.height/4*3, self.view.bounds.width, self.view.bounds.height/4))
            tableView1.delegate=self
            tableView1.dataSource=self
            button=UIButton(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height/4*3))
            button.backgroundColor=UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.5)
            self.view.addSubview(button)
            self.view.addSubview(tableView1)
            
        default:
            tableView2=UITableView(frame: CGRectMake(0, self.view.bounds.height/4*3, self.view.bounds.width, self.view.bounds.height/4))
            tableView2.delegate=self
            tableView2.dataSource=self
            button=UIButton(frame: CGRectMake(0,0,self.view.bounds.width,self.view.bounds.height/4*3))
            button.backgroundColor=UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.5)
            self.view.addSubview(button)
            self.view.addSubview(tableView2)
            }}
    }
    func PandKong()->Bool{
        if(roomNumL.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请选择房间数量"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(getToL.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请选择到达时间"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(nameTF.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入联系人"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(phoneTF.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入联系人手机号"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        
        return true
    }
    

    func nowYuding(){
        
        if PandKong()==true{
      
        let url = apiUrl+"bookingroom"
        let param = [
            "userid":"578",
            "goodsid":"12",
            "begintime":startzheng,
            "endtime":endzheng,
            "arrivetime":self.getToL.text!,
            "goodnum":self.roomNumL.text!,
            "peoplenum":"",
            "mobile":self.phoneTF.text!,
            "remark":self.beizhuTV.text!
            
            
        ]
        print(url)
        Alamofire.request(.GET, url, parameters: param as? [String : AnyObject]).response { request, response, json, error in
            if(error != nil){
            }
            else{
                print("request是")
                print(request!)
                print("====================")
                let status = Httpresult(JSONDecoder(json!))
                print(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 3)
                }
                if(status.status == "success"){
                    let userid = NSUserDefaults.standardUserDefaults()
                    userid.setValue(status.data?.id, forKey: "userid")
                    print("预定成功")
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text
                    hud.labelText = "恭喜您预定成功"
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 3)

                    let orderVC=HotelOrderViewController()
                    self.navigationController?.pushViewController(orderVC, animated: true)
                    
                }
            }
        }
        }
    }
        override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden=false
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        self.tabBarController?.tabBar.hidden=true
        
    }
   
}
