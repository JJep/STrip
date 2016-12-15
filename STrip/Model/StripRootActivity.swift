//
//	StripRootActivity.swift
//
//	Create by Jep Xia on 24/11/2016
//	Copyright © 2016. All rights reserved.
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct StripRootActivity{

	var comments : [StripComment]!
	var detailActivity : StripDetailActivity!
	var status : Int!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		comments = [StripComment]()
		if let commentsArray = dictionary["comments"] as? [NSDictionary]{
			for dic in commentsArray{
				let value = StripComment(fromDictionary: dic)
				comments.append(value)
			}
		}
		if let detailActivityData = dictionary["detail_activity"] as? NSDictionary{
				detailActivity = StripDetailActivity(fromDictionary: detailActivityData)
			}
		status = dictionary["status"] as? Int
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		let dictionary = NSMutableDictionary()
		if comments != nil{
			var dictionaryElements = [NSDictionary]()
			for commentsElement in comments {
				dictionaryElements.append(commentsElement.toDictionary())
			}
			dictionary["comments"] = dictionaryElements
		}
		if detailActivity != nil{
			dictionary["detail_activity"] = detailActivity.toDictionary()
		}
		if status != nil{
			dictionary["status"] = status
		}
		return dictionary
	}

}
