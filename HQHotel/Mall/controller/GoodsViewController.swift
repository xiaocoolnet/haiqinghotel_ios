//
//  GoodsViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/19.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class GoodsViewController: UIViewController ,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource{

    private var scrollView=UIScrollView()
    private var tableview=UITableView()
    private let numOfPages=4
    var num=0
    internal var price=String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = self.view.bounds
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""

        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        self.view.backgroundColor=bkColor
        scrollViewGet()
        tableview=UITableView(frame: CGRectMake(0, frame.width*0.5+64, frame.width, frame.height-(frame.width*0.5+64)), style: .Grouped)
        tableview.delegate=self
        tableview.dataSource=self
        
        
        
        self.view.addSubview(tableview)
        let gouwucheBT = UIButton(frame: CGRectMake(0,self.view.bounds.height-40,self.view.bounds.width/2,40))
        gouwucheBT.backgroundColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        gouwucheBT.setTitle("加入购物车", forState: UIControlState.Normal)
        gouwucheBT.addTarget(self, action: #selector(gouwuche), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(gouwucheBT)
        let yudingBT = UIButton(frame: CGRectMake(self.view.bounds.width/2,self.view.bounds.height-40,self.view.bounds.width/2,40))
        yudingBT.backgroundColor=UIColor.init(red: 250/255, green: 140/255, blue: 61/255, alpha: 1)
        yudingBT.setTitle("立即预订", forState: UIControlState.Normal)
        yudingBT.addTarget(self, action: #selector(yuding), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(yudingBT)
        
    }
     func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if section==0 {
            return 1
        }else if section==1{
            return 6
        }
        else{
        return 1
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let identifier:String = "cell"
        let cell:UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        if indexPath.section==0 {
            
            let lable : UILabel!
            lable=UILabel(frame: CGRectMake(5,5,self.view.bounds.width-10,50))
            lable.text="jhgdsgdudhewjshbxjwehbdjfhewbdjanbxjewhbdiewhbfkjwbmasbdjbefjb"
            lable.numberOfLines=0
            cell.addSubview(lable)
            let priceL = UILabel(frame: CGRectMake(5,60,self.view.bounds.width/2,25))
            priceL.textColor=textColor
            priceL.text=price
            cell.addSubview(priceL)
            let loveBT = UIButton(frame: CGRectMake(self.view.bounds.width-40,50,40,20))
            loveBT.setImage(UIImage(named: "爱心"), forState: UIControlState.Normal)
            loveBT.addTarget(self, action: #selector(love), forControlEvents: .TouchUpInside)
            cell.addSubview(loveBT)
            let loveL = UILabel(frame: CGRectMake(self.view.bounds.width-35,75,40,10))
            loveL.font=UIFont.systemFontOfSize(12)
            loveL.text="喜欢"
            cell.addSubview(loveL)
            
            
            tableview.rowHeight=90
        }else if indexPath.section==1 {
            let informationL = UILabel(frame: CGRectMake(self.view.bounds.width-80,5,self.view.bounds.width-80,34))
            informationL.textAlignment = .Right
            if indexPath.row==0 {
                tableView.rowHeight=44
                cell.textLabel?.text="配料表"
                cell.textLabel?.textColor=textColor
                informationL.text=""
                informationL.textColor=textColor
                cell.addSubview(informationL)
                
            }else if indexPath.row==1{
                tableView.rowHeight=44
                cell.textLabel?.text="储存方式"
                cell.textLabel?.textColor=textColor
                informationL.text=""
                informationL.textColor=textColor
                cell.addSubview(informationL)
            }else if indexPath.row==2{
                tableView.rowHeight=44
                cell.textLabel?.text="生产日期"
                cell.textLabel?.textColor=textColor
                informationL.text=""
                informationL.textColor=textColor
                cell.addSubview(informationL)
            }else if indexPath.row==3{
                tableView.rowHeight=44
                cell.textLabel?.text="保质期"
                cell.textLabel?.textColor=textColor
                informationL.text=""
                informationL.textColor=textColor
                cell.addSubview(informationL)
            }else if indexPath.row==4{
                tableView.rowHeight=44
                cell.textLabel?.text="食品添加剂"
                cell.textLabel?.textColor=textColor
                informationL.text=""
                informationL.textColor=textColor
                cell.addSubview(informationL)
            }else if indexPath.row==5{
                tableView.rowHeight=44
                cell.textLabel?.text="净含量"
                cell.textLabel?.textColor=textColor
                informationL.text=""
                informationL.textColor=textColor
                cell.addSubview(informationL)
            }
            
            
            
        }else{
            
            let imageV = UIImageView(frame: CGRectMake(5, 5, self.view.bounds.width-10, 100))
            imageV.image=UIImage(named: "海参.jpg")
            tableView.rowHeight=110
            cell.addSubview(imageV)
            
        }
        
        
        return cell
    }
    func love(){
        print("已加入收藏")
    }
    func yuding(){
        let mallVC = mallOrderViewController()
        mallVC.price=Int(price)!
        self.navigationController?.pushViewController(mallVC, animated: true)
        
    }
    func gouwuche(){
        print("gouwuche")
    }
    //    滚动视图
    func                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              scrollViewGet() {
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
            let imageView = UIImageView()
            let imageurl=String()
            //            imageurl = imageUrl+self.photoSource.photo!
            imageView.sd_setImageWithURL(NSURL(string: imageurl), placeholderImage: UIImage(named: "food1.png"))
            print(imageurl)
            
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
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   
}
