//
//  TestLoginViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/10/18.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

class TestLoginViewController: UIViewController {

    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var usernameText: UITextField!

    @IBAction func loginBtn(_ sender: UIButton) {
        let phonerNumber = usernameText.text
        let password = passwordText.text
            
            if phonerNumber != "" && password != ""{
                spinner.startAnimating()
                
                httpRequestLoginByPassword(phoneNumber: phonerNumber!, password: password!)
            } else if phonerNumber == "" {
                let alertController = UIAlertController(title: "系统提示", message: "请输入用户名", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                let alertController = UIAlertController(title: "系统提示", message: "请输入密码", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
            }
       
    }
    
    
    func httpRequestLoginByPassword(phoneNumber: String, password: String) {
        
        let parameters = [
            "phoneNumber": phoneNumber,
            "passWord": password
        ]
        
        
        Alamofire.request("http://192.168.1.32:8080/Trip/LoginByPassWord", method: .post, parameters:parameters)
            .responseJSON(completionHandler:{ Response in
                
                switch Response.result {
                    
                case .success(let json):
                    let dict = json as! Dictionary<String, AnyObject>
                    let status = dict["status"] as! Int
                    print(dict)
                    switch status {
                    case 1:
                        //用户名或密码错误或用户不存在
                        let alertController = UIAlertController(title: "系统提示", message: "用户名或密码错误或用户不存在", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                        alertController.addAction(cancelAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                        print("用户名或密码错误或用户不存在")
                        print("swich中sign的值：\(status)")
                    case 0:
                        print("\(type(of: dict["uid"]))")
                        let uid = dict["uid"] as! NSNumber
                        self.deleteUserInformation()
                        self.storeUserInformation(available: 1, phoneNumber: phoneNumber, uid: uid)
                        self.getUserinformation()

                        
                        
                        /**登录成功并提示**/
                        let alertController = UIAlertController(title: "系统提示", message: "登录成功", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                        alertController.addAction(cancelAction)
                        self.present(alertController, animated: true, completion: nil)
                        print("成功")
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
                self.spinner.stopAnimating()
            })
    }
    
    
    //MARK: coreData相关函数设置
    
    //获取Context
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    //存储一条新数据
    func storeUserInformation(available:NSNumber, phoneNumber:String, uid: NSNumber){
        let context = getContext()
        // 定义一个entity，这个entity一定要在xcdatamodeld中做好定义
        let entity = NSEntityDescription.entity(forEntityName: "UserInformation", in: context)
        
        let userInformation = NSManagedObject(entity: entity!, insertInto: context)
        
        userInformation.setValue(available, forKey: "available")
        userInformation.setValue(phoneNumber, forKey: "phoneNumber")
        userInformation.setValue(uid, forKey: "uid")
        
        do {
            try context.save()
            print("saved")
        }catch{
            print(error)
        }
    }
    
    //删除旧数据
    func deleteUserInformation () {
        let context = getContext()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            print("numbers of \(searchResults.count)")
            
            for p in (searchResults as! [NSManagedObject]){
                context.delete(p)
                
                print("name:  \(p.value(forKey: "phoneNumber")!) age: \(p.value(forKey: "uid")!) has been deleted")
            }
        } catch  {
            print(error)
        }

    }

    //获取entity的全部内容
    func getUserinformation(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            print("numbers of \(searchResults.count)")
            
            for p in (searchResults as! [NSManagedObject]){
                print("name:  \(p.value(forKey: "phoneNumber")!) age: \(p.value(forKey: "uid")!)")
            }
        } catch  {
            print(error)
        }
    }
    
    

    
    func initNavigationBar () {
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        if let font = UIFont(name: "Avenir-Light", size: 23){
            self.navigationController?.navigationBar.titleTextAttributes = [
                NSForegroundColorAttributeName:UIColor.white,
                NSFontAttributeName:font
            ]
        }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.backgroundColor = UIColor(colorLiteralRed: 153/255, green: 204/255, blue: 250/255, alpha: 1.0)
        initNavigationBar()
        spinner.hidesWhenStopped = true
        
        UIApplication.shared.statusBarStyle = .lightContent



    }

    override func viewDidAppear(_ animated: Bool) {

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
