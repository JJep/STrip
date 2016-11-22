//
//	STripList.swift
//
//	Create by Jep Xia on 22/11/2016
//	Copyright © 2016. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct STripList{

	var birthland : AnyObject!
	var budget : Int!
	var commentsSum : Int!
	var costs : AnyObject!
	var departureTime : AnyObject!
	var description : String!
	var destination : AnyObject!
	var fid : Int!
	var headPortrait : String!
	var id : Int!
	var likePeople : Int!
	var nowpeople : Int!
	var peopleNum : Int!
	var pics : AnyObject!
	var required : AnyObject!
	var returnTime : AnyObject!
	var shareHouse : Int!
	var status : Int!
	var thumbnail : String!
	var userName : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		birthland = dictionary["birthland"] as? AnyObject
		budget = dictionary["budget"] as? Int
		commentsSum = dictionary["comments_sum"] as? Int
		costs = dictionary["costs"] as? AnyObject
		departureTime = dictionary["departure_Time"] as? AnyObject
		description = dictionary["description"] as? String
		destination = dictionary["destination"] as? AnyObject
		fid = dictionary["fid"] as? Int
		headPortrait = dictionary["head_Portrait"] as? String
		id = dictionary["id"] as? Int
		likePeople = dictionary["like_people"] as? Int
		nowpeople = dictionary["nowpeople"] as? Int
		peopleNum = dictionary["people_Num"] as? Int
		pics = dictionary["pics"] as? AnyObject
		required = dictionary["required"] as? AnyObject
		returnTime = dictionary["return_Time"] as? AnyObject
		shareHouse = dictionary["share_House"] as? Int
		status = dictionary["status"] as? Int
		thumbnail = dictionary["thumbnail"] as? String
		userName = dictionary["userName"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if birthland != nil{
			dictionary["birthland"] = birthland
		}
		if budget != nil{
			dictionary["budget"] = budget
		}
		if commentsSum != nil{
			dictionary["comments_sum"] = commentsSum
		}
		if costs != nil{
			dictionary["costs"] = costs
		}
		if departureTime != nil{
			dictionary["departure_Time"] = departureTime
		}
		if description != nil{
			dictionary["description"] = description
		}
		if destination != nil{
			dictionary["destination"] = destination
		}
		if fid != nil{
			dictionary["fid"] = fid
		}
		if headPortrait != nil{
			dictionary["head_Portrait"] = headPortrait
		}
		if id != nil{
			dictionary["id"] = id
		}
		if likePeople != nil{
			dictionary["like_people"] = likePeople
		}
		if nowpeople != nil{
			dictionary["nowpeople"] = nowpeople
		}
		if peopleNum != nil{
			dictionary["people_Num"] = peopleNum
		}
		if pics != nil{
			dictionary["pics"] = pics
		}
		if required != nil{
			dictionary["required"] = required
		}
		if returnTime != nil{
			dictionary["return_Time"] = returnTime
		}
		if shareHouse != nil{
			dictionary["share_House"] = shareHouse
		}
		if status != nil{
			dictionary["status"] = status
		}
		if thumbnail != nil{
			dictionary["thumbnail"] = thumbnail
		}
		if userName != nil{
			dictionary["userName"] = userName
		}
		return dictionary
	}

}
