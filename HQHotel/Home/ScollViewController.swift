//
//  ScollViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/14.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class ScollViewController: UIViewController{
    
    
    private var  scrollView:UIScrollView!
    
    private let numOfPages=4
    
   
    
    @IBOutlet weak var startBT: UIButton!
   
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.backItem?.title=""

        let frame = self.view.bounds
        startBT.layer.borderWidth = 2.0
        startBT.layer.borderColor = UIColor(red: 54.0 / 255.0, green: 190.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0).CGColor
        startBT.addTarget(self, action: #selector(touchMe), forControlEvents:.TouchUpInside)
        scrollView = UIScrollView(frame: frame)
        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPointZero
        // 将 scrollView 的 contentSize 设为屏幕宽度的3倍(根据实际情况改变)
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(numOfPages), height: frame.size.height)
        
        scrollView.delegate = self
        
        for index  in 0..<numOfPages {
            let imageView = UIImageView(image: UIImage(named: "\(index + 1).jpg"))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: frame.size.height)
            scrollView.addSubview(imageView)
        }
        
        self.view.insertSubview(scrollView, atIndex: 0)
        
        // 给开始按钮设置圆角
        startBT.layer.cornerRadius = 5.0
        // 隐藏开始按钮
//        startBT.alpha = 0.0
    }
    func touchMe(){
//        let homeVC = TabbarViewController()
//        self.presentViewController(homeVC, animated: true, completion: nil)
        
        
    
    }
    // 隐藏状态栏
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}

extension ScollViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        // 随着滑动改变pageControl的状态
        pageControl.currentPage = Int(offset.x / view.bounds.width)
        
        // 因为currentPage是从0开始，所以numOfPages减1
        if pageControl.currentPage == numOfPages - 1 {
            UIView.animateWithDuration(0.5) {
                self.startBT.alpha = 1.0
            }
        } else {
            UIView.animateWithDuration(0.2) {
                self.startBT.alpha = 0.0
            }
        }
    }
}
