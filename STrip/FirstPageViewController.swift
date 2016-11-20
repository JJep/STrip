//
//  FirstPageViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/10/12.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit

class FirstPageViewController: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var galleryScrollView: UIScrollView!
    @IBOutlet weak var galleryPageControl: UIPageControl!
    @IBOutlet weak var topView: UIView!
    
    var timer: Timer!
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = self.view.frame.width
        let offsetX = scrollView.contentOffset.x
        let index = (offsetX + width / 2) / width
        galleryPageControl.currentPage = Int(index)
    }
    
     func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeTimer()
    }
    
    
     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
    
    func addTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(FirstPageViewController.nextImage), userInfo: nil, repeats: true)
        
    }
    
    func removeTimer() {
        timer.invalidate()
    }
    
    func nextImage() {
        var pageIndex = galleryPageControl.currentPage
        if pageIndex == 4 {
            pageIndex = 0
        } else {
            pageIndex += 1
        }
        
        let offsetX = CGFloat(pageIndex) * self.view.frame.width
        galleryScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }

    
    func initScrollView () {
        
        for i in 1...5 {
            let image = UIImage(named: "gallery\(i)")!
            let x = CGFloat(i-1) * self.view.frame.width
            let imageView = UIImageView(frame: CGRect(x: x, y: 0, width: self.view.frame.width, height: galleryScrollView.bounds.height))
            imageView.image = image
            galleryScrollView.isPagingEnabled = true
            galleryScrollView.showsHorizontalScrollIndicator = false
            galleryScrollView.isScrollEnabled = true
            galleryScrollView.addSubview(imageView)
            galleryScrollView.delegate = self
        
        }
        
        galleryScrollView.contentSize = CGSize(width: self.view.frame.width * 5, height: galleryScrollView.bounds.height)
        galleryPageControl.numberOfPages = 5
        galleryPageControl.currentPageIndicatorTintColor = UIColor.black
        
        addTimer()

    }
    
    func initView () {

    }
    
    override func viewDidAppear(_ animated: Bool) {
        initScrollView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        
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
