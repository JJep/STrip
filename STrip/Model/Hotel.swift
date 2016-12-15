//
//	Hotel.swift
//
//	Create by Jep Xia on 6/12/2016
//	Copyright © 2016. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Hotel{

	var list : [HotelList]!
	var status : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		list = [HotelList]()
		if let listArray = dictionary["list"] as? [NSDictionary]{
			for dic in listArray{
				let value = HotelList(fromDictionary: dic)
				list.append(value)
			}
		}
		status = dictionary["status"] as? Int
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if list != nil{
			var dictionaryElements = [NSDictionary]()
			for listElement in list {
				dictionaryElements.append(listElement.toDictionary())
			}
			dictionary["list"] = dictionaryElements
		}
		if status != nil{
			dictionary["status"] = status
		}
		return dictionary
	}

}
