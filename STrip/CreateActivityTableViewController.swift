//
//  CreateActivityTableViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/10/20.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit

class CreateActivityTableViewController: UITableViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var tripperRequestTextView: UITextView!
    @IBOutlet weak var departureTime: UILabel!
    @IBOutlet weak var returnTime: UILabel!
    @IBOutlet weak var costs: UILabel!
    @IBOutlet weak var peopleNum: UILabel!
    @IBOutlet weak var birthLandText: UITextField!
    @IBOutlet weak var destinationText: UITextField!
    @IBOutlet weak var shareSwtich: UISwitch!
    @IBOutlet weak var budgetText: UITextField!
    
    var initialText: String!
    var dataFlag: String!
    var peopleNumber: String = "1"

    //MARK: textField的相关设置
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textView(_ shouldChangeTextIntextView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            tripperRequestTextView.resignFirstResponder()
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
    
    //MARK: textView的相关设置
    func initTextView (textView: UITextView) {
        textView.layer.borderColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1).cgColor
        textView.layer.borderWidth = 2;
        
        initialText = textView.text
        tripperRequestTextView.delegate = self
    }
    
    func textViewDidBeginEditing (_ textView: UITextView ){
        animateViewMoving(up: true, moveValue: 100)
        if (textView.text == initialText) {
                textView.text = ""
                textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing (_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = initialText
            textView.textColor = UIColor.lightGray
        }
        animateViewMoving(up: false, moveValue: 100)
    }
    
    //MARK: datePickder的相关设置

    func initDatePicker () {
        //创建日期选择器
        let datePicker = UIDatePicker(frame: CGRect(x:0, y:0, width:320, height:216))
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = Locale(identifier: "zh_CN")
        //注意：action里面的方法名后面需要加个冒号“：”
        datePicker.addTarget(self, action: #selector(dateChanged),
                             for: .valueChanged)
        datePicker.datePickerMode = .date
        self.view.addSubview(datePicker)
    }
    
    //日期选择器响应方法
    func dateChanged(datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        print(formatter.string(from: datePicker.date))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTextView(textView: tripperRequestTextView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDepartureTimePicker" {
            dataFlag = "showDepartureTimePicker"
        }
        if segue.identifier == "showReturnTimePicker" {
            dataFlag = "showReturnTimePicker"
        }
        if segue.identifier == "toCompleteActivity" {
            if let destVC = segue.destination as? CompletionActivityTableViewController {
                
                destVC.birthLand = birthLandText.text
                destVC.destination = destinationText.text
                destVC.departureTime = departureTime.text
                destVC.returnTime = returnTime.text
                if shareSwtich.isOn {
                    destVC.shareHouse = 1
                } else {
                    destVC.shareHouse = 0
                }
                destVC.require = tripperRequestTextView.text
                if peopleNumber != "" {
                    destVC.peopleNum = Int(peopleNumber)
                } else {
                    destVC.peopleNum = 1
                }
                destVC.budget = Int(budgetText.text!)
                destVC.costs = costs.text
            }
        }
        if segue.identifier == "showCosts" {
            dataFlag = "showCosts"
            if let destVC = segue.destination as? PickerViewController {
                destVC.data = [
                    "线下AA",
                    "你请客",
                    "我买单"
                ]
            }
        }
        if segue.identifier == "showPeopleNum" {
            dataFlag = "showPeopleNum"
            if let destVC = segue.destination as? PickerViewController {
                destVC.data = [
                    "1",
                    "2",
                    "3",
                    "4",
                    "5"
                ]
            }
        }
    }
 
    
    @IBAction func complete (segue: UIStoryboardSegue) {
        switch dataFlag {
            case "showDepartureTimePicker":
                if let sourceVC = segue.source as? DatePickerViewController {
                    if let date = sourceVC.publicDate {
                            departureTime.text = date
                    }
                }
            case "showReturnTimePicker":
                if let sourceVC = segue.source as? DatePickerViewController {
                    if let date = sourceVC.publicDate {
                        returnTime.text = date
                    }
                }
            case "showCosts":
                if let sourceVC = segue.source as? PickerViewController {
                    if let data = sourceVC.publicData {
                        costs.text = data
                    }
                }
            case "showPeopleNum":
                if let sourceVC = segue.source as? PickerViewController {
                    if let data = sourceVC.publicData {
                        peopleNumber = data
                        peopleNum.text = data + "人"
                    }
            }
            default:
                break
            }
    }
    
    @IBAction func close (segue: UIStoryboardSegue) {

    }


}
