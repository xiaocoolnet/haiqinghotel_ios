//
//  mallOrderViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/13.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class mallOrderViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    private var tableView=UITableView()
    private var zongjiaL=UILabel()
    private var delBT=UIButton()
    private var addBT=UIButton()
    private var numL=UILabel()
    private var num=Int()
    private var textView=UITextView()
    override func viewDidLoad() {
        super.viewDidLoad()

        let view = UIView(frame: CGRectMake(0,64,self.view.bounds.width,150))
        let view1 = UIView(frame: CGRectMake(0,10,self.view.bounds.width,110))
        view1.backgroundColor=UIColor.whiteColor()
        view.addSubview(view1)
        let imageView = UIImageView(frame: CGRectMake(10, 10, 100, 90))
        imageView.image=UIImage(named: "海参.jpg")
        view1.addSubview(imageView)
        let nameL = UILabel(frame: CGRectMake(120,10,self.view.bounds.width-120,40))
        nameL.lineBreakMode=NSLineBreakMode.ByWordWrapping
        nameL.numberOfLines=0
        view1.addSubview(nameL)
        let priceL = UILabel(frame: CGRectMake(self.view.bounds.width-50,50,50,30))
        priceL.textColor=BTColor
        view1.addSubview(priceL)
        tableView=UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height), style: .Plain)
        tableView.tableHeaderView=view
        tableView.delegate=self
        tableView.dataSource=self
        tableView.backgroundColor=bkColor
        self.view.addSubview(tableView)
        let price = UILabel(frame: CGRectMake(0,self.view.bounds.height-40,self.view.bounds.width/2,40))
        price.backgroundColor=UIColor.whiteColor()
        price.text="  总价："
        self.view.addSubview(price)
        zongjiaL = UILabel(frame: CGRectMake(70,self.view.bounds.height-40,self.view.bounds.width/2-70,40))
        zongjiaL.backgroundColor=UIColor.whiteColor()
        zongjiaL.textColor=UIColor.init(red: 39/255, green: 178/255, blue: 252/255, alpha: 1)
        
        self.view.addSubview(zongjiaL)
        let yudingBT = UIButton(frame: CGRectMake(self.view.bounds.width/2,self.view.bounds.height-40,self.view.bounds.width/2,40))
        yudingBT.backgroundColor=UIColor.init(red: 250/255, green: 140/255, blue: 61/255, alpha: 1)
        yudingBT.setTitle("立即预订", forState: UIControlState.Normal)
        yudingBT.addTarget(self, action: #selector(yuding), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(yudingBT)

        
    }
   
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
            return 5

       
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
            
        
        let identifier = "cell"
        let cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        if indexPath.row==0 {
            cell.textLabel?.text="数量"
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

        }else if indexPath.row==1 {
            cell.textLabel?.text="联系人"
            tableView.rowHeight=44
        }else if indexPath.row==2{
            cell.textLabel?.text="房间号"
            tableView.rowHeight=44
        }else if indexPath.row==3{
            cell.textLabel?.text="手机号"
            tableView.rowHeight=44
        }else{
            cell.textLabel?.text="备注"
            textView = UITextView(frame: CGRectMake(60, 10, self.view.bounds.width-70, 50))
            textView.layer.borderColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1).CGColor
            textView.textColor=UIColor.init(red: 57/255, green: 58/255, blue: 59/255, alpha: 1)
            textView.layer.borderWidth=1
            textView.layer.cornerRadius=6
            textView.layer.masksToBounds=true
            cell.addSubview(textView)
            tableView.rowHeight=80

        }
        return cell
        
        
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
//        pricenum = Int(price)!*num
//        priceZ.text=String(pricenum)
//        zongjiaL.text=String(pricenum)
        
    }
    func addNum(){
        print("加")
        num+=1
        numL.text = String(num)
//        pricenum = Int(price)!*num
//        priceZ.text=String(pricenum)
//        zongjiaL.text=String(pricenum)
//        
    }

    func yuding(){
        
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
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
