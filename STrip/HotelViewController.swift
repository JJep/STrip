//
//  HotelViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/11/29.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class HotelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var key = ""
    var hotelLists: [HotelList] = []
    
    @IBAction func tapBack(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        initTableView()

        downloadData()
        
        // Do any additional setup after loading the view.
    }

    func initTableView () {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //设置表格背景色
        tableView!.backgroundColor = UIColor(red: 0xf0/255, green: 0xf0/255,
                                             blue: 0xf0/255, alpha: 1)
        //去除单元格分隔线
        tableView!.separatorStyle = .none
        
        //创建一个重用的单元格
//        tableView!.register(UINib(nibName:"HotelTableViewCell", bundle:nil), forCellReuseIdentifier:"hotelCell")
//        tableView.estimatedRowHeight = 44.0
//        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(downloadData) , for: .valueChanged)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hotelLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hotelCell", for: indexPath) as! HotelTableViewCell
        
        let item = hotelLists[indexPath.row]
        cell.hotelName.text = item.hotelName
        cell.hotelScore.text = "\(item.hotelScore!)"
        cell.hotelLocation.text = item.hotelArea
        cell.hotelPrice.text = "\(item.hotelPrice!)"
        
        let imageUrl = item.hotelImag
        cell.hotelImage.kf.setImage(with: URL(string: imageUrl!))

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(DetailHotelViewController(), animated: true)
    }
    
    func downloadData () {
        let parameters = [
            "key": key
        ]
        
        Alamofire.request(ConstValue.address + "/Trip5.0/hotel/ShowHotelByKeyName", method: .post, parameters: parameters)
            .responseJSON(completionHandler:{ Response in
                
                switch Response.result {
                    
                case .success(let json):
                    let dict = json as! Dictionary<String, AnyObject>
                    let status = dict["status"] as! Int
                    print(dict)
                    switch status {
                    case 0:
                        print("\(type(of: dict["uid"]))")
                        guard let json = json as? NSDictionary else {
                            return
                        }
                        
                        let lists = Hotel(fromDictionary: json).list!
                        self.hotelLists = lists
                        dump(self.hotelLists)
                    default:
                        break
                    }
                case .failure (let error):
                    let alertController = UIAlertController(title: "系统提示", message: "网络无法连接", preferredStyle: .alert)
                    let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                    alertController.addAction(cancelAction)
                    self.present(alertController, animated: true, completion: nil)
                    print("\(error)")
                }
                
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                    self.tableView.refreshControl?.endRefreshing()
                }
                
            })

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
