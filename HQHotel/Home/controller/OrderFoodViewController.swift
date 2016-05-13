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
    internal var name=String()
    private var numL = UILabel()
    private var delBT=UIButton()
    private var addBT=UIButton()
    private var pricenum=Int()
    private var priceZ=UILabel()
    private var nameTF=UITextField()
    private var phoneTF=UITextField()
    private var numTF=UITextField()
    private var riqiTF=UITextField()
    private var timeTF=UITextField()
    private var textView=UITextView()
    private var zongjiaL=UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title="立即预订"
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""

        
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
        priceL.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
        self.view.addSubview(priceL)
        zongjiaL = UILabel(frame: CGRectMake(70,self.view.bounds.height-40,self.view.bounds.width/2-70,40))
        zongjiaL.backgroundColor=UIColor.whiteColor()
        zongjiaL.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
        self.view.addSubview(zongjiaL)
        let yudingBT = UIButton(frame: CGRectMake(self.view.bounds.width/2,self.view.bounds.height-40,self.view.bounds.width/2,40))
        yudingBT.backgroundColor=UIColor.init(red: 250/255, green: 140/255, blue: 61/255, alpha: 1)
        yudingBT.setTitle("提交订单", forState: UIControlState.Normal)
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
        
        let cellidentifier:String = "cell"
        let cell:UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: cellidentifier)
        
        
        cell.selectionStyle = .None
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel?.text=name
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                let priceL = UILabel(frame: CGRectMake(self.view.bounds.width-90,5,80,44-10))
                priceL.text="¥\(price)/份"
                priceL.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                priceL.textAlignment = .Right
                cell.addSubview(priceL)
                tableView.rowHeight=44
                
            }else if indexPath.row==1{
                cell.textLabel?.text="数量"
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                delBT = UIButton(frame: CGRectMake(self.view.bounds.width-80,10,20,24))
                delBT.backgroundColor=bkColor
                delBT.layer.borderWidth=1.0
                delBT.layer.backgroundColor=bkColor.CGColor
                delBT.layer.masksToBounds=true
                delBT.setTitleColor(UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1), forState: UIControlState.Normal)
                delBT.setTitle("-", forState: UIControlState.Normal)
                delBT.setTitle("", forState: .Highlighted)
                delBT.addTarget(self, action: #selector(delNum), forControlEvents: UIControlEvents.TouchUpInside)
                numL = UILabel(frame: CGRectMake(self.view.bounds.width-60,10,30,24))
                
                num=1
                
                numL.text = String(num)
                numL.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                numL.textAlignment = .Center
                numL.layer.borderWidth=1.0
                addBT = UIButton(frame: CGRectMake(self.view.bounds.width-30,10,20,24))
                addBT.backgroundColor=bkColor
                addBT.setTitleColor(UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1), forState: UIControlState.Normal)
                addBT.setTitle("+", forState: UIControlState.Normal)
                addBT.setTitle("", forState: .Highlighted)
                addBT.addTarget(self, action: #selector(addNum), forControlEvents: UIControlEvents.TouchUpInside)
                addBT.layer.borderWidth=1.0
                addBT.layer.backgroundColor=bkColor.CGColor
                
                cell.addSubview(delBT)
                cell.addSubview(addBT)
                cell.addSubview(numL)
                tableView.rowHeight=44
                
            }
            else if indexPath.row==2{
                cell.textLabel?.text="小计"
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                let priceL = UILabel(frame: CGRectMake(self.view.bounds.width-90,5,80,44-10))
                priceL.text="¥\(price)"
                priceL.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                priceL.textAlignment = .Right
                cell.addSubview(priceL)
                tableView.rowHeight=44
            }
            else if indexPath.row==3{
                cell.textLabel?.text="总价"
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                pricenum = Int(price)!*num
                zongjiaL.text=String(pricenum)
                priceZ = UILabel(frame: CGRectMake(self.view.bounds.width-90,5,80,44-10))
                priceZ.text=String(pricenum)
                priceZ.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                priceZ.textAlignment = .Right
                cell.addSubview(priceZ)
                tableView.rowHeight=44
            }
        }else if indexPath.section == 1 {
            if indexPath.row == 0 {
                cell.textLabel?.text="联系人"
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                nameTF = UITextField(frame: CGRectMake(self.view.bounds.width-300,5,300,44-10))
                nameTF.clearButtonMode=UITextFieldViewMode.Always
                nameTF.textAlignment = .Right
                nameTF.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                cell.addSubview(nameTF)
                tableView.rowHeight=44
            }else if indexPath.row==1{
                cell.textLabel?.text="手机号"
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                phoneTF = UITextField(frame: CGRectMake(self.view.bounds.width-300,5,300,44-10))
                phoneTF.clearButtonMode=UITextFieldViewMode.Always
                phoneTF.textAlignment = .Right
                phoneTF.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                cell.addSubview(phoneTF)
                tableView.rowHeight=44
            }
            else if indexPath.row==2{
                cell.textLabel?.text="房间号"
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                numTF = UITextField(frame: CGRectMake(self.view.bounds.width-300,5,300,44-10))
                numTF.clearButtonMode=UITextFieldViewMode.Always
                numTF.textAlignment = .Right
                numTF.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                cell.addSubview(numTF)
                tableView.rowHeight=44
            }
            else if indexPath.row==3{
                cell.textLabel?.text="就餐人数"
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                riqiTF = UITextField(frame: CGRectMake(self.view.bounds.width-300,5,300,44-10))
                riqiTF.clearButtonMode=UITextFieldViewMode.Always
                riqiTF.textAlignment = .Right
                riqiTF.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                cell.addSubview(riqiTF)
               tableView.rowHeight=44
            }
            else if indexPath.row==4{
                cell.textLabel?.text="就餐时间"
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                timeTF = UITextField(frame: CGRectMake(self.view.bounds.width-200,5,200,44-10))
                timeTF.clearButtonMode=UITextFieldViewMode.Always
                timeTF.textAlignment = .Right
                timeTF.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                cell.addSubview(timeTF)
                tableView.rowHeight=44
                
            }

            else if  indexPath.row==5{
                cell.textLabel?.text="备注"
                cell.textLabel?.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                textView = UITextView(frame: CGRectMake(60, 10, self.view.bounds.width-70, 50))
                textView.layer.borderColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1).CGColor
                textView.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
                textView.layer.borderWidth=1
                textView.layer.cornerRadius=6
                textView.layer.masksToBounds=true
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
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 0
    }
    func delNum(){
        print("减")
        num -= 1
        if num == 0 {
            delBT.userInteractionEnabled=false
        }else{
            delBT.userInteractionEnabled=true
        }
        numL.text = String(num)
        pricenum = Int(price)!*num
        priceZ.text=String(pricenum)
        zongjiaL.text=String(pricenum)

    }
    func addNum(){
        print("加")
        num+=1
        numL.text = String(num)
        pricenum = Int(price)!*num
        priceZ.text=String(pricenum)
        zongjiaL.text=String(pricenum)

    }
    func PandKong()->Bool{
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
            hud.labelText = "请输入手机号"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(numTF.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入就餐人数"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(riqiTF.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入就餐日期"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(timeTF.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入就餐时间"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }

        
        return true
    }

    
    func nowYuding(){
        
        if PandKong()==true{
            
            let url = apiUrl+"bookingcatering"
            let param = [
                "userid":578,
                "goodsid":"12",
                "repasttime":timeTF,
                "goodnum":numL,
                "peoplenum":numTF,
                "mobile":phoneTF,
                "remark":textView
                
                
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
