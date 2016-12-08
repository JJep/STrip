//
//  SerachHotelViewController.swift
//  STrip
//
//  Created by Jep Xia on 16/12/6.
//  Copyright © 2016年 Jep Xia. All rights reserved.
//

import UIKit

class SerachHotelViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var destinationLabel: UITextField!
    @IBOutlet weak var timeLabel: UITextField!
    @IBOutlet weak var keyWords: UITextField!
    @IBOutlet weak var priceLabel: UITextField!
    
    @IBOutlet weak var backImage: UIImageView!
    
    @IBAction func tapBack(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        destinationLabel.delegate = self
        timeLabel.delegate = self
        keyWords.delegate = self
        priceLabel.delegate = self
        // Do any additional setup after loading the view.
    }

    //MARK: textField的相关设置
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
    
    
    func setImage () {
        backImage.image = UIImage(named: "hotel")
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = backImage.bounds
        backImage.addSubview(effectView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHotel" {
            let destVC = segue.destination as! HotelViewController
            if keyWords.text != nil {
                destVC.key += keyWords.text!
            }
            if priceLabel.text != nil {
                destVC.key += priceLabel.text!
            }
        }
        
    }
    

}
