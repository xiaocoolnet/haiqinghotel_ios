//
//  FacilitiesViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/15.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class FacilitiesViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        for item in 0...3{
            
            let view1 = Facilitiescell(frame: CGRectMake(0, 64+100*CGFloat(item), self.view.bounds.width, 150))
            let button = UIButton()
            button.frame=view1.frame
            
            button.tag=item
            if button.tag==0 {
                button.addTarget(self, action: #selector(dobuttonOne), forControlEvents:.TouchUpInside)
            }
            if button.tag==1 {
                button.addTarget(self, action: #selector(dobuttonTwo), forControlEvents: .TouchUpInside)
            }
            if button.tag==2 {
                button.addTarget(self, action: #selector(dobuttonThree), forControlEvents: .TouchUpInside)
            }
            if button.tag==3 {
                button.addTarget(self, action: #selector(dobuttonFour), forControlEvents: .TouchUpInside)
            }
            self.view.addSubview(view1)
            self.view.addSubview(button)
            
        }
        
        
        
    }
    //房间设施页面跳转
    func dobuttonOne(){
     
            let oneVC = RoomViewController()
            self.navigationController?.pushViewController(oneVC, animated: true)
   
    }
    //婚宴设施页面跳转
    func dobuttonTwo(){
        let twoVC = MarryViewController()
        self.navigationController?.pushViewController(twoVC, animated: true)
        
        
    }
    //会议设施页面跳转
    func dobuttonThree(){
       
        let threeVC = MeetingViewController()
        self.navigationController?.pushViewController(threeVC, animated: true)
        
    }
    //餐饮美食页面跳转
    func dobuttonFour(){
        let fourVC = FoodViewController()
        self.navigationController?.pushViewController(fourVC, animated: true)
        
        
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
