//
//  CommentViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/11/20.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit
import Alamofire

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentText: UITextField!
    //toolBar的下约束
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBAction func sendBtn(_ sender: UIButton) {
        sendComment()
    }
    
    var commentData: NSArray!
    
    //MARK: textField的相关设置
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ shouldChangeTextIntextView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            commentText.resignFirstResponder()
            return false
        }
        return true
    }
    
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillChange(_:)),
                                               name: .UIKeyboardWillChangeFrame, object: nil)
        // Do any additional setup after loading the view.
    }
    
    // 键盘改变
    func keyboardWillChange(_ notification: Notification) {
        if let userInfo = notification.userInfo,
            let value = userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? Double,
            let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt {
            
            let frame = value.cgRectValue
            let intersection = frame.intersection(self.view.frame)
            
            //self.view.setNeedsLayout()
            //改变下约束
            self.bottomConstraint.constant = intersection.height
            
            UIView.animate(withDuration: duration, delay: 0.0,
                           options: UIViewAnimationOptions(rawValue: curve), animations: {
                            _ in
                            self.view.layoutIfNeeded()
                }, completion: nil)
        }
    }
    
    @IBAction func sendMessage(_ sender: AnyObject) {
        //关闭键盘
        commentText.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func initTableView () {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //设置表格背景色
        tableView!.backgroundColor = UIColor(red: 0xf0/255, green: 0xf0/255,
                                                   blue: 0xf0/255, alpha: 1)
        //去除单元格分隔线
        tableView!.separatorStyle = .none
        
        //创建一个重用的单元格
        tableView!.register(UINib(nibName:"CommentTableViewCell", bundle:nil), forCellReuseIdentifier:"commentCell")
        
        tableView.estimatedRowHeight = 44.0
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    
    func sendComment () {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell")
            as! CommentTableViewCell
        
        return cell

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
