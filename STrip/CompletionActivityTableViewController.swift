//
//  CompletionActivityTableViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/10/21.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit
import Alamofire
import Photos

class CompletionActivityTableViewController: UITableViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var chooseImgBtn: UIButton!
    @IBOutlet weak var tripTextView: UITextView!
    @IBOutlet weak var addingImageView: UIView!
    @IBOutlet weak var topView: UIView!
    
    @IBAction func chooseImgAction(_ sender: AnyObject) {
        //  跳转页面
        let photosVC = AllPhotosViewController()
        present(photosVC, animated: true, completion: nil)
    }
    
    var  initialText: String!
    
    var parameters: [String: Any]!
    var imageArray = [UIImage]()
    var imageName = [String]()
    var imageNSURLs: [NSURL]!
    var imageAssets: [PHAsset]!
    
    var birthLand: String!
    var destination: String!
    var departureTime: String!
    var returnTime: String!
    var shareHouse: Int!
    var require: String!
    var peopleNum: Int!
    var costs: String!
    var budget: Int!
    
    func setParameters ()  {
        
        parameters = [
            "Birthland": birthLand,//出发地
            "Destination": destination,//目的地
            "departure_Time": departureTime,//出发时间
            "return_Time": returnTime,//到达时间
            "share_House": shareHouse,//是否拼房 0 代表不拼 1代表拼  int
            "people_Num": peopleNum,//约伴人数int
            "required": require,//约伴要求
            "description": tripTextView.text,//行程描述
            "fid": UserDefaults.standard.value(forKey: "uid"),//对应用户id  int
            "budget": budget,//预算
            "costs": costs,//消费方式
            
            ] as [String : Any]
    
    }
    
    
    @IBAction func completeActivity(_ sender: UIButton) {
        
        setParameters()
        uploadPic(uploadImages: imageArray , parameters: parameters, uploadImageName: imageName)
        
        
    }
    
    
    
    //选取相册
    @IBAction func fromAlbum(_ sender: AnyObject) {
        
        _ = self.zz_presentPhotoVC(3) { (assets) in
            
            self.imageAssets = assets
            
            for i in 0..<assets.count {
                
                
                let myAsset = assets[i]
                var photoName: String!
                //获取文件名
                PHImageManager.default().requestImageData(for: myAsset, options: nil,resultHandler: {
                    _, _, _, info in
                    photoName = (info!["PHImageFileURLKey"] as! NSURL).lastPathComponent

                    let photoText = "assets[\(i)]:\n"
                        + "名称: \(photoName!)\n"
                        + "日期：\(myAsset.creationDate!)\n"
                        + "类型：\(myAsset.mediaType.rawValue)\n"
                        + "位置：\(myAsset.location)\n"
                        + "时长：\(myAsset.duration)\n"
                    
                    self.imageName.append(photoName!)
                    print(photoText)
                })
                
                //获取原图
                PHImageManager.default().requestImage(for: myAsset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: nil, resultHandler: { (image, _: [AnyHashable : Any]?) in
                    self.addImages(image: image!)
                })

            }
            
        }
        
    }
    
    func uploadPic (uploadImages: [UIImage], parameters: [String: Any], uploadImageName: [String]) {
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in

                
                //遍历上传图片
                for i in 0 ..< (uploadImages.count) {

                    let image = uploadImages[i]
                    
                    let file1Data = UIImageJPEGRepresentation(image, 1) //此时scale参数为0.3
                    let fileName = uploadImageName[i]
                    print(file1Data)
                    
                    multipartFormData.append(file1Data!, withName: "file", fileName: fileName, mimeType: fileName)

                    
                    
                }
                //遍历上传参数
                for (key, value) in parameters {
                    
                    multipartFormData.append( String(describing: value).data(using: String.Encoding.utf8)!, withName: key)
                    
                }

            },
            to: "http://192.168.88.23:8080/Trip5.0/activity/CreateActivity",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in

                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        )
        
    }
    
    func textView(_ shouldChangeTextIntextView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            tripTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func initTextView (textView: UITextView) {
        textView.layer.borderColor = UIColor.lightGray.cgColor
        
        textView.layer.borderWidth = 1;
        
        initialText = textView.text
        
        textView.delegate = self
        
    }
    
    
    
    func textViewDidBeginEditing (_ textView: UITextView ){
        
        if (textView.text == initialText) {
            
            textView.text = ""
            
        }
        textView.textColor = UIColor.black
        
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        
        if (textView.text == "") {
            
            textView.text = initialText
            textView.textColor = UIColor.lightGray
            
        }
        
    }
    
    
    func addImages (image: UIImage) {

        let btnX = self.chooseImgBtn.frame.minX
        let btny = self.chooseImgBtn.frame.minY
    
    
        
        let imageView = UIImageView(frame: CGRect(x: btnX, y:  btny + addingImageView.frame.minY + topView.frame.height + 4, width: self.chooseImgBtn.bounds.width, height: self.chooseImgBtn.bounds.height))
        
        imageView.image = image
        
        self.imageArray.append(image)
        print("images.count = \(self.imageArray.count)")
        
        view.addSubview(imageView)
        
        let imageX = btnX
        let imageY = btny + addingImageView.frame.minY + topView.frame.height + 4
        
        var deleteBtn = UIButton()
        
        deleteBtn = UIButton(frame: CGRect(x: imageX + imageView.frame.width - imageView.frame.width / 5, y: imageY, width: imageView.frame.width / 5, height: imageView.frame.height / 5))

        deleteBtn.setImage(UIImage(named: "ImageDeleteBtn"), for: .normal)

        
        view.addSubview(deleteBtn)
        
        let x = imageView.frame.maxX
        let y = self.chooseImgBtn.frame.minY
        
        
        if imageArray.count == 9{
            chooseImgBtn.isEnabled = false
            chooseImgBtn.isHidden = true
        } else {
            if imageArray.count % 3 == 0 {
                self.chooseImgBtn.frame = CGRect(x: view.frame.minX + 8, y: y+self.chooseImgBtn.frame.height + 8, width: self.chooseImgBtn.bounds.width, height: self.chooseImgBtn.bounds.height)
            } else {
                self.chooseImgBtn.frame = CGRect(x: x + 8, y: y, width: self.chooseImgBtn.bounds.width, height: self.chooseImgBtn.bounds.height)
            }
        }
    }


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTextView(textView: tripTextView)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
