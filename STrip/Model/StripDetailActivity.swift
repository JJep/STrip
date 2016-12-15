//
//	StripDetailActivity.swift
//
//	Create by Jep Xia on 24/11/2016
//	Copyright © 2016. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct StripDetailActivity{

	var birthland : String!
	var budget : Int!
	var commentsSum : Int!
	var costs : String!
	var departureTime : String!
	var descriptionField : AnyObject!
	var destination : String!
	var fid : Int!
	var headPortrait : AnyObject!
	var id : Int!
	var likePeople : Int!
	var nowpeople : Int!
	var peopleNum : Int!
	var pics : AnyObject!
	var required : AnyObject!
	var returnTime : String!
	var shareHouse : Int!
	var status : Int!
	var thumbnail : AnyObject!
	var userName : AnyObject!

	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		birthland = dictionary["birthland"] as? String
		budget = dictionary["budget"] as? Int
		commentsSum = dictionary["comments_sum"] as? Int
		costs = dictionary["costs"] as? String
		departureTime = dictionary["departure_Time"] as? String
		descriptionField = dictionary["description"] as? AnyObject
		destination = dictionary["destination"] as? String
		fid = dictionary["fid"] as? Int
		headPortrait = dictionary["head_Portrait"] as? AnyObject
		id = dictionary["id"] as? Int
		likePeople = dictionary["like_people"] as? Int
		nowpeople = dictionary["nowpeople"] as? Int
		peopleNum = dictionary["people_Num"] as? Int
		pics = dictionary["pics"] as? AnyObject
		required = dictionary["required"] as? AnyObject
		returnTime = dictionary["return_Time"] as? String
		shareHouse = dictionary["share_House"] as? Int
		status = dictionary["status"] as? Int
		thumbnail = dictionary["thumbnail"] as? AnyObject
		userName = dictionary["userName"] as? AnyObject
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
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
		if descriptionField != nil{
			dictionary["description"] = descriptionField
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

//StripDetailActivity(birthland: , budget: , commentsSum: ,costs: , departureTime: , descriptionField: , destination: , fid: , headPortrait: , id: , likePeople: , nowpeople: , nowpeople: , peopleNum: , pics: , required: , returnTime: , shareHouse: , status: , thumbnail: , userName: )

