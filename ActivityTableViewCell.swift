//
//  ActivityTableViewCell.swift
//  STrip
//
//  Created by Jep Xia on 16/11/5.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit
import Alamofire

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var headPortrait: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var activityText: UILabel!
    @IBOutlet weak var pic1: UIImageView!
    @IBOutlet weak var pic2: UIImageView!
    @IBOutlet weak var pic3: UIImageView!
    
    @IBOutlet weak var likePeopleNum: UIButton!
    @IBOutlet weak var CommentNum: UIButton!
    @IBOutlet weak var joinedPeopleNum: UIButton!
    
    
    var aid: Int!
    
    var isloved = false { didSet { updateUI() } }
    var isjoined = false { didSet { updateUI() } }
    var delegate : LogManagerDelegate?

    @IBAction func likeBtn(_ sender: UIButton) {
        
        if isloved {
            cancelLike()
        } else {
            uploadLove()
        }
        isloved = !isloved
    }
    @IBAction func joinBtn(_ sender: UIButton) {
        
        if isjoined {
            cancelJoin()
        } else {
            uploadJoin()
        }
        isjoined = !isjoined
    }
    @IBAction func commentBtn(_ sender: UIButton) {

        delegate = DiscoverTableViewController()
        func login() {
            //查看是否有委托，然后调用它
            delegate?.writeLog()
        }
        
//        login()
        
//        var story =  UIStoryboard(name: "Main", bundle: nil)
//        var storVC =  story(identifier:"VC")
//        self.presentViewController(storyVC, animated: true, completion: nil)
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    fileprivate func updateUI () {
        if isloved {
            likePeopleNum.setTitleColor(UIColor.red, for: .normal)
        } else {
            likePeopleNum.setTitleColor(UIColor.gray, for: .normal)
        }
        
        if isjoined {
            joinedPeopleNum.setTitleColor(UIColor.red, for: .normal)
        } else {
            joinedPeopleNum.setTitleColor(UIColor.gray, for: .normal)
        }
    }
    
    func cancelJoin() {
        
        let parameters = [
            "aid": aid,
            "uid": UserDefaults.standard.integer(forKey: "uid")
        ]
        
        Alamofire.request(ConstValue.address + "/Trip5.0/activity/CancelJoinActivity", method: .post, parameters: parameters)
            .responseJSON(completionHandler:{ Response in
                
                switch Response.result {
                    
                case .success(let json):
                    let dict = json as! Dictionary<String, AnyObject>
                    let status = dict["status"] as! Int
                    print(dict)
                    switch status {
                    case 0:
                        break
                    default:
                        self.isjoined = true
                    }
                case .failure (let error):
                    print("\(error)")
                    self.isjoined = true
                }
                
                OperationQueue.main.addOperation {
                    
                    
                }
                
            })
    }
    
    func cancelLike() {
        
        let parameters = [
            "aid": aid,
            "uid": UserDefaults.standard.integer(forKey: "uid")
        ]
        
        Alamofire.request(ConstValue.address + "/Trip5.0/activity/CancelLiked", method: .post, parameters: parameters)
            .responseJSON(completionHandler:{ Response in
                
                switch Response.result {
                    
                case .success(let json):
                    let dict = json as! Dictionary<String, AnyObject>
                    let status = dict["status"] as! Int
                    print(dict)
                    switch status {
                    case 0:
                        break
                    default:
                        self.isloved = true
                    }
                case .failure (let error):
                    print("\(error)")
                    self.isloved = true
                }
                
                OperationQueue.main.addOperation {
                    
                    
                }
                
            })
    }
    
    func uploadJoin() {
        
        let parameters = [
            "aid": aid,
            "uid": UserDefaults.standard.integer(forKey: "uid")
        ]
        
        Alamofire.request(ConstValue.address + "/Trip5.0/activity/JoinActivity", method: .post, parameters: parameters)
            .responseJSON(completionHandler:{ Response in
                
                switch Response.result {
                    
                case .success(let json):
                    let dict = json as! Dictionary<String, AnyObject>
                    let status = dict["status"] as! Int
                    print(dict)
                    switch status {
                    case 0:
                        break
                    default:
                        self.isjoined = false
                    }
                case .failure (let error):
                    print("\(error)")
                    self.isjoined = false
                }
                
                OperationQueue.main.addOperation {
                    
                    
                }
                
            })

    }
    
    func uploadLove () {
        
        let parameters = [
            "aid": aid,
            "uid": UserDefaults.standard.integer(forKey: "uid")
        ]
        
        Alamofire.request(ConstValue.address + "/Trip5.0/activity/LikedButton", method: .post, parameters: parameters)
            .responseJSON(completionHandler:{ Response in
                
                switch Response.result {
                    
                case .success(let json):
                    let dict = json as! Dictionary<String, AnyObject>
                    let status = dict["status"] as! Int
                    print(dict)
                    switch status {
                    case 0:
                        break
                    default:
                        self.isloved = false
                    }
                case .failure (let error):
                    print("\(error)")
                    self.isloved = false
                }
                
                OperationQueue.main.addOperation {
                   
                    
                }
                
            })
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
