//
//  MyViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/15.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class MyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    private let topView=UIView()
    private let iconImage=UIImageView()
    private let setupBT=UIButton()
    private let tableView=UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        let topView_h = (self.view.bounds.height)/2-80
        //顶部视图
        topView.frame=CGRectMake(0, 0, self.view.bounds.width, topView_h)
        topView.backgroundColor=UIColor.init(colorLiteralRed: 20/255, green: 125/255, blue: 192/255, alpha: 1)
        //头像视图
        iconImage.frame=CGRectMake(0, 0, self.view.bounds.width/4, self.view.bounds.width/4)
        iconImage.center=topView.center
        iconImage.image=UIImage(named: "ic_touxiang")
        //设置按钮
        setupBT.frame=CGRectMake(topView.bounds.width-40, 30, 30, 30)
        setupBT.setImage(UIImage(named: "ic_shezhi"), forState: UIControlState.Normal)
        // 循环创建三个按钮
        for item in 0...2 {
            let button_w = self.view.bounds.width/3
       
            let button = UIButton(frame: CGRectMake(0+CGFloat(item)*button_w,topView_h,button_w,40))
            //按钮图标
            let imageV = UIImageView(frame: CGRectMake(20+button_w*CGFloat(item), topView_h+15, 20, 18))
            
            let xiangqingL = UILabel(frame: CGRectMake(45+button_w*CGFloat(item),topView_h+5,button_w-20,40))
            xiangqingL.font=UIFont.systemFontOfSize(15)
            xiangqingL.textColor=UIColor.grayColor()
            button.tag=item
            
            switch button.tag {
            case 0:
                imageV.image=UIImage(named: "ic_shoucang")
                xiangqingL.text="收藏"
                button.addTarget(self, action: #selector(dobutton), forControlEvents: UIControlEvents.TouchUpInside)
                
            case 1:
                imageV.image=UIImage(named: "ic_gouwuche")
                xiangqingL.text="购物车"
                button.addTarget(self, action: #selector(dobuttonOne), forControlEvents: UIControlEvents.TouchUpInside)
                
                
            case 2:
                imageV.image=UIImage(named: "ic_xiaoxi")
                xiangqingL.text="消息中心"
                button.addTarget(self, action: #selector(dobuttonTwo), forControlEvents: UIControlEvents.TouchUpInside)
            default:
                break
            }
            self.view.addSubview(xiangqingL)
            self.view.addSubview(imageV)
            self.view.addSubview(button)
            
        }
                
        tableView.frame=CGRectMake(0, topView_h+40+20, self.view.bounds.width, 80)
        tableView.scrollEnabled=false
        tableView.delegate=self
        tableView.dataSource=self
        topView.addSubview(setupBT)
        self.view.addSubview(topView)
        self.view.addSubview(iconImage)
        self.view.addSubview(tableView)
  
    }
    //执行按钮事件
    func dobutton(){
        let collectVC = CollectViewController()
        self.navigationController?.pushViewController(collectVC, animated: true)
        
    }
    func dobuttonOne(){
        let shoplistVC = ShopListViewController()
        self.navigationController?.pushViewController(shoplistVC, animated: true)
    }
    func dobuttonTwo(){
        
        let informationVC = InformationViewController()
        self.navigationController?.pushViewController(informationVC, animated: true)
    }
    //tableview的代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 2
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell()
        switch indexPath.row {
        case 0:
            cell.textLabel?.text="我的预订"
        default:
            cell.textLabel?.text="我的订单"
        }
        return cell
        
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden=true
        
        
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBar.hidden=false
    }
    }
