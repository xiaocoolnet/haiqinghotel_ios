//
//  FacilitiesViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/15.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class FacilitiesViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    private var view1=UIImageView()
    
    private var heardView=UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        let tableView = UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        tableView.rowHeight=200
        tableView.delegate=self
        tableView.dataSource=self
        tableView.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        
        self.view.addSubview(tableView)
        let view1_h = self.view.bounds.width*0.35
        heardView = UIView(frame: CGRectMake(0,66,self.view.bounds.width,self.view.bounds.height-66))
        for item in 0...3{

            view1 = UIImageView(frame: CGRectMake(0, CGFloat(item)*(view1_h+10), self.view.bounds.width, view1_h))
            view1.image=UIImage(named: "设施\(item).png")
            
            let button = UIButton()
            button.frame=view1.frame
            
            button.tag=item
            if button.tag==0 {
                button.addTarget(self, action: #selector(dobuttonOne), forControlEvents:.TouchUpInside)
                button
            }
            if button.tag==1 {
                button.addTarget(self, action: #selector(dobuttonOne), forControlEvents: .TouchUpInside)
            }
            if button.tag==2 {
                button.addTarget(self, action: #selector(dobuttonOne), forControlEvents: .TouchUpInside)
            }
            if button.tag==3 {
                button.addTarget(self, action: #selector(dobuttonOne), forControlEvents: .TouchUpInside)
            }
            heardView.addSubview(view1)
            heardView.addSubview(button)
            
        }
        let zixunIV = UIImageView(frame: CGRectMake(0,(view1_h+10)*4+5 , self.view.bounds.width, 15))
        zixunIV.image=UIImage(named: "ss_zixun")
        self.view.addSubview(zixunIV)
        heardView.addSubview(zixunIV)
        tableView.tableHeaderView=heardView
       
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let newscell = NewsTableViewCell.cellWithTableView(tableView)
        return newscell
       
    }
    //点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        let newsVC = NewsViewController()
        self.navigationController?.pushViewController(newsVC, animated: true)
        
    }
    //设施二级页面跳转
    func dobuttonOne(){
     
            let oneVC = RoomViewController()
            self.navigationController?.pushViewController(oneVC, animated: true)
   
    }
       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}
