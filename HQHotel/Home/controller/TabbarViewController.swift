//
//  TabbarViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/15.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {
    class func TabbarC() ->UITabBarController{
        
        let vc1 = HomeViewController()
        let vc2 = FacilitiesViewController()
        let vc3 = MallViewController()
        let vc4 = MyViewController()
        
        let nvc1:UINavigationController = LBNvc(rootViewController: vc1)
        let nvc2:UINavigationController = LBNvc(rootViewController: vc2)
        let nvc3:UINavigationController = LBNvc(rootViewController: vc3)
        let nvc4:UINavigationController = LBNvc(rootViewController: vc4)
        
        let tabbar1 = UITabBarItem(title: "首页", image: UIImage(named: "tabbar-1") , selectedImage: UIImage(named: "tabbar-1"))
        let tabbar2 = UITabBarItem(title: "设施", image: UIImage(named: "tabbar-2"), selectedImage: UIImage(named: "tabbar-2"))
        let tabbar3 = UITabBarItem(title: "商城", image: UIImage(named: "tabbar-3"), selectedImage: UIImage(named: "tabbar-3"))
        let tabbar4 = UITabBarItem(title: "我的", image: UIImage(named: "tabbar-4"), selectedImage: UIImage(named: "tabbar-4"))
       
        nvc1.tabBarItem = tabbar1;
        nvc2.tabBarItem = tabbar2;
        nvc3.tabBarItem = tabbar3;
        nvc4.tabBarItem = tabbar4;
        
        let tc = UITabBarController()
     
        tc.viewControllers = [nvc1,nvc2,nvc3,nvc4,];
        return tc;
    }


    }
    


