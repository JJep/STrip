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
UINavigationControllerDelegate, UITextViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    var imageArray : [UIImage] = []
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
    
    var collectionView: UICollectionView!
    
    func initCollectionView () {
        
        
        let width = self.view.bounds.size.width
        
        //定义collectionView的布局类型，流布局
        let layout = UICollectionViewFlowLayout()
        
        
        //设置cell的大小
        layout.itemSize = CGSize(width: (width - 30)/3, height: (width - 30)/3)
        //滑动方向 默认方向是垂直
        layout.scrollDirection = .vertical
        //每个Item之间最小的间距
        layout.minimumInteritemSpacing = 10
        //每行之间最小的间距
        layout.minimumLineSpacing = 0
        
        let y = topView.bounds.size.height
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 340, width: width, height: width), collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        //CollectionViewCell的注册
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.view.addSubview(collectionView)

    }
    
    
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
            "fid": UserDefaults.standard.integer(forKey: "uid"),//对应用户id  int
            "budget": budget,//预算
            "costs": costs,//消费方式
            
            ] as [String : Any]
    
    }
    
    
    @IBAction func completeActivity(_ sender: UIButton) {
        
        setParameters()
        uploadData(uploadImages: imageArray , parameters: parameters, uploadImageName: imageName)
        
        
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
//                    self.addImages(image: image!)
                    self.imageArray.append(image!)
                    OperationQueue.main.addOperation {
                        self.collectionView.reloadData()
                    }
                   
                })

            }
        }
        
         self.collectionView.reloadData()
    }
    
    
    func uploadData (uploadImages: [UIImage], parameters: [String: Any], uploadImageName: [String]) {
        
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
            to: (ConstValue.address + "/Trip5.0/activity/CreateActivity"),
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

    
    // #MARK: --UICollectionViewDataSource的代理方法
    /**
     - 该方法是可选方法，默认为1
     - returns: CollectionView中section的个数
     */
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        var count = 0
        if imageArray.count == 9 {
            count = 9
        } else {
            count = imageArray.count + 1
        }
        print("cellCount= \(count)")
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! ImageCollectionViewCell
        
        let index = indexPath.row
        print("index = \(index)")
        print(imageArray.count)
        if index == imageArray.count {
            cell.image.image = UIImage(named: "addButton")
            cell.deleteBtn.isHidden = true
        } else {
            let image = imageArray[indexPath.row]
            cell.deleteBtn.isHidden = false
            cell.image.image = image
        }
        
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        if index == imageArray.count {
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
                        //                    self.addImages(image: image!)
                        self.imageArray.append(image!)
                        OperationQueue.main.addOperation {
                            self.collectionView.reloadData()
                        }
                        
                    })
                    
                }
            }
            
            self.collectionView.reloadData()

        }
    }
    
    
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    /**
//     - returns: Section中Item的个数
//     */
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return imageArray.count + 1
//    }
//    
//    /**
//     - returns: 绘制collectionView的cell
//     */
//    func collectionView(collectionView: UICollectionView, cellForItemAt indexPath: NSIndexPath) -> UICollectionViewCell {
//        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! ImageCollectionViewCell
//        
//        let index = indexPath.row
//        if index == imageArray.count {
//            cell.image.image = UIImage(named: "添加图片")
//            cell.deleteBtn.isHidden = true
//        } else {
//            let image = imageArray[indexPath.row]
//            cell.image.image = image
//        }
//
//        return cell
//    }
//    
//    /**
//     - returns: 返回headview或者footview
//     */
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headView", for: indexPath as IndexPath)
//        headView.backgroundColor = UIColor.white
//        
//        return headView
//    }
//
//    // #MARK: --UICollectionViewDelegate的代理方法
//    /**
//     Description:当点击某个Item之后的回应
//     */
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        print("(\(indexPath.section),\(indexPath.row))")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTextView(textView: tripTextView)
        initCollectionView()
        addingImageView.isHidden = true
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
