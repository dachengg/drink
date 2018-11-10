//
//  drinkData.swift
//  drink
//
//  Created by PengDa Cheng on 2018/10/25.
//  Copyright © 2018年 PengDa Cheng. All rights reserved.
//

import Foundation

struct drinkInfo {
    var name : String
    var price : Int
}

enum SugerInfo: String{
    case regular = "正常"
    case half = "半糖"
    case less = "微糖"
    case free = "無糖"
}

enum IceInfo: String{
    case regular = "正常"
    case less = "少冰"
    case free = "去冰"
    case hot = "熱"
}
struct Result: Codable {
    var name:String
    var drink:String
    var price:String
    var suger:String
    var ice:String
}

