//
//  OrderFoodViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/10.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class OrderFoodViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    private var tableView=UITableView()
    private var imageView=UIImageView()
    private var num = Int()
    internal var price=String()
    private var numL = UILabel()
    private var delBT=UIButton()
    private var addBT=UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="立即预订"
        
        
//tableView
        
        tableView=UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height), style: UITableViewStyle.Grouped)
        tableView.delegate=self
        tableView.dataSource=self
//UIimageView
        imageView=UIImageView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.width*0.5))
        imageView.image=UIImage(named: "food1.png")
        
        tableView.tableHeaderView=imageView
        self.view.addSubview(tableView)
        
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
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    {
        if section == 0
        {
            return 4
        }
        else
        {
            return 6
        }
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell()
        cell.selectionStyle = .None
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel?.text="经典西式早餐"
                let priceL = UILabel(frame: CGRectMake(self.view.bounds.width-80,5,80,44-10))
                price="30"
                priceL.text="¥\(price)/份"
                priceL.textAlignment = .Right
                cell.addSubview(priceL)
                
            }else if indexPath.row==1{
                cell.textLabel?.text="数量"
                delBT = UIButton(frame: CGRectMake(self.view.bounds.width-80,10,20,24))
                delBT.backgroundColor=bkColor
                delBT.layer.borderWidth=1.0
                delBT.layer.backgroundColor=bkColor.CGColor
                delBT.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                delBT.setTitle("-", forState: UIControlState.Normal)
                delBT.setTitle("", forState: .Highlighted)
                delBT.addTarget(self, action: #selector(delNum), forControlEvents: UIControlEvents.TouchUpInside)
                numL = UILabel(frame: CGRectMake(self.view.bounds.width-60,10,30,24))
                
                num=1
                
                numL.text = String(num)
                numL.textAlignment = .Center
                numL.layer.borderWidth=1.0
                addBT = UIButton(frame: CGRectMake(self.view.bounds.width-30,10,20,24))
                addBT.backgroundColor=bkColor
                addBT.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
                addBT.setTitle("+", forState: UIControlState.Normal)
                addBT.setTitle("", forState: .Highlighted)
                addBT.addTarget(self, action: #selector(addNum), forControlEvents: UIControlEvents.TouchUpInside)
                addBT.layer.borderWidth=1.0
                addBT.layer.backgroundColor=bkColor.CGColor
                
                cell.addSubview(delBT)
                cell.addSubview(addBT)
                cell.addSubview(numL)
                
            }
            else if indexPath.row==2{
                cell.textLabel?.text="小计"
                let priceL = UILabel(frame: CGRectMake(self.view.bounds.width-80,5,80,44-10))
                priceL.text="¥\(price)/份"
                priceL.textAlignment = .Right
                cell.addSubview(priceL)
            }
            else if indexPath.row==3{
                cell.textLabel?.text="总价"
                let pricenum = Int(price)!*num
                
                let priceL = UILabel(frame: CGRectMake(self.view.bounds.width-80,5,80,44-10))
                priceL.text=String(pricenum)
                priceL.textAlignment = .Right
                cell.addSubview(priceL)
            }
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.textLabel?.text="联系人"
                let nameTF = UITextField(frame: CGRectMake(self.view.bounds.width-300,5,300,44-10))
                nameTF.clearButtonMode=UITextFieldViewMode.Always
                nameTF.textAlignment = .Right
                cell.addSubview(nameTF)
            }else if indexPath.row==1{
                cell.textLabel?.text="手机号"
                let phoneTF = UITextField(frame: CGRectMake(self.view.bounds.width-300,5,300,44-10))
                phoneTF.clearButtonMode=UITextFieldViewMode.Always
                phoneTF.textAlignment = .Right
                cell.addSubview(phoneTF)
            }
            else if indexPath.row==2{
                cell.textLabel?.text="就餐人数"
                let phoneTF = UITextField(frame: CGRectMake(self.view.bounds.width-300,5,300,44-10))
                phoneTF.clearButtonMode=UITextFieldViewMode.Always
                phoneTF.textAlignment = .Right
                cell.addSubview(phoneTF)
            }
            else if indexPath.row==3{
                cell.textLabel?.text="就餐日期"
               
            }
            else if indexPath.row==4{
                cell.textLabel?.text="就餐时间"
                let phoneTF = UITextField(frame: CGRectMake(self.view.bounds.width-300,5,300,44-10))
                phoneTF.clearButtonMode=UITextFieldViewMode.Always
                phoneTF.textAlignment = .Right
                cell.addSubview(phoneTF)
                
            }

            else if indexPath.row==5{
                cell.textLabel?.text="备注"
                let textView = UITextView(frame: CGRectMake(60, 10, self.view.bounds.width-60, 50))
                cell.addSubview(textView)
                tableView.rowHeight=80
            }

        }

        
        return cell
        
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var titlestr=String()
        if section==0 {
            titlestr = "美食信息"
            
        }else if section==1
        {
            titlestr = "就餐信息"
            
        }
        return titlestr
    }
    func delNum(){
        print("减")
        num -= 1
        if num == 0 {
            delBT.userInteractionEnabled=false
        }
        numL.text = String(num)
//        numL.reloadInputViews()
        
    }
    func addNum(){
        print("加")
        num+=1
        numL.text = String(num)
//        numL.reloadInputViews()
    }
    func PandKong()->Bool{
//        if(roomNumL.text!.isEmpty){
//            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//            hud.mode = MBProgressHUDMode.Text
//            hud.labelText = "请选择房间数量"
//            hud.margin = 10.0
//            hud.removeFromSuperViewOnHide = true
//            hud.hide(true, afterDelay: 1)
//            return false
//        }
//        if(getToL.text!.isEmpty){
//            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//            hud.mode = MBProgressHUDMode.Text
//            hud.labelText = "请选择到达时间"
//            hud.margin = 10.0
//            hud.removeFromSuperViewOnHide = true
//            hud.hide(true, afterDelay: 1)
//            return false
//        }
//        if(nameTF.text!.isEmpty){
//            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//            hud.mode = MBProgressHUDMode.Text
//            hud.labelText = "请输入联系人"
//            hud.margin = 10.0
//            hud.removeFromSuperViewOnHide = true
//            hud.hide(true, afterDelay: 1)
//            return false
//        }
//        if(phoneTF.text!.isEmpty){
//            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
//            hud.mode = MBProgressHUDMode.Text
//            hud.labelText = "请输入联系人手机号"
//            hud.margin = 10.0
//            hud.removeFromSuperViewOnHide = true
//            hud.hide(true, afterDelay: 1)
//            return false
//        }
        
        return true
    }

    
    func nowYuding(){
        
        if PandKong()==true{
            
            let url = apiUrl+"bookingcatering"
            let param = [
                "userid":578,
                "goodsid":"12",
                "repasttime":"",
                "goodnum":"",
                "peoplenum":"",
                "mobile":"",
                "remark":""
                
                
            ]
            print(url)
            Alamofire.request(.GET, url, parameters: param as? [String : NSObject]).response { request, response, json, error in
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
                        
                        
                        
                    }
                }
            }
        }
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
