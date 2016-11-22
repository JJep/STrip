//
//  DetailActivityViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/11/8.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit

class DetailActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailLabel: UILabel!

    

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
    
    func extraHeight () -> CGFloat {
        let font = detailLabel.font!
        let width = self.view.bounds.width
        let height = getLabHeight(labelStr: detailLabel.text! , font: font, width: width)
        
        return height
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailView.bounds.size.height += extraHeight()

        initTableView()
        
        
        // Do any additional setup after loading the view.
    }
    
    func initTableView () {
        
        detailTableView.delegate = self
        detailTableView.dataSource = self
        
        //设置表格背景色
        detailTableView!.backgroundColor = UIColor(red: 0xf0/255, green: 0xf0/255,
                                             blue: 0xf0/255, alpha: 1)
        //去除单元格分隔线
        detailTableView!.separatorStyle = .none
        
        //创建一个重用的单元格
        detailTableView!.register(UINib(nibName:"CommentTableViewCell", bundle:nil), forCellReuseIdentifier:"commentCell")
        
        detailTableView.estimatedRowHeight = 44.0
        
        detailTableView.rowHeight = UITableViewAutomaticDimension
    
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell")
            as! CommentTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showComment", sender: 1)
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
