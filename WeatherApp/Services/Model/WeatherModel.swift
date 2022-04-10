//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Achmad Rifqi on 10/04/22.
//

import Foundation


struct WeatherModel : Codable{
    var main :  MainWeather
    var weather : [Weather]
}

struct Weather : Codable, Identifiable{
    var id : Int
    var main : String
    var description :  String
}


struct MainWeather : Codable, Identifiable{
    var temp : Double
    var feels_like : Double
    var temp_min : Double
    var temp_max : Double
    var pressure : Int
    var humidity : Int
    var id : Int{0}
}
