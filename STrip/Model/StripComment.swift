//
//	StripComment.swift
//
//	Create by Jep Xia on 24/11/2016
//	Copyright © 2016. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
struct StripComment{

	var aid : Int!
	var comment : AnyObject!
	var headPortrait : String!
	var id : Int!
	var time : Int!
	var uid : Int!
    var userName : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		aid = dictionary["aid"] as? Int
		comment = dictionary["comment"] as? AnyObject
		headPortrait = dictionary["head_Portrait"] as? String
		id = dictionary["id"] as? Int
		time = dictionary["time"] as? Int
		uid = dictionary["uid"] as? Int
        userName = dictionary["userName"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if aid != nil{
			dictionary["aid"] = aid
		}
		if comment != nil{
			dictionary["comment"] = comment
		}
		if headPortrait != nil{
			dictionary["head_Portrait"] = headPortrait
		}
		if id != nil{
			dictionary["id"] = id
		}
		if time != nil{
			dictionary["time"] = time
		}
		if uid != nil{
			dictionary["uid"] = uid
		}
        if userName != nil {
            dictionary["userName"] = userName
        }
		return dictionary
	}

}

//StripComment(aid: , comment: , headPortrait: , id: , time: , uid: )


