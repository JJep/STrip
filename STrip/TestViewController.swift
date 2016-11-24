//
//  TestViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/11/24.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit

class TestViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: width, height: width), collectionViewLayout: layout)
        //CollectionViewCell的注册
        collectionView.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCell")
        
        self.view.addSubview(collectionView)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! ImageCollectionViewCell
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
