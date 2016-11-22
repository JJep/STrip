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
        
        let uid = 3
        UserDefaults.standard.set(uid, forKey: "uid")
        UserDefaults.standard.synchronize()
        
        
        let id = UserDefaults.standard.integer(forKey: "uid")
        print("id===========================\n\(id)")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

