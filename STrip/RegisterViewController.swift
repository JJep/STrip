//
//  RegisterViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/10/14.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {

    @IBOutlet weak var SMSText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var phoneNumberText: UITextField!
    
    @IBAction func getCode(_ sender: UIButton) {
        
        let phoneNumber = phoneNumberText.text
        
        if phoneNumber == "" {
            let alertController = UIAlertController(title: "系统提示", message: "请输入手机号", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            getCode(phoneNumber: phoneNumber!)
        }
        
        
    }
    
    @IBAction func toRegister(_ sender: UIButton) {
        let phoneNumber = phoneNumberText.text
        let password = passwordText.text
        let code = SMSText.text
        
        if phoneNumber == "" {
            let alertController = UIAlertController(title: "系统提示", message: "请输入手机号", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else if password == "" {
            let alertController = UIAlertController(title: "系统提示", message: "请输入密码", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else if code == "" {
            let alertController = UIAlertController(title: "系统提示", message: "请输入验证码", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
                register(phoneNumber: phoneNumber!, code: code!, passWord: password!)
        }
        
        
    }
    
    func getCode(phoneNumber: String) {
        
        let parameters = [
            "phoneNumber": phoneNumber,
        ]
        
        Alamofire.request("http://192.168.1.112:8080/Trip/GetCodeServlet?", method: .post, parameters:parameters)
            .responseJSON(completionHandler:{ Response in
                
                switch Response.result {
                    
                case .success(let json):
                    let dict = json as! Dictionary<String, AnyObject>
                    let status = dict["status"] as! Int
                    print(dict)
                    switch status {
                    case 1:
                        //用户名或密码错误或用户不存在
                        let alertController = UIAlertController(title: "系统提示", message: "该用户已被注册", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                        alertController.addAction(cancelAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    case 0:
                        /**登录成功并提示**/
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
            })
    }
    
    func register(phoneNumber: String, code: String, passWord:String) {
        
        let parameters = [
            "phoneNumber": phoneNumber,
            "code": code,
            "passWord": passWord
            ]
        
        Alamofire.request("http://192.168.1.112:8080/Trip/Register?", method: .post, parameters:parameters)
            .responseJSON(completionHandler:{ Response in
                
                switch Response.result {
                    
                case .success(let json):
                    let dict = json as! Dictionary<String, AnyObject>
                    let status = dict["status"] as! Int
                    print(dict)
                    switch status {
                    case 1:
                        //用户名或密码错误或用户不存在
                        let alertController = UIAlertController(title: "系统提示", message: "验证码错误或已过期", preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                        alertController.addAction(cancelAction)
                        
                        self.present(alertController, animated: true, completion: nil)
                    case 0:
                        /**登录成功并提示**/
                        let alertController = UIAlertController(title: "系统提示", message: "注册成功", preferredStyle: .alert)
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
            })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordText.isSecureTextEntry = true


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
