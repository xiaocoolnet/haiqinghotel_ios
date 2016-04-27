//
//  SaleViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/26.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class SaleViewController: UIViewController ,UIScrollViewDelegate{

    private var scrollView:UIScrollView!
    private let numOfPages=4
    var num=0
    override func viewDidLoad() {
        super.viewDidLoad()

        let scrollview_h = self.view.frame.width*0.55
        
        scrollView = UIScrollView(frame: CGRectMake(0, 66, self.view.frame.width, scrollview_h))
        
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPointZero
        
        // 将 scrollView 的 contentSize 设为屏幕宽度的3倍(根据实际情况改变)
        scrollView.contentSize = CGSize(width: self.view.frame.size.width * CGFloat(numOfPages), height: scrollview_h)
        scrollView.delegate = self
        
        //滚动式图添加图片
        for index  in 0..<numOfPages {
            let imageView = UIImageView(image: UIImage(named: "青岛海情-\(index).JPG"))
            imageView.frame = CGRect(x: self.view.frame.size.width * CGFloat(index), y: 66, width: self.view.frame.size.width, height: scrollview_h)
            scrollView.addSubview(imageView)
        }
        
        
        //滚动视图添加小白点
        let pageC = UIPageControl()
        pageC.frame=CGRectMake(self.view.frame.size.width/2-20, 180, 40, 20)
        
        pageC.tag=102
        pageC.numberOfPages=4
        pageC.addTarget(self, action: #selector(dopageC), forControlEvents: UIControlEvents.ValueChanged )
        
//        for item in 0...2 {
//            let jieshaoL_w = self.view.bounds.width/3
//            
//            let jieshaoL = UILabel(frame: CGRectMake(jieshaoL_w*CGFloat(item),)
//            
//        }
        
        //将滚动式图添加到view上
        self.view.addSubview(scrollView)
        //将小白点添加到view
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
        rect=CGRectMake(x,64, self.view.bounds.width, self.view.bounds.height-400)
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
