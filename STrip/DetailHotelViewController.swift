//
//  DetailHotelViewController.swift
//  STrip
//
//  Created by Jep Xia on 2016/12/9.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit

class DetailHotelViewController: UIViewController {

    weak var contentLayout:TGLinearLayout!
    weak var shrinkLabel:UILabel!
    weak var hiddenView:UIView!
    
    var hotelImages: [UIImage] = []
    var comments: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .lightGray
        self.view = scrollView
        
        let contentLayout = TGLinearLayout(.vert)
        contentLayout.tg_padding = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        contentLayout.tg_width.equal(.fill)
        contentLayout.tg_height.min(scrollView.tg_height, increment: 10)
        scrollView.addSubview(contentLayout)
        
        /*垂直线性布局直接添加子视图*/
        createSection2(in: contentLayout)
        
        createSection3(in: contentLayout)
        
        
    }

}

// MARK: - Layout Construction
extension DetailHotelViewController
{
    //线性布局片段1：上面编号文本，下面一个编辑框
    func createSection1(in contentLayout:TGLinearLayout)
    {
        let numTitleLabel = UILabel()
        numTitleLabel.text =  NSLocalizedString("No.:", comment:"")
        numTitleLabel.font = CFTool.font(15)
        numTitleLabel.tg_left.equal(5) //左边距为5
        numTitleLabel.sizeToFit()      //尺寸由内容决定
        contentLayout.addSubview(numTitleLabel)
        
        let numField = UITextField()
        numField.borderStyle = .roundedRect
        numField.placeholder = NSLocalizedString("Input the No. here", comment:"")
        numField.font = CFTool.font(15)
        numField.tg_top.equal(5)
        numField.tg_width.equal(.fill)
        numField.tg_height.equal(40)
        contentLayout.addSubview(numField)
    }
    
    func createSection2(in contentLayout: TGLinearLayout)
    {
        var view = UIView()
        let rootLayout = TGFrameLayout()
        view = rootLayout
        rootLayout.backgroundColor = .white
        view.tg_height.equal(200)
        view.tg_width.equal(100%)
        contentLayout.addSubview(view)
        
        let hotelImage = UIImageView()
        hotelImage.image = UIImage(named: "hotel")
        hotelImage.contentMode = UIViewContentMode.scaleToFill
        hotelImage.tg_height.equal(100%)
        hotelImage.tg_width.equal(.fill)
        rootLayout.addSubview(hotelImage)
        
        let hotelNameLabel = UILabel()
        hotelNameLabel.text = "hotelName"
        hotelNameLabel.tg_left.equal(8)
        hotelNameLabel.tg_bottom.equal(8)
        hotelNameLabel.font = CFTool.font(15)
        hotelNameLabel.textColor = .white
        hotelNameLabel.sizeToFit()
        rootLayout.addSubview(hotelNameLabel)
        
        let hotelImageNumberLabel = UILabel()
        hotelImageNumberLabel.tg_right.equal(8)
        hotelImageNumberLabel.tg_bottom.equal(8)
        hotelImageNumberLabel.text = "\(hotelImages.count) " + " 张"
        hotelImageNumberLabel.font = CFTool.font(15)
        hotelImageNumberLabel.sizeToFit()
        hotelImageNumberLabel.textColor = .white
        rootLayout.addSubview(hotelImageNumberLabel)
        
    }
    
    func createSection3(in contentLayout: TGLinearLayout)
    {
        var view = UIView()
        let rootLayout = TGFrameLayout()
        view = rootLayout
        rootLayout.backgroundColor = .white
        view.tg_height.equal(.wrap)
        view.tg_width.equal(100%)
        contentLayout.addSubview(view)

        let backButton = UIButton()
        backButton.tg_width.equal(.fill)
        backButton.tg_height.equal(.fill)
        backButton.backgroundColor = .gray
        backButton.setTitle("", for: .normal)
        rootLayout.addSubview(backButton)
        
//        let commentLayout = TGLinearLayout(.horz)
//        commentLayout.tg_padding = UIEdgeInsetsMake(8, 8, 8, 8)
//        commentLayout.tg_top.equal(0)
//        commentLayout.tg_width.equal(.fill)
//        commentLayout.tg_height.equal(.wrap)
//        rootLayout.addSubview(commentLayout)
        
        let starLabel = UILabel()
        starLabel.font = CFTool.font(20)
        starLabel.text = "4.7" + "分"
        starLabel.textColor = CFTool.color(8)
        starLabel.tg_top.equal(8)
        starLabel.tg_left.equal(8)
        starLabel.sizeToFit()
        rootLayout.addSubview(starLabel)
        
        let commentNumberLabel = UILabel()
        commentNumberLabel.text = "\(comments.count)" + "条评论"
        commentNumberLabel.font = CFTool.font(17)
        commentNumberLabel.tg_top.equal(8)
        commentNumberLabel.tg_right.equal(8)
        commentNumberLabel.sizeToFit()
        rootLayout.addSubview(commentNumberLabel)
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
