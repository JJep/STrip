//
//  PersonalCenterTableViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/11/1.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//
import CoreData
import UIKit

class PersonalCenterTableViewController: UITableViewController {

    @IBOutlet weak var followLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var weiboLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userID: UILabel!

    func initBtn () {
        followLabel.text = "0\nFollow"
        followerLabel.text = "0\nFollower"
        weiboLabel.text = "0\nWeibo"
    }
    
    func initNavigationController () {
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.orange
        
        
        if let font = UIFont(name: "Avenir-Light", size: 23){
            self.navigationController?.navigationBar.titleTextAttributes = [
                NSForegroundColorAttributeName:UIColor.black,
                NSFontAttributeName:font
            ]
        }
    }
    
    func initUserInformation () {
        
        if UserDefaults.standard.integer(forKey: "uid") != 0 {
            print("UserDefaults.standard.integerForKey(\"uid\") = \(UserDefaults.standard.integer(forKey: "uid"))")
            userNameLabel.text = UserDefaults.standard.object(forKey: "userName") as? String
        } else {
            userNameLabel.text = "请登录"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initBtn()
        initNavigationController()
        initUserInformation()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    
//    
//    func initUserInformation () {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
//        do {
//            let searchResults = try getContext().fetch(fetchRequest)
//            print("numbers of \(searchResults.count)")
//            
//            for p in (searchResults as! [NSManagedObject]){
//                print("name:  \(p.value(forKey: "phoneNumber")!) age: \(p.value(forKey: "uid")!)")
//                if (p.value(forKey: "available")! == 1) {
//                        
//                }
//            }
//        } catch  {
//            print(error)
//        }
//    }
//    
//    //MARK: coreData相关函数设置
//    
//    //获取Context
//    func getContext () -> NSManagedObjectContext {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        return appDelegate.persistentContainer.viewContext
//    }
//    
//    //存储一条新数据
//    func storeUserInformation(available:NSNumber, phoneNumber:String, uid: NSNumber){
//        let context = getContext()
//        // 定义一个entity，这个entity一定要在xcdatamodeld中做好定义
//        let entity = NSEntityDescription.entity(forEntityName: "UserInformation", in: context)
//        
//        let userInformation = NSManagedObject(entity: entity!, insertInto: context)
//        
//        userInformation.setValue(available, forKey: "available")
//        userInformation.setValue(phoneNumber, forKey: "phoneNumber")
//        userInformation.setValue(uid, forKey: "uid")
//        
//        do {
//            try context.save()
//            print("saved")
//        }catch{
//            print(error)
//        }
//    }
//    
//    //删除旧数据
//    func deleteUserInformation () {
//        let context = getContext()
//        
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
//        do {
//            let searchResults = try getContext().fetch(fetchRequest)
//            print("numbers of \(searchResults.count)")
//            
//            for p in (searchResults as! [NSManagedObject]){
//                context.delete(p)
//                
//                print("name:  \(p.value(forKey: "phoneNumber")!) age: \(p.value(forKey: "uid")!) has been deleted")
//            }
//        } catch  {
//            print(error)
//        }
//        
//    }
//    
//    //获取entity的全部内容
//    func getUserinformation(){
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
//        do {
//            let searchResults = try getContext().fetch(fetchRequest)
//            print("numbers of \(searchResults.count)")
//            
//            for p in (searchResults as! [NSManagedObject]){
//                print("name:  \(p.value(forKey: "phoneNumber")!) age: \(p.value(forKey: "uid")!)")
//            }
//        } catch  {
//            print(error)
//        }
//    }
    

    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
    
    
    
    @IBAction func backToPersona (segue: UIStoryboardSegue) {
        UIApplication.shared.statusBarStyle = .default

    }


}
