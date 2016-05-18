//
//  SetUpViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/18.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class SetUpViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    private var setupTableView=UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=bkColor
        setupTableView=UITableView(frame: CGRectMake(0, 64, self.view.bounds.width, 220), style: .Plain)
        setupTableView.scrollEnabled=false
        setupTableView.delegate=self
        setupTableView.dataSource=self
        self.automaticallyAdjustsScrollViewInsets=false
        setupTableView.layer.borderWidth=1
        setupTableView.layer.borderColor=UIColor.init(red: 229/255, green: 230/255, blue: 231/255, alpha: 1).CGColor
        self.view.addSubview(setupTableView)
        let leaveBt = UIButton(frame: CGRectMake(10,self.view.bounds.width+70,self.view.bounds.width-20,50))
        leaveBt.backgroundColor=orangeColor
        leaveBt.layer.cornerRadius=3
        leaveBt.setTitle("退出帐号", forState: .Normal)
        leaveBt.titleLabel?.font=UIFont.systemFontOfSize(15)
        leaveBt.addTarget(self, action: #selector(leave), forControlEvents: .TouchUpInside)
        self.view.addSubview(leaveBt)
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        return 5
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let ident = "tableviewcell"
        let cell = UITableViewCell(style: .Default, reuseIdentifier: ident)
        cell.accessoryType = .DisclosureIndicator
        cell.selectionStyle = .None
        switch indexPath.row {
        case 0:
            cell.textLabel?.text="登录密码修改"
            cell.textLabel?.textColor=textColor
            cell.textLabel?.font=UIFont.systemFontOfSize(15)
        case 1:
            cell.textLabel?.text="省流量模式"
            let kaiguan = UISwitch(frame: CGRectMake(self.view.bounds.width-60,5,40,34))
            
            cell.addSubview(kaiguan)
            cell.textLabel?.font=UIFont.systemFontOfSize(15)
            cell.textLabel?.textColor=textColor
            cell.accessoryType = .None
        case 2:
            cell.textLabel?.text="缓冲清除"
            cell.textLabel?.textColor=textColor
            cell.textLabel?.font=UIFont.systemFontOfSize(15)
        case 3:
            cell.textLabel?.text="版本更新（1.1）"
            cell.textLabel?.textColor=textColor
            cell.textLabel?.font=UIFont.systemFontOfSize(15)
        default:
            cell.textLabel?.text="关于我们"
            cell.textLabel?.textColor=textColor
            cell.textLabel?.font=UIFont.systemFontOfSize(15)
        }
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            let passVC = ChangePasswordViewController()
            self.navigationController?.pushViewController(passVC, animated: true)
            
        case 1:
            break
        case 2:
            // 取出cache文件夹路径
            let cachePath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).first
            // 打印路径,需要测试的可以往这个路径下放东西
            print(cachePath)
            // 取出文件夹下所有文件数组
            let files = NSFileManager.defaultManager().subpathsAtPath(cachePath!)
            // 用于统计文件夹内所有文件大小
            var big = Int();
            
            
            // 快速枚举取出所有文件名
            for p in files!{
                // 把文件名拼接到路径中
                let path = cachePath!.stringByAppendingFormat("/\(p)")
                // 取出文件属性
                let floder = try! NSFileManager.defaultManager().attributesOfItemAtPath(path)
                // 用元组取出文件大小属性
                for (abc,bcd) in floder {
                    // 只去出文件大小进行拼接
                    if abc == NSFileSize{
                        big += bcd.integerValue
                    }
                }
            }
            
            // 提示框
            let message = "\(big/(1024*1024))M缓存"
            let alert = UIAlertController(title: "清除缓存", message: message, preferredStyle: UIAlertControllerStyle.Alert)
            
            let alertConfirm = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default) { (alertConfirm) -> Void in
                // 点击确定时开始删除
                for p in files!{
                    // 拼接路径
                    let path = cachePath!.stringByAppendingFormat("/\(p)")
                    // 判断是否可以删除
                    if(NSFileManager.defaultManager().fileExistsAtPath(path)){
                        // 删除
                        try! NSFileManager.defaultManager().removeItemAtPath(path)
                    }
                }
            }
            alert.addAction(alertConfirm)
            let cancle = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel) { (cancle) -> Void in
                
            }
            alert.addAction(cancle)
            // 提示框弹出
            presentViewController(alert, animated: true) { () -> Void in
                
            }
        case 3:
            let alertController=UIAlertController(title: "版本更新", message: "这已经是最新版本", preferredStyle: .Alert)
            let cancelAction = UIAlertAction(title: "确定", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            self.presentViewController(alertController, animated: true, completion: nil)


        default:
            break
        }
    }
    func leave(){
        let alertController=UIAlertController(title: "退出帐号", message: "退出后您将不能预订房间，确认退出吗？", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "确定", style: .Default,
                                     handler: {
                                        action in
                                        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                                        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("Login")
                                        self.presentViewController(vc, animated: true, completion: nil)
                                        
        })
        let cancelAction = UIAlertAction(title: "取消", style: .Default, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.addAction(okAction)
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=true
        self.navigationController?.navigationBar.backItem?.title=""
        self.navigationItem.title="设置"
    }
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden=false
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
