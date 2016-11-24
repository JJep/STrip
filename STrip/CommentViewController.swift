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

    var id: Int!
    var uid: Int!
    var aid: Int!
    
    var activityComment: [DetailCommentList] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentText: UITextField!
    //toolBar的下约束
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBAction func sendBtn(_ sender: UIButton) {
        sendComment()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
        downloadtableViewData()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillChange(_:)),
                                               name: .UIKeyboardWillChangeFrame, object: nil)
        
    }
    
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
        
        uid = UserDefaults.standard.integer(forKey: "uid")
        
        let parameters = [
            "aid": aid,
            "uid": uid,
            "comment": commentText.text!
            ]  as [String : Any]
        
        print("parameters===============n \(parameters)")
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                //遍历上传参数
                for (key, value) in parameters {
                    
                    multipartFormData.append( String(describing: value).data(using: String.Encoding.utf8)!, withName: key)
                    
                }
                
            },
            to: (ConstValue.address + "/Trip5.0/comment/AddComment"),
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)

                        let json = response.result
                        let dict = json.value as! Dictionary<String, AnyObject>
                        let status = dict["status"] as! Int
                        switch status {
                        case 0:
                            let alertController = UIAlertController(title: "系统提示", message: "评论成功", preferredStyle: .alert)
                            let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                            alertController.addAction(cancelAction)
                            self.present(alertController, animated: true, completion: nil)

                        case 1:
                            let alertController = UIAlertController(title: "系统提示", message: "评论失败", preferredStyle: .alert)
                            let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                            alertController.addAction(cancelAction)
                            self.present(alertController, animated: true, completion: nil)
                        default:
                            break
                        }

                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        )
        

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell")
            as! CommentTableViewCell
        let item = activityComment[indexPath.row]
        cell.userName.text = item.userName
        //时间戳
        let timeStamp = item.time
        //转换为时间
        let timeInterval:TimeInterval = TimeInterval(timeStamp!)
        let date = NSDate(timeIntervalSince1970: timeInterval)
        
        //格式话输出
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        let dateString = dformatter.string(from: date as Date)
        
        cell.time.text = dateString
        let portraitUrl = ConstValue.address + "/Trip5.0/head/" + item.headPortrait
        cell.userPortrait.kf.setImage(with: URL(string: portraitUrl))
        
        let comment = item.comment
        cell.commentText.text = comment

        return cell


    }
    
    func downloadtableViewData() {
        let parameter = [
            "id" : id,
            "aid": aid
        ]
        Alamofire.request(ConstValue.address + "/Trip5.0/comment/QueryCommentPull", method: .post, parameters: parameter).responseJSON(completionHandler: { Response in
            
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
                    

                    print(json)
                    
                    let comments = DetailCommentRootClass(fromDictionary: json).list
                    self.activityComment = comments!
                    print(self.activityComment)
                    
                    OperationQueue.main.addOperation {
                        self.tableView.reloadData()
                    }
                    
                default:
                    break
                }
                
            case .failure(let Error):
                let alertController = UIAlertController(title: "系统提示", message: "网络无法连接", preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self.present(alertController, animated: true, completion: nil)
                print(Error)
            }
        })
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
