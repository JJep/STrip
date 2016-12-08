//
//	HotelList.swift
//
//	Create by Jep Xia on 6/12/2016
//	Copyright © 2016. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct HotelList{

	var hotelName : String!
	var hotelAddr : AnyObject!
	var hotelArea : String!
	var hotelCity : Int!
	var hotelDescription : AnyObject!
	var hotelId : Int!
	var hotelImag : String!
	var hotelPrice : Int!
	var hotelScore : Float!
	var hotelTypePath : AnyObject!
	var id : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		hotelName = dictionary["hotelName"] as? String
		hotelAddr = dictionary["hotelAddr"] as? AnyObject
		hotelArea = dictionary["hotelArea"] as? String
		hotelCity = dictionary["hotelCity"] as? Int
		hotelDescription = dictionary["hotelDescription"] as? AnyObject
		hotelId = dictionary["hotelId"] as? Int
		hotelImag = dictionary["hotelImag"] as? String
		hotelPrice = dictionary["hotelPrice"] as? Int
		hotelScore = dictionary["hotelScore"] as? Float
		hotelTypePath = dictionary["hotelTypePath"] as? AnyObject
		id = dictionary["id"] as? Int
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if hotelName != nil{
			dictionary["hotelName"] = hotelName
		}
		if hotelAddr != nil{
			dictionary["hotelAddr"] = hotelAddr
		}
		if hotelArea != nil{
			dictionary["hotelArea"] = hotelArea
		}
		if hotelCity != nil{
			dictionary["hotelCity"] = hotelCity
		}
		if hotelDescription != nil{
			dictionary["hotelDescription"] = hotelDescription
		}
		if hotelId != nil{
			dictionary["hotelId"] = hotelId
		}
		if hotelImag != nil{
			dictionary["hotelImag"] = hotelImag
		}
		if hotelPrice != nil{
			dictionary["hotelPrice"] = hotelPrice
		}
		if hotelScore != nil{
			dictionary["hotelScore"] = hotelScore
		}
		if hotelTypePath != nil{
			dictionary["hotelTypePath"] = hotelTypePath
		}
		if id != nil{
			dictionary["id"] = id
		}
		return dictionary
	}

}