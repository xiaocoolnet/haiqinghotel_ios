//
//  SaleViewController.swift
//  
//
//  Created by xiaocool on 16/4/27.
//
//

import UIKit
import Alamofire
import MBProgressHUD
class SaleViewController: UIViewController ,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var menshijiaL: UILabel!
    
    @IBOutlet weak var youhuijiaL: UILabel!
    
    @IBOutlet weak var zaocanIV: UIImageView!
    
    @IBOutlet weak var shangwangL: UILabel!
    
    @IBOutlet weak var kezhuL: UILabel!
    
    @IBOutlet weak var loucengL: UILabel!
    
    @IBOutlet weak var chuangxingL: UILabel!
 
    @IBOutlet weak var chuanghuL: UILabel!

    @IBOutlet weak var weiyuL: UILabel!
   
    @IBOutlet weak var mianjiL: UILabel!

    @IBOutlet weak var tableview: UITableView!

    var saleSource = SaleModel()
    var count = Int()
    var photoSource = roomphotolistInfo()
    var photoAry = NSMutableArray()
    
    
    
    internal var startTime=String()
    internal var endTime=String()
    var name=String()
    var bedsize=String()
    var repast=String()
    var network=String()
    var price=String()
    var zongjiaL=UILabel()

    private var scrollView:UIScrollView!
    private let numOfPages=4
    var num=0
    
    override func viewDidLoad() {
        

        if repast=="1" {
            zaocanIV.image=UIImage(named: "ic_zaocan-1")
        }else{
            zaocanIV.image=UIImage(named: "ic_zaocan")
        }
        
       
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
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
            let imageView = UIImageView(image: UIImage(named: "青岛海情-00\(index+1).JPG"))
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
        tableview.delegate=self
        tableview.dataSource=self
        
        
        let priceL = UILabel(frame: CGRectMake(0,self.view.bounds.height-40,self.view.bounds.width/2,40))
        priceL.backgroundColor=UIColor.whiteColor()
        priceL.text="  总价："
        self.view.addSubview(priceL)
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
    //酒店房间接口
    func GetDate(){
        let url = apiUrl+"showbedroominfo"

        let param = [
            "id":12
        ]
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
            }
            else{
                
                let status = SaleModel(JSONDecoder(json!))
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

                    
                    self.chuangxingL.text = status.data?.roombedsize
                    self.youhuijiaL.text = status.data?.roomprice
                    self.menshijiaL.text = status.data?.roomoprice
                    self.shangwangL.text = status.data?.roomnetwork
                    self.kezhuL.text = status.data?.roompeoplenumber
                    self.loucengL.text = status.data?.roomfloor
                    self.chuanghuL.text = status.data?.roomwindow
                    self.weiyuL.text = status.data?.roombathroom
                    self.mianjiL.text = status.data?.roomacreage
                    self.price=(status.data?.roomprice)!
                    self.zongjiaL.text="¥"+self.price
                    self.name=(status.data?.roomname)!

                    self.count = (status.data?.count)!
                    for item in 0..<self.count{
                        self.photoSource = (status.data?.roomphotolist[item])!
                        self.photoAry.addObject(self.photoSource)
                        print(self.photoSource.photo)
                    }
                    
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
    //预订按钮
    func yuding(){
        
        let reserve = ReserveViewController(nibName: "ReserveViewController", bundle: nil)
        reserve.name=name
        reserve.bedsize=bedsize
        reserve.network=network
        reserve.repast=repast
        reserve.startTime=startTime
        reserve.endTime=endTime
        reserve.price = self.price
        
        self.navigationController?.pushViewController(reserve, animated: true)
        
        
        
    }
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        cell.imageView?.image=UIImage(named: "ic_rili")
        cell.textLabel?.text=startTime+"入住，"+endTime+"退房"
        return cell
        
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let riliVC = CalendarFirstViewController()
        riliVC.str="1"
        self.navigationController?.pushViewController(riliVC, animated: true)
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden=false
        self.tabBarController?.tabBar.hidden=true

        let chuanzhi = NSUserDefaults.standardUserDefaults()
        if startTime=="" {
            let date = NSDate()
            let timeFormatter = NSDateFormatter()
            timeFormatter.dateFormat = "yyyy-MM-dd"
            startTime = timeFormatter.stringFromDate(date) as String
            
            let date1 = NSDate(timeIntervalSinceNow: 24*60*60)
            let timeFormatter1 = NSDateFormatter()
            timeFormatter1.dateFormat = "yyyy-MM-dd"
            endTime = timeFormatter.stringFromDate(date1) as String
        }else {
        startTime = chuanzhi.stringForKey("startTime")!
        endTime = chuanzhi.stringForKey("endTime")!
        }
        
        tableview.reloadData()
        self.GetDate()
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""
//        let button = UIButton(frame: CGRectMake(0,0,40,20))

//        button.setBackgroundImage(UIImage(named: "ic_jiantou"), forState: UIControlState.Normal)
//        let backBT = UIBarButtonItem(customView: button)
//        self.navigationItem.backBarButtonItem=backBT
//        
        
}
    override func  viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden=true
        self.tabBarController?.tabBar.hidden=false
        
        
        
    }
}
