//: Playground - noun: a place where people can play

import UIKit

//定义一个协议
protocol LogManagerDelegate {
    func writeLog()
}

//用户登录类
class UserController {
    var delegate : LogManagerDelegate?
    
    func login() {
        //查看是否有委托，然后调用它
        delegate?.writeLog()
    }
}

//日志管理类
class SqliteLogManager : LogManagerDelegate {
    func writeLog() {
        print("将日志记录到sqlite数据库中")
    }
}


//使用
let userController = UserController()
userController.login()  //不做任何事

let sqliteLogManager = SqliteLogManager()
userController.delegate = sqliteLogManager
userController.login()  //输出“将日志记录到sqlite数据库中”