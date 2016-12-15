//
//	DetailCommentList.swift
//
//	Create by Jep Xia on 24/11/2016
//	Copyright © 2016. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct DetailCommentList{

	var userName : String!
	var aid : Int!
	var comment : String!
	var headPortrait : String!
	var id : Int!
	var time : Int!
	var uid : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		userName = dictionary["userName"] as? String
		aid = dictionary["aid"] as? Int
		comment = dictionary["comment"] as? String
		headPortrait = dictionary["head_Portrait"] as? String
		id = dictionary["id"] as? Int
		time = dictionary["time"] as? Int
		uid = dictionary["uid"] as? Int
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if userName != nil{
			dictionary["userName"] = userName
		}
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
		return dictionary
	}

}
