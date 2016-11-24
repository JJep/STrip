//: Playground - noun: a place where people can play

import UIKit


//时间戳
let timeStamp = 1479545828000
//转换为时间
let timeInterval:TimeInterval = TimeInterval(timeStamp)
let date = NSDate(timeIntervalSince1970: timeInterval)
print(String(describing: date))
//格式话输出
let dformatter = DateFormatter()
dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
print("对应的日期时间：\(dformatter.string(from: date as Date ))")
print(dformatter.string(from: date as Date))

let dateString = dformatter.string(from: date as Date)
print(dateString)

