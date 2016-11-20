//
//  DiscoverTableViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/11/5.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit

class DiscoverTableViewController: UITableViewController {
    
    
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
    

    var tableData = [
        ["headPotrait": "头像",
         "userName": "西游行者",
         "status": "进行中",
         "activityText": "11月7号成都出发，去看晚秋的青杨林，冬日里的红房子，稻城亚丁色达，8天时间，费用AA，沿途边走边玩。不限年龄，不限性别，说走就走。有兴趣的一起来。",
         "pic1": "gallery1",
         "pic2": "gallery2",
         "pic3": "gallery3"
         ],
        ["headPotrait": "头像",
         "userName": "冬游行者",
         "status": "进行中",
         "activityText": "号成都出发，去看房子，稻城亚丁色达用AA，沿途晚秋的青杨林，冬日里的红边走边玩。不限年龄，不限性别，说走就走。有兴趣，8天时间，费的一起发饰发夹死哦分萨基哦发丝哦附加赛哦分   上飞机哦减肥 i 哦啊师傅 分萨基哦分数来。",
         "pic1": "gallery1",
         "pic2": "gallery2",
         "pic3": "gallery3"
        ]
    ]
    
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
        return self.tableData.count
    }



    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowDetailActivity", sender: 1)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
        
        let item = tableData[indexPath.row]
        
        cell.headPortrait.image = UIImage(named: item["headPotrait"]!)
        cell.userName.text = item["userName"]
        cell.status.text = item["status"]
        cell.activityText.text = item["activityText"]
        cell.pic1.image = UIImage(named: item["pic1"]!)
        cell.pic2.image = UIImage(named: item["pic2"]!)
        cell.pic3.image = UIImage(named: item["pic3"]!)
        
        return cell
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
            let controller = segue.destination as! DetailActivityViewController
            print("doingPrepare")
            self.tabBarController?.tabBar.isHidden = true
        }
    }
 

}
