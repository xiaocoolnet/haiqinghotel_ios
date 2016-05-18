//
//  CollectViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/19.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit

class CollectViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    private var collTableview=UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backItem?.title=""
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
        
        collTableview=UITableView(frame: CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height))
        collTableview.delegate=self
        collTableview.dataSource=self
        collTableview.rowHeight=100
        self.view.addSubview(collTableview)
        
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var collcell = CollectionCell.cellWithTableView(tableView)

//        if collcell==nil {
//            collcell=CollectionCell(style: .Default, reuseIdentifier: "a")
//        }
        
        collcell.nameL.text="鲜活三文鱼"
        collcell.jianjieL.text="这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介这是简介"
        collcell.iconView.image=UIImage(named: "海参.jpg")
        collcell.priceL.text="¥367"
        
        
        
       return collcell
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
