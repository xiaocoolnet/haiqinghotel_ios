//
//  MallViewController.swift
//  HQHotel
//
//  Created by xiaocool on 16/4/15.
//  Copyright © 2016年 xiaocool. All rights reserved.
//

import UIKit
import Alamofire
import MBProgressHUD
class MallViewController: UIViewController,UICollectionViewDelegate ,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate{

    private var searchbar=UISearchBar()
    private var collectionView:UICollectionView?
    var shoppingSource = ShoppingModel()
    private var id=String()
    private var name=String()
    private var price=String()
    private var oprice=String()
    private var unit=String()
    private var descriptionn=String()
    private var showid=String()
    private var time=String()
    private var picture=String()
    
    var count = Int()
    var photoSource = goodphotolistInfo()
    var photoAry = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title="商城"
        self.view.backgroundColor=bkColor
        //searchbar
        searchbar=UISearchBar(frame: CGRectMake(20, 70, self.view.bounds.width-40, 30))
        searchbar.searchBarStyle=UISearchBarStyle.Minimal
        searchbar.layer.cornerRadius=14
        searchbar.layer.masksToBounds=true
        searchbar.placeholder="搜索"
        searchbar.keyboardType=UIKeyboardType.Default
        searchbar.delegate=self

        //添加手势，点击空白处收回键盘
        let tap = UITapGestureRecognizer(target: self, action: #selector(viewtap))
        tap.cancelsTouchesInView=false
        self.view.addGestureRecognizer(tap)
        

        self.view.addSubview(searchbar)
        self.navigationController?.navigationBar.barTintColor=UIColor.init(red: 30/255, green: 175/255, blue: 252/255, alpha: 1)
    
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRectMake(0, 100, self.view.bounds.width, self.view.bounds.height-90), collectionViewLayout: layout)
        collectionView!.backgroundColor=UIColor.clearColor()
        collectionView!.delegate=self
        collectionView!.dataSource=self
        collectionView!.registerClass(MallCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.view.addSubview(collectionView!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func GetDate(){
        let url = apiUrl+"getshoppinglist"
 
        print(url)
        Alamofire.request(.GET, url, parameters: nil).response { request, response, json, error in
            if(error != nil){
            }
            else{
                
                let status = Http(JSONDecoder(json!))
                print("状态是")
                print(status.status)
                if(status.status == "error"){
                    let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                    hud.mode = MBProgressHUDMode.Text;
                    hud.margin = 10.0
                    hud.removeFromSuperViewOnHide = true
                    hud.hide(true, afterDelay: 1)
                }
                if(status.status == "success"){
                    self.shoppingSource = ShoppingModel(status.data!)
                    self.collectionView!.reloadData()
                }
            }
        }
    }
        

    //组数
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //每组返回多少个cell
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return shoppingSource.count
    }
    //cell的设置
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        
        
        let cell : MallCollectionViewCell=collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! MallCollectionViewCell
        
        let shopInfo = shoppingSource.objectlist[indexPath.row]
        
        
        cell.nameL.text=shopInfo.shopname
//        cell.jianjieL.text=shopInfo.shop
        print(descriptionn)
        cell.priceL.text="¥"+shopInfo.shopprice!+"/g"
        let image = shopInfo.shoppicture
        let IVurl = imageUrl+image!
        print(IVurl)
        cell.imageView.sd_setImageWithURL(NSURL(string: IVurl ),placeholderImage: UIImage(named: "kb3.png"))
        return cell
    }
    //每个cell的尺寸
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cell_x = (self.view.bounds.width-30)/2
        
        return CGSizeMake(cell_x, cell_x+90)
    }
    //每个cell上左下右的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 30, 10)
    }
    //cell的点击事件

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let shopInfo = shoppingSource.objectlist[indexPath.row]
        let goodsVC = GoodsViewController()
        goodsVC.price=shopInfo.shopprice!
        goodsVC.goodname=shopInfo.shopname!
        goodsVC.goodid=shopInfo.shopid!
        self.navigationController?.pushViewController(goodsVC, animated: true)
        
    }
    //任务编辑文本
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool{
        
        
        return true
    }
    
    //开始编辑文本时调用
    func searchBarTextDidBeginEditing(searchBar: UISearchBar){
        print("点击了搜索栏")
    }
    //要求
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        return true
    }
    //当编辑完调用此函数
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        print("完成编辑")
    }
    //文本正在编辑状态的文本内容
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        print("当前输入的文本\(searchText)")
    }
    //点击serch时调用
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        print("开始搜索")
        
    }
    //隐藏键盘的方法
    func viewtap(){
        self.view.endEditing(true)
        //
    }
    override func viewWillAppear(animated: Bool) {
        self.GetDate()
        
    }

   
}
