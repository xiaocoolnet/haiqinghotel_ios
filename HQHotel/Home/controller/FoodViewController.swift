//
//  FoodViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/5.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class FoodViewController: UITabBarController,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource {
    
    private var scrollView:UIScrollView!
    private let numOfPages=4
    var num=0
    
    let jianjieView = UIView()
    var taocanTable = UITableView()
    let bottm = UILabel()
    let yuanjia = UILabel()
    let priceOld = UILabel()
    let xiuhuijia = UILabel()
    let priceNew = UILabel()

    let shimenjia = UILabel()
    let youhuijia = UILabel()
    let priceMen = UILabel()
    let priceHui = UILabel()
    let line = UILabel()
    
    let business = UILabel()
    let busContact = UILabel()
    
    var caterSoutce = CaterModel()
    
    var count = Int()
    
    
    override func viewDidLoad() {
        self.scrollViewGet()
        
        shimenjia.frame = CGRectMake(0, self.view.bounds.width*0.5+94, WIDTH/3, 20)
        shimenjia.textColor = UIColor.grayColor()
        shimenjia.textAlignment = .Center
        shimenjia.font = UIFont.systemFontOfSize(12)
        shimenjia.text = "门市价"
        youhuijia.frame = CGRectMake(WIDTH/3, self.view.bounds.width*0.5+94, WIDTH/3, 20)
        youhuijia.textColor = UIColor.grayColor()
        youhuijia.textAlignment = .Center
        youhuijia.font = UIFont.systemFontOfSize(12)
        youhuijia.text = "优惠价"
        
        line.frame = CGRectMake(WIDTH/3, self.view.bounds.width*0.5+64, 1, 60)
        line.backgroundColor = UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        priceMen.frame = CGRectMake(0, self.view.bounds.width*0.5+74, WIDTH/3, 20)
        priceMen.textAlignment = .Center
        priceMen.font = UIFont.systemFontOfSize(14)
        
        priceHui.frame = CGRectMake(WIDTH/3, self.view.bounds.width*0.5+74, WIDTH/3, 20)
        priceHui.textAlignment = .Center
        priceHui.font = UIFont.systemFontOfSize(15)
        priceHui.textColor = UIColor.orangeColor()
        
        
        for i in 0...2 {
            let titLab = UILabel()

            titLab.frame = CGRectMake(0+CGFloat(i)*self.view.bounds.width/3, self.view.bounds.width*0.5+64, self.view.bounds.width/3, 60)
            titLab.tag = i
            titLab.backgroundColor = UIColor.whiteColor()
            self.view.addSubview(titLab)
            
            if titLab.tag == 2 {
                titLab.backgroundColor = UIColor.orangeColor()
                titLab.text = "立即预订"
                titLab.textColor = UIColor.whiteColor()
                titLab.textAlignment = .Center
            }
            
        }

        self.view.addSubview(shimenjia)
        self.view.addSubview(youhuijia)
        self.view.addSubview(line)
        self.view.addSubview(priceMen)
        self.view.addSubview(priceHui)
        
        jianjieView.frame = CGRectMake(0, self.view.bounds.width*0.5+134, self.view.bounds.width, 150)
        jianjieView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(jianjieView)
        
        business.frame = CGRectMake(10, 5, 100, 20)
        business.text = "商品描述"
        business.font = UIFont.systemFontOfSize(13)
        jianjieView.addSubview(business)
        
        busContact.frame = CGRectMake(10, 25, WIDTH-20, 125)
        busContact.font = UIFont.systemFontOfSize(12)
        busContact.numberOfLines = 0
        busContact.text = "-你说过的话，一句一句，如同星光般洒落，独自仰望的夜空，会惧怕被深不见底的夜吸进去，和阿渡一起仰望的星空变幻不定，和小椿一起仰望的星空，光辉灿烂却隐隐透着不安。和你一同仰望的星空，是怎样的呢？"
        jianjieView.addSubview(busContact)
        
        taocanTable.frame = CGRectMake(0, self.view.bounds.width*0.5+294, WIDTH, 136)
        taocanTable.delegate = self
        taocanTable.dataSource = self
        taocanTable.registerClass(BreakTableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(taocanTable)
        taocanTable.scrollEnabled = false
        
        bottm.frame = CGRectMake(0, self.view.bounds.height-50, WIDTH, 50)
        bottm.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(bottm)
        
        yuanjia.frame = CGRectMake(WIDTH-200, self.view.bounds.height-40, 50, 30)
        yuanjia.textAlignment = .Right
        yuanjia.text = "价值："
        priceOld.frame = CGRectMake(WIDTH-150, self.view.bounds.height-40, 45, 30)
        xiuhuijia.frame = CGRectMake(WIDTH-110, self.view.bounds.height-40, 60, 30)
        xiuhuijia.textAlignment = .Right
        xiuhuijia.text = "优惠价："
        priceNew.frame = CGRectMake(WIDTH-50, self.view.bounds.height-40, 50, 30)
        priceNew.textColor = UIColor.orangeColor()
        
        yuanjia.font = UIFont.systemFontOfSize(14)
        priceOld.font = UIFont.systemFontOfSize(14)
        xiuhuijia.font = UIFont.systemFontOfSize(14)
        priceNew.font = UIFont.systemFontOfSize(15)
        
        self.view.addSubview(yuanjia)
        self.view.addSubview(priceOld)
        self.view.addSubview(xiuhuijia)
        self.view.addSubview(priceNew)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count+1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)as!BreakTableViewCell
        cell.selectionStyle = .None
        
        cell.content.text = "刷卡的"
        cell.guige.text = "2分"
        cell.danjia.text = "¥22"
        
        if indexPath.row == 0 {
            cell.content.textColor = UIColor.grayColor()
            cell.danjia.textColor = UIColor.grayColor()
            cell.guige.textColor = UIColor.grayColor()
            cell.content.text = "套餐内容"
            cell.guige.text = "规格"
            cell.danjia.text = "单价"
        }
        
        
        return cell
    }
    
