//
//  LoginViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/4.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class LoginViewController: UIViewController ,UITextFieldDelegate{

  
    @IBOutlet weak var AccountText: UITextField!
    
    @IBOutlet weak var PasswordText: UITextField!
    
    
    @IBOutlet weak var LoginButton: UIButton!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        self.view.backgroundColor=UIColor.init(colorLiteralRed: 245/255, green: 245/255, blue: 245/255, alpha: 1)

        AccountText.delegate = self
        PasswordText.delegate = self
        LoginButton.addTarget(self, action: #selector(LoginViewController.Login), forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.hidden=true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        AccountText.resignFirstResponder()
        PasswordText.resignFirstResponder()
        return true
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func Login(){
        if(AccountText.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入账号"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return
        }
        if(PasswordText.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入密码"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return
        }
        let url = apiUrl+"applogin"
        let param = [
            "phone":self.AccountText.text!,
            "password":self.PasswordText.text!
        ]
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
            }
            else{
                let status = Httpresult(JSONDecoder(json!))
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
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.labelText = "登录成功"
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                    let userid = NSUserDefaults.standardUserDefaults()
                    userid.setValue(status.data?.id, forKey: "userid")
                    let schoolid = NSUserDefaults.standardUserDefaults()
                    schoolid.setValue(status.data?.schoolid, forKey: "schoolid")
                    let classid = NSUserDefaults.standardUserDefaults()
                    classid.setValue(status.data?.classid, forKey: "classid")
                    
                    self.GetUserInfo()
                    
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                    let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("tabbar")
                    self.presentViewController(vc, animated: true, completion: nil)
                }
            }
        }
    }
    func GetUserInfo(){
        let userid = NSUserDefaults.standardUserDefaults()
        let uid = userid.stringForKey("userid")
        let url = apiUrl+"GetUsers"
        let param = [
            "userid":uid!
        ]
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
            }
            else{
                let status = MineModel(JSONDecoder(json!))
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
                    let username = NSUserDefaults.standardUserDefaults()
                    username.setValue(status.data?.name, forKey: "username")
                }
            }
        }
    }
}