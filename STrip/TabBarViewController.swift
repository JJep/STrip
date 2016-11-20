//
//  TabBarViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/10/24.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = UIColor.orange //设置选中颜色，这里使用黄色
        var items: [UITabBarItem] = self.tabBar.items!
        
        let tabbar0SelectedImage = UIImage(named: "05")
        
        let tabbar1SelectedImage = UIImage(named: "06")
        
        let tabbar2SelectedImage = UIImage(named: "07")

        let tabbar3SelectedImage = UIImage(named: "08")

        items[0].selectedImage = tabbar0SelectedImage!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        items[1].selectedImage = tabbar1SelectedImage!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        
        items[2].selectedImage = tabbar2SelectedImage!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

        items[3].selectedImage = tabbar3SelectedImage!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

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
