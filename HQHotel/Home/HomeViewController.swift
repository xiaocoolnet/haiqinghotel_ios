//
//  HomeViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/14.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class HomeViewController: UIViewController,UIScrollViewDelegate ,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate{
    
    private var scrollView:UIScrollView!
    private var tableView:UITableView!
    private var searchbar:UISearchBar!
    internal var starttime:String=String()
    internal var endtime:String=String()
    internal var tianshu:Int=Int()
    private var timeleftBT = UIButton()
    private var endtimeBT = UIButton()
    private var  daysL = UILabel()
    var strNowTime=String()
    var strNowTime1=String()
    
    
    var resrvationSource = ReservationsModel()
    
    private let numOfPages=3
    
    var num=0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.tintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        let frame = self.view.bounds
        
        tableView=UITableView(frame: CGRectMake(0, 0, frame.width, frame.height-44), style: UITableViewStyle.Plain)
        tableView.delegate=self
        tableView.dataSource=self
        tableView.rowHeight=250
        tableView.showsVerticalScrollIndicator=false
        tableView.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        self.GetDate()
        
        
        //searchbar
        searchbar=UISearchBar(frame: CGRectMake(20, 20, frame.width-40, 20))
        searchbar.searchBarStyle=UISearchBarStyle.Minimal
        searchbar.layer.cornerRadius=14
        searchbar.layer.masksToBounds=true
        searchbar.placeholder="搜索"
        searchbar.keyboardType=UIKeyboardType.Default
        searchbar.delegate=self
    
        //创建一个view作为表示图的头视图
        let headerview = UIView(frame: CGRectMake(0, 0, frame.width, frame.width*0.55+frame.width*0.4+40+30))
       headerview.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        //滚动式图
        let scrollview_h = frame.width*0.55
        
        scrollView = UIScrollView(frame: CGRectMake(0, 0, frame.width, scrollview_h))
        
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
            let imageView = UIImageView(image: UIImage(named: "青岛海情-\(index).JPG"))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: scrollview_h)
            scrollView.addSubview(imageView)
        }
        
        //滚动视图添加小白点
        let pageC = UIPageControl()
        pageC.frame=CGRectMake(frame.size.width/2-20, 200, 40, 20)
        
        pageC.tag=102
        pageC.numberOfPages=3
        pageC.addTarget(self, action: #selector(dopageC), forControlEvents: UIControlEvents.ValueChanged )
        //添加手势，点击空白处收回键盘
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewtap))
        tap.cancelsTouchesInView=false
        self.view.addGestureRecognizer(tap)
        

        //时间预定view
        let timeV_h = frame.width*0.4
        let timeV_w = frame.width-20
        
        
        let timeV = UIView(frame: CGRectMake(10, scrollview_h-10, frame.width-20, timeV_h))
        timeV.backgroundColor=UIColor.whiteColor()
        
        let ruzhuL = UILabel(frame: CGRectMake(60, 10, 40, 20))
        ruzhuL.text="入住"
        ruzhuL.font=UIFont.boldSystemFontOfSize(16)
        ruzhuL.textColor=UIColor.grayColor()
        let lidianL = UILabel(frame: CGRectMake(frame.width-100, 10, 40, 20))
        lidianL.text="离店"
        lidianL.font=UIFont.boldSystemFontOfSize(16)
        lidianL.textColor=UIColor.grayColor()
        daysL = UILabel(frame: CGRectMake(frame.width/2-20, 10, 40, 20))
        daysL.textColor=UIColor.init(colorLiteralRed: 250/255, green: 140/255, blue: 60/255, alpha: 1)
        daysL.font=UIFont.boldSystemFontOfSize(15)
        timeleftBT = UIButton(frame: CGRectMake(20, 40, 110, 20))
        timeleftBT.setTitleColor(UIColor.init(colorLiteralRed: 0/255, green: 166/255, blue: 251/255, alpha: 1), forState: UIControlState.Normal)

        timeleftBT.addTarget(self, action: #selector(timeStart), forControlEvents: UIControlEvents.TouchUpInside)
        endtimeBT = UIButton(frame: CGRectMake((self.view.bounds.width-40-100),40,100,20))
        
        endtimeBT.setTitleColor(UIColor.init(colorLiteralRed: 0/255, green: 166/255, blue: 251/255, alpha: 1), forState: UIControlState.Normal)

        endtimeBT.addTarget(self, action: #selector(timeStart), forControlEvents: UIControlEvents.TouchUpInside)
        
        let reserveBT = UIButton(frame: CGRectMake(10,timeV_h-50,timeV_w-20,40))
        reserveBT.setTitle("立即预订", forState: UIControlState.Normal)
        reserveBT.backgroundColor=UIColor.init(colorLiteralRed: 0/255, green: 166/255, blue: 251/255, alpha: 1)
        reserveBT.layer.cornerRadius=5
        
        
        
        timeV.addSubview(reserveBT)
        timeV.addSubview(timeleftBT)
        timeV.addSubview(daysL)
        timeV.addSubview(lidianL)
        timeV.addSubview(ruzhuL)
        timeV.addSubview(endtimeBT)
        //传值赋值
        timeleftBT.setTitle(starttime, forState: UIControlState.Normal)
        endtimeBT.setTitle(endtime, forState: UIControlState.Normal)
        daysL.text="\(String(tianshu))天"
        
        
        //将小白点添加到滚动视图
        scrollView.addSubview(pageC)
        //将滚动式图添加到view上
        headerview.addSubview(scrollView)
        //将日期预订视图添加到头视图上
        headerview.addSubview(timeV)
         //将view设置为tableView的HeaderView
        tableView.tableHeaderView=headerview
        // 酒店详情页面,循环创建三个按钮
        
        for item in 0...2 {
            
            
            let button_w = frame.width/3
            
            let button = UIButton(frame: CGRectMake(0+CGFloat(item)*button_w,scrollview_h+timeV_h,button_w-1,40))
            let bgView = UIView(frame: button.frame)
            bgView.backgroundColor=UIColor.whiteColor()
            
            
            let xiangqingL = UILabel(frame: CGRectMake(35+button_w*CGFloat(item),scrollview_h+timeV_h,button_w-40,40))
            xiangqingL.font=UIFont.systemFontOfSize(15)
            xiangqingL.textColor=UIColor.grayColor()
            button.tag=item
            switch button.tag {
            case 0:
                let imageV = UIImageView(frame: CGRectMake(15, 10, 11, 20))
                imageV.image=UIImage(named: "phone-3")
                xiangqingL.text="酒店位置"
                button.addTarget(self, action: #selector(hotelPlace), forControlEvents: UIControlEvents.TouchUpInside)
                button.addSubview(imageV)
                
            case 1:
                let imageV = UIImageView(frame: CGRectMake(10, 10, 18, 20))
                imageV.image=UIImage(named: "phone-1")
                xiangqingL.text="联系我们"
                button.addTarget(self, action: #selector(callMe), forControlEvents: UIControlEvents.TouchUpInside)
                button.addSubview(imageV)
                
            case 2:
                let imageV = UIImageView(frame: CGRectMake(10, 10, 18, 18))
                imageV.image=UIImage(named: "phone-4")
                xiangqingL.text="酒店详情"
                button.addTarget(self, action: #selector(hotelDetails), forControlEvents: UIControlEvents.TouchUpInside)
                button.addSubview(imageV)
            default:
                break
            }
            headerview.addSubview(bgView)
            headerview.addSubview(xiangqingL)
            headerview.addSubview(button)
            
        }
        //当前促销
        let cuxiaoIV = UIImageView(frame: CGRectMake(10, scrollview_h+timeV_h+40+10, self.view.bounds.width-20, 18))
        cuxiaoIV.image=UIImage(named: "ic_cuxiao")
        headerview.addSubview(cuxiaoIV)
        self.view.addSubview(tableView)
        headerview.addSubview(searchbar)
        //定时器
        NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: #selector (doTime), userInfo: nil, repeats: true)
    }
    
    //酒店预订接口
    func GetDate(){
        let url = apiUrl+"getpromotionlist"
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
                    self.resrvationSource = ReservationsModel(status.data!)
                    self.tableView.reloadData()
                }
            }
        }
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
    
    //tableView代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.resrvationSource.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let hotelcell = HotelmallTableViewCell.cellWithTableView(tableView)
        hotelcell.selectionStyle = .None
        let reservationInfo = resrvationSource.objectlist[indexPath.row]
        
        
        hotelcell.titName.text = reservationInfo.name
        hotelcell.size.text = "14*14"
        hotelcell.priceLab.text = reservationInfo.price
        if reservationInfo.type == 1 {
            hotelcell.prie.text = "起/晚"
        }else{
            hotelcell.prie.text = "/位"
        }
        hotelcell.imageV.image = UIImage(named: "青岛海情-002.JPG")
        
        return hotelcell
        
    }
    //点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let reservationInfo = resrvationSource.objectlist[indexPath.row]
        if  reservationInfo.type == 1{
            let cuxiaoV = SaleViewController(nibName: "SaleViewController", bundle: nil)
          
            self.navigationController?.pushViewController(cuxiaoV, animated: true)

        }
        else{
            let foodVC = FoodViewController(nibName: "FoodViewController", bundle: nil)
            self.navigationController?.pushViewController(foodVC, animated: true)
            
        }
        
        
        
        
    }
    


    //任务编辑文本
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool{
        
        
        return true
    }

    //开始编辑文本时调用
    func searchBarTextDidBeginEditing(searchBar: UISearchBar){
        print("点击了搜索栏")
    }
    //要求
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        return true
    }
    //当编辑完调用此函数
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        print("完成编辑")
    }
    //文本正在编辑状态的文本内容
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("当前输入的文本\(searchText)")
    }
   //点击serch时调用
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
     print("开始搜索")
    
}
    //隐藏键盘的方法
    func viewtap(){
        self.view.endEditing(true)
//        
    }


    //响应酒店详情三个按钮的方法
    func hotelPlace(){
        let placeVC = HotelPlaceViewController()
        self.navigationController?.pushViewController(placeVC, animated: true)
        
        
    }
    func callMe(){
        let callVC = CallMeViewController()
        self.navigationController?.pushViewController(callVC, animated: true)
        
    }
    func hotelDetails(){
        let detailsVC = HotelDetailsViewController()
        self.navigationController?.pushViewController(detailsVC, animated: true)
        
    }
    //选择入住时间，调用第三方日历
    func timeStart(){
        
        let vvv = CalendarFirstViewController()
        self.navigationController?.pushViewController(vvv, animated: true)
     
        
    }
    //隐藏导航栏
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden=true
        self.tabBarController?.tabBar.hidden=false
        if starttime=="" {
            let date = NSDate()
            let timeFormatter = NSDateFormatter()
            timeFormatter.dateFormat = "yyyy-MM-dd"
            strNowTime = timeFormatter.stringFromDate(date) as String
            
            let date1 = NSDate(timeIntervalSinceNow: 24*60*60)
            let timeFormatter1 = NSDateFormatter()
            timeFormatter1.dateFormat = "yyyy-MM-dd"
            strNowTime1 = timeFormatter.stringFromDate(date1) as String
        timeleftBT.setTitle(strNowTime, forState: UIControlState.Normal)
        endtimeBT.setTitle(strNowTime1, forState: UIControlState.Normal)
         daysL.text=""
        }
        
    }
    //显示导航栏
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden=false
        
    }

}
