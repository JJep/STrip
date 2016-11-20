//
//  AllPhotosViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/11/13.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit
import Photos

class AllPhotosViewController: UIViewController, PHPhotoLibraryChangeObserver, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    
    //  屏幕宽高
    private var KSCREEN_HEIGHT =  UIScreen.main.bounds.size.height
    private var KSCREEN_WIDTH =  UIScreen.main.bounds.size.width
    
    //  头视图，显示标题和取消按钮
    private let headerView = UIView()
    //  默认头视图高度
    private var defaultHeight: CGFloat = 50
    
    //  底部视图，UIButton，点击完成
    private let completedButton = UIButton()
    //  已选择图片数量
    private let countLable = UILabel()
    
    //  载体
    private var myCollectionView: UICollectionView!
    //  collectionView 布局
    private let flowLayout = UICollectionViewFlowLayout()
    //  collectionviewcell 复用标识
    private let cellIdentifier = "myCell"
    //  数据源
    private var photosArray: PHFetchResult<AnyObject>!
    //  已选图片数组，数据类型是 PHAsset
    private var seletedPhotosArray = [PHAsset]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        //  添加顶部、底部视图
        addHeadViewAndBottomView()
        
        //  添加顶部、底部视图
        addHeadViewAndBottomView()
        
        //  获取全部图片
        getAllPhotos()
    }
    
    //  MARK:- 添加headerView-标题、取消 , 添加底部视图，包括完成按钮和选择数量
    private func addHeadViewAndBottomView() {
        //  headerView
        headerView.frame = CGRect(x: 0, y: 0, width: KSCREEN_WIDTH, height: defaultHeight)
        headerView.backgroundColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.6)
        view.addSubview(headerView)
        
        //  添加返回按钮
        let backButton = UIButton()
        backButton.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        backButton.setTitle("取消", for: .normal)
        backButton.setTitleColor(UIColor.white, for: .normal)
        
        backButton.center = CGPoint(x: KSCREEN_WIDTH - 40, y: defaultHeight / 1.5)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        //  注意这里给按钮添加点击方法的写法
        backButton.addTarget(self, action:#selector(AllPhotosViewController.dismissAction),
                             for: .touchUpInside)
        headerView.addSubview(backButton)
        
        //  标题
        let titleLable = UILabel(frame: CGRect(x: 0, y: 0, width: KSCREEN_WIDTH / 2, height: defaultHeight))
        titleLable.text = "全部图片"
        
        titleLable.textColor = UIColor.white
        titleLable.font = UIFont.systemFont(ofSize: 19)
        titleLable.textAlignment = .center
        titleLable.center = CGPoint(x: KSCREEN_WIDTH / 2, y: defaultHeight / 1.5)
        
        headerView.addSubview(titleLable)
        
        //  底部View，点击选择完成
        completedButton.frame = CGRect(x: 0, y: KSCREEN_HEIGHT,width: KSCREEN_WIDTH,height: 44)
        completedButton.backgroundColor = UIColor.init(white: 0.8, alpha: 1)
        view .addSubview(completedButton)
        
        //  完成按钮
        let overLabel = UILabel(frame: CGRect(x: KSCREEN_WIDTH / 2 + 10,y: 0,width: 40,height: 44))
        overLabel.text = "完成"
        overLabel.textColor = UIColor.green
        overLabel.font = UIFont.systemFont(ofSize: 18)
        completedButton .addSubview(overLabel)
        
        //  已选择图片数量
        countLable.frame = CGRect(x:KSCREEN_WIDTH / 2 - 25,y: 10,width: 24,height: 24)
        countLable.backgroundColor = UIColor.green
        countLable.textColor = UIColor.white
        countLable.layer.masksToBounds = true
        countLable.layer.cornerRadius = countLable.bounds.size.height / 2
        countLable.textAlignment = .center
        countLable.font = UIFont.systemFont(ofSize: 16)
        completedButton .addSubview(countLable)
    }
    
    //  取消选择，返回上一页
    func dismissAction() {
        self .dismiss(animated: true, completion: nil)

    }
    
    
    //  MARK:- 获取全部图片
    private func getAllPhotos() {
        //  注意点！！-这里必须注册通知，不然第一次运行程序时获取不到图片，以后运行会正常显示。体验方式：每次运行项目时修改一下 Bundle Identifier，就可以看到效果。
        PHPhotoLibrary.shared().register(self)
        //  获取所有系统图片信息集合体
        let allOptions = PHFetchOptions()
        //  对内部元素排序，按照时间由远到近排序
        allOptions.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: true)]
        //  将元素集合拆解开，此时 allResults 内部是一个个的PHAsset单元
        let allResults = PHAsset.fetchAssets(with: allOptions)
        print(allResults.count)
    }
    //  PHPhotoLibraryChangeObserver  第一次获取相册信息，这个方法只会进入一次
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        getAllPhotos()
    }
    
    //  MARK:- 创建 CollectionView 并实现协议方法 delegate / dataSource
    private func createCollectionView() {
        // 竖屏时每行显示4张图片
        let shape: CGFloat = 5
        let cellWidth: CGFloat = (KSCREEN_WIDTH - 5 * shape) / 4
        flowLayout.sectionInset = UIEdgeInsetsMake(0, shape, 0, shape)
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        flowLayout.minimumLineSpacing = shape
        flowLayout.minimumInteritemSpacing = shape
        //  collectionView
        myCollectionView = UICollectionView(frame: CGRect(x: 0,y: defaultHeight,width: KSCREEN_WIDTH,height: KSCREEN_HEIGHT - defaultHeight), collectionViewLayout: flowLayout)
        myCollectionView.backgroundColor = UIColor.white
        //  添加协议方法
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        //  设置 cell
        myCollectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        view.addSubview(myCollectionView)
    }
    
    //  collectionView delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return photosArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MyCollectionViewCell
        //  展示图片
        PHCachingImageManager.default().requestImage(for: photosArray[indexPath.row] as! PHAsset , targetSize: CGSize.zero, contentMode: .aspectFit, options: nil) { (result: UIImage?, dictionry: Dictionary?) in
            cell.imageView.image = result ?? UIImage.init(named: "iw_none")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentCell = collectionView.cellForItem(at: indexPath as IndexPath) as! MyCollectionViewCell
        currentCell.isChoose = !currentCell.isChoose
        seletedPhotosArray.append(photosArray[indexPath.row] as! PHAsset)
        completedButton
    }
    //  MARK:- 展示和点击完成按钮
    func completedButtonShow() {
        var originY: CGFloat
        
        if seletedPhotosArray.count > 0 {
            originY = KSCREEN_HEIGHT - 44
            flowLayout.sectionInset.bottom = 44
        } else {
            originY = KSCREEN_HEIGHT
            flowLayout.sectionInset.bottom = 0
        }
        
        UIView.animate(withDuration: 0.2) {
            self.completedButton.frame.origin.y = originY
            self.countLable.text = String(self.seletedPhotosArray.count)
            
            //  仿射变换
            UIView.animate(withDuration: 0.2, animations: {
                self.countLable.transform = CGAffineTransform(scaleX: 0.35, y: 0.35)
                self.countLable.transform = self.countLable.transform.scaledBy(x: 3, y: 3)
            })
        }
    }
    

}

//  MARK:- CollectionViewCell
class MyCollectionViewCell: UICollectionViewCell {
    
    let selectButton = UIButton()
    let imageView = UIImageView()
    //  cell 是否被选择
    var isChoose = false {
        didSet {
            selectButton.isSelected = isChoose
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //  展示图片
        imageView.frame = contentView.bounds
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
        imageView.backgroundColor = UIColor.cyan
        
        //  展示图片选择图标
        selectButton.frame = CGRect(x: contentView.bounds.size.width * 3 / 4 - 2,y: 2,width: contentView.bounds.size.width / 4 ,height: contentView.bounds.size.width / 4)
        selectButton.setBackgroundImage(UIImage.init(named: "iw_unselected"), for: .normal)
        selectButton.setBackgroundImage(UIImage.init(named: "iw_selected"), for: .selected)
        imageView.addSubview(selectButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
