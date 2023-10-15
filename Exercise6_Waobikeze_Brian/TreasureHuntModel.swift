//
//  TreasureHuntModel.swift
//  Exercise6_Waobikeze_Brian
//
//  Created by brian waobikeze on 10/14/23.
//

import Foundation

struct TeasureLocation: Codable{
    var id:Int
    var value:Int
    var type:String
    var owner:String
    var hint:String
    var cap_lat: Double
    var cap_long: Double
}
