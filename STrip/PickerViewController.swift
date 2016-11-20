//
//  PickerViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/10/23.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    
    var publicData: String!
    var data: [String]!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func complete(_ sender: UIButton) {
        publicData = data[pickerView.selectedRow(inComponent: 0)]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //将dataSource设置成自己
        pickerView.dataSource = self
        //将delegate设置成自己
        pickerView.delegate = self
        //设置选择框的默认值
        pickerView.selectRow(1,inComponent:0,animated:true)
    
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //设置选择框的列数为3列,继承于UIPickerViewDataSource协议
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //设置选择框的行数为9行，继承于UIPickerViewDataSource协议
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    //设置选择框各选项的内容，继承于UIPickerViewDelegate协议
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return data[row]
    }
    
    /*
    //MARK:设置列宽
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        if(0 == component){
            //第一列变宽
            return 100
        }else{
            //第二、三列变窄
            return 30
        }
    }
 */
 
    /*
    //MARK:设置行高
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
 */

    /*
    //MARK：将图片作为选择框选项
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        let image = UIImage(named:"icon_"+String(row))
        let imageView = UIImageView()
        imageView.image = image
        return imageView
    }
 */
    
    /*
    //MARK:检测响应选项的选择状态
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //将在滑动停止后触发，并打印出选中列和行索引
        print(component)
        print(row)
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
