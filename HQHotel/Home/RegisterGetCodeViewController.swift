//
//  RegisterGetCodeViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/4.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD

class RegisterGetCodeViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var iconBT: UIButton!
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var phoneNumberText: UITextField!
    @IBOutlet weak var codeText: UITextField!
    @IBOutlet weak var getCodeButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var password: UITextField!
    let user = NSUserDefaults.standardUserDefaults()
    var timeNamal:NSTimer!
    var timeNow:NSTimer!
    var count:Int = 60
    var alerView0:UIAlertView!
    var alerView1:UIAlertView!
    var alerView2:UIAlertView!
    var alerView3:UIAlertView!
    var alerView4:UIAlertView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCodeButton.addTarget(self, action: #selector(RegisterGetCodeViewController.GetCode), forControlEvents: UIControlEvents.TouchUpInside)
        nextButton.addTarget(self, action: #selector(RegisterGetCodeViewController.Next), forControlEvents: UIControlEvents.TouchUpInside)
        timeLabel.hidden = true
        self.navigationController?.navigationBar.hidden = false
        iconBT.addTarget(self, action: #selector(addicon), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func GetCode(){
        if (phoneNumberText.text!.isEmpty||phoneNumberText.text?.characters.count != 11)
        {
            let alerView:UIAlertView = UIAlertView()
            alerView.title = "手机号输入错误"
            alerView.message = "请重新输入"
            alerView.addButtonWithTitle("确定")
            alerView.cancelButtonIndex = 0
            alerView.delegate = self
            alerView.tag = 1
            alerView.show()
            
        }
        else
        {
            let alerView:UIAlertView = UIAlertView()
            alerView.title = "发送验证码到"
            alerView.message = "\(phoneNumberText.text!)"
            alerView.addButtonWithTitle("取消")
            alerView.addButtonWithTitle("确定")
            alerView.cancelButtonIndex = 0
            alerView.delegate = self
            alerView.tag = 0
            alerView.show()
        }
        
    }
    
    func Next(){
        if PandKong()==true{
            RegisterYanZheng()
        }
        
    }
    func RegisterYanZheng(){
        let url = apiUrl+"AppRegister"
        let param = [
            "phone":self.phoneNumberText.text!,
            "code":self.codeText.text!,
            "password":self.password.text!,
            "devicestate":"1"
            
            
        ]
        print(url)
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
            }
            else{
                print("request是")
                print(request!)
                print("====================")
                let status = Httpresult(JSONDecoder(json!))
                print(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.labelText = status.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 3)
                }
                if(status.status == "success"){
                    let userid = NSUserDefaults.standardUserDefaults()
                    userid.setValue(status.data?.id, forKey: "userid")
                    print("注册成功")
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                    let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("tabbar")
                    self.presentViewController(vc, animated: true, completion: nil)
                }
            }
        }
    }
    func PandKong()->Bool{
        if(phoneNumberText.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入手机号"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        if(codeText.text!.isEmpty){
            let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
            hud.mode = MBProgressHUDMode.Text
            hud.labelText = "请输入验证码"
            hud.margin = 10.0
            hud.removeFromSuperViewOnHide = true
            hud.hide(true, afterDelay: 1)
            return false
        }
        return true
    }
    
    func timeDow()
    {
        let time1 = NSTimer.scheduledTimerWithTimeInterval(1.0, target:self, selector: #selector(RegisterGetCodeViewController.updateTime), userInfo: nil, repeats: true)
        timeNow = time1
    }
    
    func showRepeatButton()
    {
        timeLabel.hidden=true
        getCodeButton.hidden = false
        getCodeButton.enabled = true
    }
    
    func updateTime()
    {
        count -= 1
        if (count <= 0)
        {
            count = 60
            self.showRepeatButton()
            timeNow.invalidate()
        }
        timeLabel.text = "\(count)S"
        
    }
    
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.tag == 0
        {
            if buttonIndex == 1
            {
                self.senderMessage()
                getCodeButton.hidden = true
                timeLabel.hidden = false
                self.timeDow()
            }
        }
        if alertView.tag == 1
        {}
        if alertView.tag == 2
        {}
    }
    
    func senderMessage()
    {
        let url = apiUrl+"SendMobileCode"
        let param = [
            "phone":self.phoneNumberText.text!,
            ]
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
            }
            else{
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "PhoneNumber"){
            
            
        }
        
    }
    func addicon(){
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.delegate = self
        self.presentViewController(picker, animated: true, completion: nil)
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var image = UIImage()
        image = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        self.icon.image = image
        picker.dismissViewControllerAnimated(true, completion: nil)
        self.saveImage(image, newSize: CGSize(width: 256, height: 256), percent: 0.5, imageName: "currentImage.png")
        
    }
    //保存图片至沙盒
    func saveImage(currentImage: UIImage, newSize: CGSize, percent: CGFloat, imageName: String){
        //压缩图片尺寸
        UIGraphicsBeginImageContext(newSize)
        currentImage.drawInRect(CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        //高保真压缩图片质量
        //UIImageJPEGRepresentation此方法可将图片压缩，但是图片质量基本不变，第二个参数即图片质量参数。
        let imageData:NSData = UIImagePNGRepresentation(newImage)!
        //        上传修改
        self.updateHeadImg(imageData)
    }
    //    修改头像
    func updateHeadImg(file:NSData){
        let userid = user.valueForKey("userid") as? String
        let RanNumber = String(arc4random_uniform(100000) + 100000)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            ConnectModel.uploadWithImageName("2\(userid!)\(RanNumber)", imageData:file, URL: "uploadavatar", finish: { (data) -> Void in
                print("返回值")
                print(data)
                let httpresult = Httpresult(JSONDecoder(data!))
                print("状态是")
                print(httpresult.status)
                if(httpresult.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text
                    hud.labelText = httpresult.errorData
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(httpresult.status == "success"){
                    print("Success")
                }
            })}
    }

    
}