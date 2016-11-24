//
//  ViewController.swift
//  Test
//
//  Created by Jep Xia on 16/11/22.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
                            return ActivityCell(userName: list.userName, portrait: list.headPortrait, condition: list.status, image: list.thumbnail, activityText: list.description)
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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

