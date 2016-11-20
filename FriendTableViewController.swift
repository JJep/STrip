//
//  FriendTableViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/10/18.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit

class FriendTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置表格背景色
        self.tableView!.backgroundColor = UIColor(red: 0xf0/255, green: 0xf0/255,
                                                  blue: 0xf0/255, alpha: 1)
        //去除单元格分隔线
        self.tableView!.separatorStyle = .none
        
        //创建一个重用的单元格
        self.tableView!.register(UINib(nibName:"MessageTableViewCell", bundle:nil),
                                 forCellReuseIdentifier:"messageCell")
        

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
    
    
    var tableData = [["title":"Swift - 让标签栏按钮UITabBarItem图片居中","image":"img1.png"],
                     ["title":"Swift - 使用SSZipArchive实现文件的压缩、解压缩","image":"img2.png"],
                     ["title":"Swift - 使用LINQ操作数组/集合","image":"img3.png"],
                     ["title":"Swift - 给表格UITableView添加索引功能","image":"img4.png"],
                     ["title":"Swift - 列表项尾部附件点击响应","image":"img5.png"],
                     ["title":"Swift - 自由调整图标按钮中的图标和文字位置","image":"img6.png"]]
    
    override func loadView() {
        super.loadView()
    }
    
    //单元格高度
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)
        -> CGFloat {
            return 100
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell:MessageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "messageCell")
            as! MessageTableViewCell
        let item = tableData[indexPath.row]
        cell.nameLabel.text = item["title"]
        cell.customImageView.image = UIImage(named:item["image"]!)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
