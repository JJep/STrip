//
//  DatePickerViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/10/23.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    
    var publicDate: String!
    
    @IBOutlet  var dpicker:UIDatePicker!
    @IBOutlet  var completeBtn:UIButton!
    
    @IBAction func competeBtnClicked(_ sender:UIButton) {
        let date = dpicker.date
        
        // 创建一个日期格式器
        let dformatter = DateFormatter()
        // 为日期格式器设置格式字符串
        dformatter.dateFormat = "yyyy-MM-dd"
        // 使用日期格式器格式化日期、时间
        let datestr = dformatter.string(from: date)
        
        publicDate = datestr

        print(publicDate)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dpicker.locale = Locale(identifier: "zh_CN")
        dpicker.datePickerMode = .date
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
