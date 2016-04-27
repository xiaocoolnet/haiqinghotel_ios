//
//  SaleViewController.swift
//  
//
//  Created by xiaocool on 16/4/27.
//
//

import UIKit

class SaleViewController: UIViewController ,UIScrollViewDelegate{
    
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
    
   
    @IBOutlet weak var timeCell: UITableView!
    
    
    private var scrollView:UIScrollView!
    private let numOfPages=4
    var num=0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.automaticallyAdjustsScrollViewInsets=false
        let frame = self.view.bounds
        //滚动式图
        let scrollview_h = frame.width*0.55
        
        scrollView = UIScrollView(frame: CGRectMake(0, 66, frame.width, scrollview_h))
        
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
        
        
        
        
//        for item in 0...2 {
//            let priceL_w = frame.width/3
//            
//            let priceL = UILabel(frame: CGRectMake(0+CGFloat(item)*priceL_w,scrollview_h+66,priceL_w-1,40))
//            priceL.backgroundColor=UIColor.whiteColor()
//            self.view.addSubview(priceL)
//            
//        }
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
        self.navigationController?.navigationBarHidden=false
        self.tabBarController?.tabBar.hidden=true
    }
    override func  viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden=true
        self.tabBarController?.tabBar.hidden=false
        
    }
}
