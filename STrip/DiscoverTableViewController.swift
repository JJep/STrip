//
//  DiscoverTableViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/11/5.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class DiscoverTableViewController: UITableViewController {
    
    var list: [ActivityCell] = []
    var aid: Int!
    
    //MARK: label行高的相关设置
    func getLabHeight(labelStr:String,font:UIFont,width:CGFloat) -> CGFloat {
        
        let statusLabelText: NSString = labelStr as NSString
        
        let size = CGSize(width: width, height: 900)
        
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context:nil).size
        
        return strSize.height
        
    }
    
    func getLabWidth(labelStr:String,font:UIFont,height:CGFloat) -> CGFloat {
        
        let statusLabelText: NSString = labelStr as NSString
        
        let size = CGSize(width:900, height: height)
        
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context:nil).size
        
        return strSize.width
        
    }
        
    func initTableView () {
        
        //设置表格背景色
        tableView!.backgroundColor = UIColor(red: 0xf0/255, green: 0xf0/255,
                                             blue: 0xf0/255, alpha: 1)
        //去除单元格分隔线
        tableView!.separatorStyle = .none
        
        //创建一个重用的单元格
        tableView!.register(UINib(nibName:"ActivityTableViewCell", bundle:nil),
                            forCellReuseIdentifier:"activityCell")
        
        
        tableView.estimatedRowHeight = 44.0
        
        tableView.rowHeight = UITableViewAutomaticDimension

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        
        downloadData()

        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(downloadData) , for: .valueChanged)

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }



    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowDetailActivity", sender: 1)
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
        
//        let item = tableData[indexPath.row]
        
        let item = list[indexPath.row]
        
        let portraitUrl = ConstValue.address + "/Trip5.0/head/" + item.portrait
        cell.headPortrait.kf.setImage(with: URL(string: portraitUrl))
        
        cell.tag = item.aid
        cell.activityText.text = item.activityText
        cell.userName.text = item.userName
        
        var condition = ""
        switch item.condition {
        case 0:
            condition = "进行中"
        default:
            break
        }
        cell.status.text = condition
        
        
        let thumbArray = item.image.components(separatedBy: ",")
        print("thumbArray==================================\nthumbArray.count = \(thumbArray.count)")
        for i in 0..<thumbArray.count {
            print(thumbArray[i])
        }
        switch thumbArray.count {
        case 2:
            let pic1 = ConstValue.address + "/Trip5.0/thumbnails/" + thumbArray[0]
            print(pic1)
            cell.pic1.kf.setImage(with: URL(string: pic1))
            cell.pic2.isHidden = true
            cell.pic3.isHidden = true

        case 3:
            let pic1 = ConstValue.address + "/Trip5.0/thumbnails/" + thumbArray[0]
            let pic2 = ConstValue.address + "/Trip5.0/thumbnails/" + thumbArray[1]
            print(pic1)
            print(pic2)
            cell.pic1.kf.setImage(with: URL(string: pic1))
            cell.pic2.kf.setImage(with: URL(string: pic2))
            cell.pic2.isHidden = false
            cell.pic3.isHidden = true
        case 4:
            let pic1 = ConstValue.address + "/Trip5.0/thumbnails/" + thumbArray[0]
            let pic2 = ConstValue.address + "/Trip5.0/thumbnails/" + thumbArray[1]
            let pic3 = ConstValue.address + "/Trip5.0/thumbnails/" + thumbArray[2]
            print(pic1)
            print(pic2)
            print(pic3)
            cell.pic1.kf.setImage(with: URL(string: pic1))
            cell.pic2.kf.setImage(with: URL(string: pic2))
            cell.pic3.kf.setImage(with: URL(string: pic3))
            cell.pic2.isHidden = false
            cell.pic3.isHidden = false
            

        default:
            break
        }
        
        
        return cell
    }
    
    func downloadData () {
        
        Alamofire.request(ConstValue.address + "/Trip5.0/activity/showActivity", method: .post)
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
                        
                        let lives = STripActivity(fromDictionary: json).list!
                        
                        self.list = lives.map({ (list) -> ActivityCell in
                            return ActivityCell(userName: list.userName, portrait: list.headPortrait, condition: list.status, image: list.thumbnail, activityText: list.description, aid: list.id)
                        })
                            
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
                
                dump(self.list)
                
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                    self.refreshControl?.endRefreshing()
                }

            })
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    
    //在这个方法中给新页面传递参数

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailActivity"{
            let destVC = segue.destination as! DetailActivityViewController
            print("doingPrepare====================\n")
            self.tabBarController?.tabBar.isHidden = true
            let index = tableView.indexPathForSelectedRow
            destVC.aid = tableView.cellForRow(at: index!)?.tag
            let num = index?.row
            let item = self.list[num!]
            destVC.detailActivityText = item.activityText
            destVC.thumbnails = item.image
            destVC.userName = item.userName
            print("aid=\(destVC.aid)")
        }
    }
 

}
