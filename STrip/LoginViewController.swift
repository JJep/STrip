//
//  LoginViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/10/11.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var SMSView: UIView!
    
    @IBOutlet weak var SMStext: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    
    var status = 1
    
    @IBAction func leftBtn(_ sender: UIButton) {
        SMSView.isHidden = true
        passwordView.isHidden = false
        rightView.isHidden = true
        leftView.isHidden = false
        leftBtn.tintColor = UIColor.blue
        rightBtn.tintColor = UIColor.gray
        status = 1
    }
    
    @IBAction func rightBtn(_ sender: UIButton) {
        SMSView.isHidden = false
        passwordView.isHidden = true
        rightView.isHidden = false
        leftView.isHidden = true
        leftBtn.tintColor = UIColor.gray
        rightBtn.tintColor = UIColor.blue
        status = 2
    }
    
    @IBAction func getCode(_ sender: UIButton) {
        let phoneNumber = usernameText.text
        httpRequestGetCode(phoneNumber: phoneNumber!)
    }
    
    @IBAction func loginBtn(_ sender: UIButton) {
        let phonerNumber = usernameText.text
        let password = passwordText.text
        let code = SMStext.text
        
        if status == 1 {

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
        
        if status == 2 {
            if phonerNumber == "" {
                let alertController = UIAlertController(title: "系统提示", message: "请输入手机号", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
            } else if code == ""{
                let alertController = UIAlertController(title: "系统提示", message: "请输入验证码", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                spinner.startAnimating()
                httpRequestLoginByCode(phoneNumber: phonerNumber!, code: code!)
            }
        }
        
    }
    
    func httpRequestGetCode (phoneNumber: String) {

        let parameters = [
            "phoneNumber": phoneNumber
        ]
        Alamofire.request("http://192.168.1.112:8080/Trip/GetLoginCode", method: .post, parameters:parameters)
            .responseJSON(completionHandler:{ Response in
                
                switch Response.result {
                    
                case .success(let json):
                    let dict = json as! Dictionary<String, AnyObject>
                    let status = dict["status"] as! Int
                    print(dict)
                    switch status {
                    case 1:
                        let alertController = UIAlertController(title: "系统提示", message: "该用户未注册", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                        alertController.addAction(cancelAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                    case 0:
                        let alertController = UIAlertController(title: "系统提示", message: "验证码已发送", preferredStyle: .alert)
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
    
    func httpRequestLoginByPassword(phoneNumber: String, password: String) {

        let parameters = [
            "phoneNumber": phoneNumber,
            "passWord": password
        ]
        
        Alamofire.request("http://192.168.1.112:8080/Trip/LoginByPassWord", method: .post, parameters:parameters)
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
//                        print("\(type(of: dict["uid"]))")
//                        let uid = dict["uid"] as! NSNumber
//                        /**删除本地数据**/
//                        let appDel = UIApplication.shared.delegate as! AppDelegate
//                        //获取管理的上下文
//                        let context = appDel.managedObjectContext
//                        // 声明数据请求实体
//                        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
//                        //执行查询操作
//                        do {
//                            let UserInformationList =
//                                try context.fetch(fetchRequest) as! [NSManagedObject]
//                            print("打印查询结果")
//                            for userInformation in UserInformationList as! [UserInformation] {
//                                print("查询到的人是\(userInformation.available)")
//                                //修改操作:将查询到的结果修改后，再调用context.save()保存即可
//                                if (userInformation.available == 1){
//                                    context.delete(userInformation)
//                                }
//                                //删除操作:将查询到的额结果删除后，再调用context.save()保存即可
//                                if (userInformation.available == 0){
//                                    context.delete(userInformation)
//                                }
//                            }
//                        } catch let error{
//                            print("context can't fetch!, Error:\(error)")
//                        }
//                        do {
//                            try context.save()
//                            print("保存成功")
//                        }catch let error{
//                            print("context can't save!, Error:\(error)")
//                        }
//                        /**保存数据到本地**/
//                        let userInformation = NSEntityDescription.insertNewObject(forEntityName: "UserInformation", into: context)as! UserInformation
//                        
//                        userInformation.available = 1
//                        userInformation.phoneNumber = phoneNumber
//                        userInformation.password = passWord
//                        userInformation.uid = uid
//                        do {
//                            try context.save()
//                            print("保存成功")
//                            
//                        }catch let error{
//                            print("context can't save!, Error:\(error)")
//                        }
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
    
    func httpRequestLoginByCode(phoneNumber: String, code: String) {
        
        let parameters = [
            "phoneNumber": phoneNumber,
            "code": code
        ]
        
        Alamofire.request("http://192.168.1.112:8080/Trip/LoginByCode", method: .post, parameters:parameters)
            .responseJSON(completionHandler:{ Response in
                
                switch Response.result {
                    
                case .success(let json):
                    let dict = json as! Dictionary<String, AnyObject>
                    let status = dict["status"] as! Int
                    print(dict)
                    switch status {
                    case 1:
                        //用户名或密码错误或用户不存在
                        let alertController = UIAlertController(title: "系统提示", message: "验证码错误或过期", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                        alertController.addAction(cancelAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                        
                        print("用户名或密码错误或用户不存在")
                        print("swich中sign的值：\(status)")
                    case 0:
                        //                        print("\(type(of: dict["uid"]))")
                        //                        let uid = dict["uid"] as! NSNumber
                        //                        /**删除本地数据**/
                        //                        let appDel = UIApplication.shared.delegate as! AppDelegate
                        //                        //获取管理的上下文
                        //                        let context = appDel.managedObjectContext
                        //                        // 声明数据请求实体
                        //                        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInformation")
                        //                        //执行查询操作
                        //                        do {
                        //                            let UserInformationList =
                        //                                try context.fetch(fetchRequest) as! [NSManagedObject]
                        //                            print("打印查询结果")
                        //                            for userInformation in UserInformationList as! [UserInformation] {
                        //                                print("查询到的人是\(userInformation.available)")
                        //                                //修改操作:将查询到的结果修改后，再调用context.save()保存即可
                        //                                if (userInformation.available == 1){
                        //                                    context.delete(userInformation)
                        //                                }
                        //                                //删除操作:将查询到的额结果删除后，再调用context.save()保存即可
                        //                                if (userInformation.available == 0){
                        //                                    context.delete(userInformation)
                        //                                }
                        //                            }
                        //                        } catch let error{
                        //                            print("context can't fetch!, Error:\(error)")
                        //                        }
                        //                        do {
                        //                            try context.save()
                        //                            print("保存成功")
                        //                        }catch let error{
                        //                            print("context can't save!, Error:\(error)")
                        //                        }
                        //                        /**保存数据到本地**/
                        //                        let userInformation = NSEntityDescription.insertNewObject(forEntityName: "UserInformation", into: context)as! UserInformation
                        //
                        //                        userInformation.available = 1
                        //                        userInformation.phoneNumber = phoneNumber
                        //                        userInformation.password = passWord
                        //                        userInformation.uid = uid
                        //                        do {
                        //                            try context.save()
                        //                            print("保存成功")
                        //
                        //                        }catch let error{
                        //                            print("context can't save!, Error:\(error)")
                        //                        }
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
    
    func initView () {
        SMSView.isHidden = true
        passwordView.isHidden = false
        rightView.isHidden = true
        leftView.isHidden = false
//        self.navigationController?.navigationBar.backgroundColor = UIColor.blue
        spinner.hidesWhenStopped = true
        print(usernameText.text)
        leftBtn.tintColor = UIColor.blue
        rightBtn.tintColor = UIColor.gray
        passwordText.isSecureTextEntry = true



    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        let navigationBarHeght = self.navigationController?.navigationBar.bounds.height
        print("naviagtionBarHeight = \(navigationBarHeght)")
        
        // Do any additional setup after loading the view.
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