//    滚动视图
    func scrollViewGet() {
        self.automaticallyAdjustsScrollViewInsets=false
        let frame = self.view.bounds
        //滚动式图
        let scrollview_h = frame.width*0.50
        
        scrollView = UIScrollView(frame: CGRectMake(0, 64, frame.width, scrollview_h))
        
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPointZero
        
        // 将 scrollView 的 contentSize 设为屏幕宽度的3倍(根据实际情况改变)
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(numOfPages), height: scrollview_h)
        scrollView.delegate = self
        
        //滚动式图添加图片
        for index  in 0..<numOfPages {
            let imageView = UIImageView(image: UIImage(named: "food\(index+1).png"))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: scrollview_h)
            scrollView.addSubview(imageView)
        }
        
        //滚动视图添加小白点
        let pageC = UIPageControl()
        pageC.frame=CGRectMake(frame.size.width-60, 66+scrollview_h-30, 40, 20)
        
        pageC.tag=102
        pageC.numberOfPages=4
        pageC.addTarget(self, action: #selector(dopageC), forControlEvents: UIControlEvents.ValueChanged )
        
        //将滚动式图添加到view上
        self.view.addSubview(scrollView)
        
        //将小白点添加到滚动视图
        self.view.addSubview(pageC)
        //定时器
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector (doTime), userInfo: nil, repeats: true)
        
    }
    //执行定时器方法
    func doTime(){
        
        
        let pageC = self.view.viewWithTag(102) as! UIPageControl
        pageC.currentPage=num
        self.dopageC(pageC)
        num += 1
        if num==4 {
            num=0
        }
    }
    //点击小白点，图片移动
    func dopageC(sender:UIPageControl){
        var x = CGFloat()
        x=CGFloat(sender.currentPage)*self.view.bounds.width
        var rect = CGRect()
        rect=CGRectMake(x,64 , self.view.bounds.width, self.view.bounds.height-400)
        scrollView.scrollRectToVisible(rect, animated: true)
    }
    //小白点移动
    func scrollViewDidEndDecelerating(scrollView: UIScrollView){
        
        let frame = self.view.bounds
        
        let pageC = self.view.viewWithTag(102) as! UIPageControl
        
        pageC.currentPage = Int(scrollView.contentOffset.x/frame.width)
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.GetDate()
        
    }
    //餐饮界面
    func GetDate(){
        let url = apiUrl+"showcateringinfo"
        //        let userid = NSUserDefaults.standardUserDefaults()
        //        let uid = userid.stringForKey("userid")
        let param = [
            "id":12
        ]
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
            }
            else{
                
                let status = CaterModel(JSONDecoder(json!))
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
                    self.priceMen.text = status.data?.foodOprice
                    self.priceHui.text = status.data?.foodPrice
                    self.busContact.text = status.data?.foodDescription
                    self.priceOld.text = "¥"+(status.data?.foodOprice)!
                    self.priceNew.text = "¥"+(status.data?.foodPrice)!
                    self.count = status.data?.goodList?.array?.count
                }
                
            }
        }
    }

//    override func viewWillDisappear(animated: Bool) {
//        self.tabBarController?.tabBar.hidden=false
//    }
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