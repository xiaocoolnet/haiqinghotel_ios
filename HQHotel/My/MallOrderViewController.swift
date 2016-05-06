//
//  MallOrderViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/5/4.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class MallOrderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func GetDate(){
        let url = apiUrl+"showbedroominfo"
        
        let param = [
            "id":12
        ]
        Alamofire.request(.GET, url, parameters: param).response { request, response, json, error in
            if(error != nil){
            }
            else{
                
                let status = HotelOrderModel(JSONDecoder(json!))
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
                    let order = NSUserDefaults.standardUserDefaults()

                    order.setValue(status.data?.ordername, forKey: "name")
                    order.setValue(status.data?.orderid, forKey: "rid")
                    order.setValue(status.data?.ordertime, forKey: "time")
                    
                    order.setValue(status.data?.orderstate, forKey: "state")
                    order.setValue(status.data?.ordertype, forKey: "type")
                    order.setValue(status.data?.ordermobile, forKey: "mobile")
                    order.setValue(status.data?.orderprice, forKey: "price")
                    order.setValue(status.data?.orderpicture, forKey: "picture")
                    order.setValue(status.data?.ordernumber, forKey: "number")
                    order.setValue(status.data?.ordermoney, forKey: "money")
                    order.setValue(status.data?.orderbegintime, forKey: "begintime")
                    order.setValue(status.data?.orderendtime, forKey: "endtime")
                    order.setValue(status.data?.orderarrivetime, forKey: "arrivetime")
                    order.setValue(status.data?.orderremarks, forKey: "remarks")
                    order.setValue(status.data?.orderpeoplenumber, forKey: "peoplenumber")
                    order.setValue(status.data?.ordergid, forKey: "gid")
                   
                }
            }
        }
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
