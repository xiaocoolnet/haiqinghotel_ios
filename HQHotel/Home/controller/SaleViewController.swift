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
    
    private var scrollView:UIScrollView!
    private let numOfPages=4
    var num=0
    
    override func viewDidLoad() {
        
        let room = NSUserDefaults.standardUserDefaults()
        let price = room.stringForKey("price")
//        let name = room.stringForKey("name")
        let oprice = room.stringForKey("oprice")
//        let count = room.stringForKey("count")
//        let picture = room.stringForKey("picture")
//        let daynum = room.stringForKey("daynum")
//        let surplus = room.stringForKey("surplus")
//        let showid = room.stringForKey("showid")
//        let time = room.stringForKey("time")
//        let daysurplus = room.stringForKey("daysurplus")

       

        
        
        youhuijiaL.text = price
        menshijiaL.text=oprice
        
        
        print(youhuijiaL.text)
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
        let zongjiaL = UILabel(frame: CGRectMake(70,self.view.bounds.height-40,self.view.bounds.width/2-70,40))
        zongjiaL.backgroundColor=UIColor.whiteColor()
        zongjiaL.text="¥ 487"
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
//        let userid = NSUserDefaults.standardUserDefaults()
//        let uid = userid.stringForKey("userid")
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
                    let room = NSUserDefaults.standardUserDefaults()
                    room.setValue(status.data?.roomprice, forKey: "price")
                    room.setValue(status.data?.roomcount, forKey: "count")
                    room.setValue(status.data?.roomname, forKey: "name")
                    room.setValue(status.data?.roomoprice, forKey: "oprice")
                    
                    room.setValue(status.data?.roomdaynum, forKey: "daynum")
                    room.setValue(status.data?.roomdaysurplus, forKey: "daysurplus")
                    room.setValue(status.data?.roompicture, forKey: "picture")
                    room.setValue(status.data?.roomshowid, forKey: "showid")
                    room.setValue(status.data?.roomtime, forKey: "time")
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
    func yuding(){
        
        let reserve = ReserveViewController(nibName: "ReserveViewController", bundle: nil)
        self.navigationController?.pushViewController(reserve, animated: true)
        
        
        
    }
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        cell.accessoryType=UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden=false
        self.tabBarController?.tabBar.hidden=true
        self.GetDate()
    }
    override func  viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden=true
        self.tabBarController?.tabBar.hidden=false
        
    }
}
