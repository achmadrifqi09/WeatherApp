//
//  WeatherServices.swift
//  WeatherApp
//
//  Created by Achmad Rifqi on 10/04/22.
//

import Foundation
import CoreLocation
import SwiftUI


class WeatherService : ObservableObject{
    
    private var key = "e152ee81453388d5623714e4d880f07b"
    
    @Published var temp : Double = 0.0
    @Published var tempMin : Double = 0.0
    @Published var tempMax : Double = 0.0
    @Published var feelsLike : Double = 0.0
    @Published var pressure : Int = 0
    @Published var desc : String = ""
    @Published var isLoading = true
    
    
    func getWeatherData(latitude : Int, longitude : Int){
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(key)") else{
            fatalError("Fatal Error")
        }
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            if (response.statusCode == 200) {
                guard let data = data else {
                    return
                }
                
                DispatchQueue.main.async {
                    do{
                        let dataDecode = try JSONDecoder().decode(WeatherModel.self, from: data)
                        
                        
                        for data in [dataDecode.main]{
                            self.temp = data.temp
                            self.feelsLike = data.feels_like
                            self.pressure = data.pressure
                            self.tempMax = data.temp_max
                            self.tempMin = data.temp_min
                        }
                        
                        let weather = dataDecode.weather
                        for data in weather{
                            self.desc = data.description
                        }
                        
                        self.isLoading = false
                        
                    }catch{
                        print("Error at :", error)
                    }
                }
                
            }
        }.resume()
    }
    
    
}
