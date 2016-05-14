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

    internal var name=String()
    internal var bedsize=String()
    internal var repast=String()
    internal var network=String()
    internal var startTime=String()
    internal var endTime=String()
    internal var price=String()
    private var tableView0=UITableView()
    private var tableView1=UITableView()
    private var tableView2=UITableView()
 
    
    private var numArray=NSArray()
    private var timeArray=NSArray()
    private var button=UIButton()
    private var zongjiaL=UILabel()
    private var peoplenameTF=UITextField()
    private var peoplenumTF=UITextField()
    private var phoneTF=UITextField()
    private var remarkTV=UITextView()
    private var roomnumL=UILabel()
    private var arrivetimeL=UILabel()
    private var Zprice=Int()
    var startzheng=Int()
    var endzheng=Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.view.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""

        let view = UIView(frame: CGRectMake(0,64,self.view.bounds.width,60))
        view.backgroundColor=bkColor
        let nameL = UILabel(frame: CGRectMake(10,10,self.view.bounds.width-20,20))
        nameL.text=name
        nameL.textColor=textColor
        view.addSubview(nameL)
        let bedL = UILabel(frame: CGRectMake(10,30,self.view.bounds.width/4,20))
        bedL.textColor=textColor
        bedL.text=bedsize
        view.addSubview(bedL)
        let wifiL = UILabel(frame: CGRectMake(10+self.view.bounds.width/4,30,self.view.bounds.width/4,20))
        wifiL.text=network
        wifiL.textColor=textColor
        view.addSubview(wifiL)
        let foodL = UILabel(frame: CGRectMake(10+self.view.bounds.width/2,30,self.view.bounds.width/4,20))
        foodL.textColor=textColor
        
        foodL.textAlignment = .Right
        view.addSubview(foodL)
        let foodIV = UIImageView(frame: CGRectMake(10+(self.view.bounds.width/4*3),30,20,20))
        view.addSubview(foodIV)
        if repast=="1" {
            foodL.text="含早餐"
            foodIV.image=UIImage(named: "ic_zaocan-1")
        }else{
            foodL.text="不含早餐"
            foodIV.image=UIImage(named: "ic_zaocan")
        }

        tableView0=UITableView(frame: CGRectMake(0, 64, self.view.bounds.width, self.view.bounds.height-64), style: .Grouped)
        tableView0.delegate=self
        tableView0.dataSource=self
        tableView0.scrollEnabled=true
        tableView0.backgroundColor=bkColor

        tableView0.tableHeaderView=view

        self.view.addSubview(tableView0)
        
        numArray=["1间","2间","3间","4间","5间","6间"]
        timeArray=["18:00之前","20:00之前","23:59之前","次日凌晨六点之前"]
        self.automaticallyAdjustsScrollViewInsets=false
        let priceL = UILabel(frame: CGRectMake(0,self.view.bounds.height-40,self.view.bounds.width/2,40))
        priceL.backgroundColor=UIColor.whiteColor()
        priceL.text="  总价："
        self.view.addSubview(priceL)
        zongjiaL = UILabel(frame: CGRectMake(70,self.view.bounds.height-40,self.view.bounds.width/2-70,40))
        zongjiaL.backgroundColor=UIColor.whiteColor()
        zongjiaL.text=price
        self.view.addSubview(zongjiaL)
        let yudingBT = UIButton(frame: CGRectMake(self.view.bounds.width/2,self.view.bounds.height-40,self.view.bounds.width/2,40))
        yudingBT.backgroundColor=UIColor.init(red: 250/255, green: 140/255, blue: 61/255, alpha: 1)
        yudingBT.setTitle("立即预订", forState: UIControlState.Normal)
        yudingBT.addTarget(self, action: #selector(nowYuding), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(yudingBT)

        //添加手势，点击空白处收回键盘
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewtap))
        tap.cancelsTouchesInView=false
        self.view.addGestureRecognizer(tap)
       // 时间转时间戳
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
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        if tableView==tableView0 {
            return 2
        }else{
            return 1
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if tableView==tableView1 {
            return numArray.count
        }
        else if tableView==tableView2{
            return timeArray.count
        }
        else{
            
            if section==0{
                return 3
            }else{
                return 4
            }
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
            if indexPath.section==0 {
                
                let identi = "cell0"
                
        let cell = UITableViewCell(style: .Default, reuseIdentifier: identi)
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        
                
             
                
               switch indexPath.row {
              
        case 0:
            
            cell.textLabel?.text=startTime+"入住"+endTime+"离店"
            cell.textLabel?.textColor=textColor
                tableView0.rowHeight=44
                
                
        case 1:
            cell.textLabel?.text="房间数"
            cell.textLabel?.textColor=textColor
                tableView0.rowHeight=44
                roomnumL = UILabel(frame: CGRectMake(self.view.bounds.width/2,10,self.view.bounds.width/2-30,24))
                cell.addSubview(roomnumL)
        default:
            
            cell.textLabel?.text="预计到达"
            cell.textLabel?.textColor=textColor
                tableView0.rowHeight=44
                arrivetimeL = UILabel(frame: CGRectMake(self.view.bounds.width/2,10,self.view.bounds.width/2-30,24))
                cell.addSubview(arrivetimeL)
            }
                return cell
            }else
            {
                let identifier = "cell"
                let cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
                if indexPath.row==0 {
                    cell.textLabel?.text="预定人姓名"
                    cell.textLabel?.textColor=textColor
                    tableView0.rowHeight=44
                    peoplenameTF = UITextField(frame: CGRectMake(self.view.bounds.width-200,5,200,44-10))
                    peoplenameTF.clearButtonMode=UITextFieldViewMode.Always
                    peoplenameTF.textAlignment = .Right
                    cell.addSubview(peoplenameTF)
                }else if indexPath.row==1 {
                    cell.textLabel?.text="入住人数"
                    cell.textLabel?.textColor=textColor
                    tableView0.rowHeight=44
                    peoplenumTF = UITextField(frame: CGRectMake(self.view.bounds.width-200,5,200,44-10))
                    peoplenumTF.clearButtonMode=UITextFieldViewMode.Always
                    peoplenumTF.textAlignment = .Right
                    cell.addSubview(peoplenumTF)

                }else if indexPath.row==2 {
                    cell.textLabel?.text="预定人手机号"
                    cell.textLabel?.textColor=textColor
                    tableView0.rowHeight=44
                    phoneTF = UITextField(frame: CGRectMake(self.view.bounds.width-200,5,200,44-10))
                    phoneTF.clearButtonMode=UITextFieldViewMode.Always
                    phoneTF.textAlignment = .Right
                    cell.addSubview(phoneTF)

                }else if indexPath.row==3 {
                    cell.textLabel?.text="备注"
                    cell.textLabel?.textColor=textColor
                    tableView0.rowHeight=80
                    remarkTV = UITextView(frame: CGRectMake(60, 10, self.view.bounds.width-70, 50))
                    remarkTV.layer.borderColor=textColor.CGColor
                    remarkTV.layer.borderWidth=1
                    remarkTV.layer.cornerRadius=6
                    remarkTV.layer.masksToBounds=true
                    cell.addSubview(remarkTV)

                }

                return cell
            }

        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView==tableView1 {
            
            roomnumL.text = numArray.objectAtIndex(indexPath.row)as? String
            if roomnumL.text=="1间" {
                 Zprice=Int(price)!
            }else if roomnumL.text=="2间"{
                Zprice=Int(price)!*2
            }else if roomnumL.text=="3间"{
                Zprice=Int(price)!*3
            }else if roomnumL.text=="4间"{
                Zprice=Int(price)!*4
            }else if roomnumL.text=="5间"{
                Zprice=Int(price)!*5
            }else if roomnumL.text=="6间"{
                Zprice=Int(price)!*6
            }
            
            zongjiaL.text=String(Zprice)

            button.frame=CGRectMake(0, 0, 0, 0)
            tableView.frame=CGRectMake(0, 0, 0, 0)
        }
        else if tableView==tableView2{
            arrivetimeL.text=timeArray.objectAtIndex(indexPath.row) as? String
            button.frame=CGRectMake(0, 0, 0, 0)
            tableView.frame=CGRectMake(0, 0, 0, 0)
        }
        else{
            if indexPath.section==0 {
                
        
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
                }}}
    }
    func PandKong()->Bool{
        if(roomnumL.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请选择房间数量"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(arrivetimeL.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请选择到达时间"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(peoplenameTF.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入联系人"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(peoplenumTF.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入入住人数"
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
            "arrivetime":arrivetimeL.text!,
            "goodnum":roomnumL.text!,
            "peoplenum":peoplenumTF.text!,
            "mobile":self.phoneTF.text!,
            "remark":self.remarkTV.text!,
            "money":zongjiaL.text!,
            "peoplename":peoplenameTF.text!
            
            
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

//                    let orderVC=HotelOrderViewController()
//                    self.navigationController?.pushViewController(orderVC, animated: true)
                    
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
    //隐藏键盘的方法
    func viewtap(){
        self.view.endEditing(true)
        //
    }


}
