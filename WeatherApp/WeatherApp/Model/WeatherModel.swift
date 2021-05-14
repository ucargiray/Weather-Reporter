//
//  WeatherModel.swift
//  AppCent-WeatherApp
//
//  Created by Giray Uçar on 11.05.2021.
//

import Foundation

struct Weather : Decodable {
    var title : String?
    var location_type : String?
    var latt_long : String?
    var distance : Int?
    var woeid : Int?
    var applicable_date : Date?
    var the_temp : Double?
    var max_temp : Double?
    var min_temp : Double?
    var predictability : Int?
}

