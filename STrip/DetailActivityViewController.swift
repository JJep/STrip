//
//  DetailActivityViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/11/8.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class DetailActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var aid: Int!
    
    var detailActivity: StripDetailActivity!
    var rootActivity: StripRootActivity!
    var activityComment: [StripComment] = []
    var detailActivityText: String!
    var thumbnails: String!
    var userName: String!

    @IBOutlet weak var detailTableView: UITableView!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var detailLabel: UILabel!

    
    @IBOutlet weak var portrait: UIImageView!
    @IBOutlet weak var nikiLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var detailTextLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var returnTimeLabel: UILabel!
    @IBOutlet weak var startPlaceLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var costsLabel: UILabel!
    @IBOutlet weak var peopleNumLabel: UILabel!
    @IBOutlet weak var requiredLabel: UILabel!
    @IBOutlet weak var picImageView: UIImageView!
    

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
        loadDetailActivity()
        
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
        return activityComment.count
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
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
        
        if let comment = item.comment as? String{
            print(comment)
            cell.commentText.text = comment
        }
        
        cell.tag = item.id
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showComment", sender: 1)
    }
    
    
    func loadDetailActivity () {
        
        let parameters = [
            "aid" : aid
        ]
        Alamofire.request(ConstValue.address + "/Trip5.0/activity/QueryOneActivity", method: .post, parameters: parameters).responseJSON(completionHandler: { Response in
            
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
                    
                    let comments = StripRootActivity(fromDictionary: json).comments
                    let detailActivity = StripRootActivity(fromDictionary: json).detailActivity
                    
                    self.detailActivity = detailActivity
                    self.activityComment = comments!

                    OperationQueue.main.addOperation {
                        self.initDetailActivity()
                        self.detailTableView.reloadData()
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
    
    func initDetailActivity() {
        var condition: String = ""
        switch detailActivity.status {
        case 0:
            condition = "进行中"
        default:
            break
        }
        self.conditionLabel.text = condition
        self.costsLabel.text = detailActivity.costs
        self.destinationLabel.text = detailActivity.destination
        self.requiredLabel.text = detailActivity.required as? String
        self.nikiLabel.text = userName
        self.detailLabel.text = detailActivityText
        self.peopleNumLabel.text = String(detailActivity.peopleNum) + "人"
        self.startTimeLabel.text = detailActivity.departureTime
        self.returnTimeLabel.text = detailActivity.returnTime
        self.startPlaceLabel.text = detailActivity.birthland
        self.destinationLabel.text = detailActivity.destination
        self.aid = detailActivity.id
        
        if let thumbnail = thumbnails {
            let thumbArray = thumbnail.components(separatedBy: ",")
            print("thumbArray==================================\nthumbArray.count = \(thumbArray.count)")
            for i in 0..<thumbArray.count {
                print(thumbArray[i])
            }
            let imageUrl = thumbArray[0]
            let pic1 = ConstValue.address + "/Trip5.0/thumbnails/" + imageUrl
            self.picImageView.kf.setImage(with: URL(string: pic1))

        }
        
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showComment" {
            let destVC = segue.destination as! CommentViewController
            print("aid================\n\(self.aid)")
            destVC.aid = self.aid
            destVC.id = activityComment[0].id + 1
        }
        
    }
 

}
