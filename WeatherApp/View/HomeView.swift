//
//  HomeView.swift
//  WeatherApp
//
//  Created by Achmad Rifqi on 09/04/22.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @ObservedObject private var locationManager = LocationManager()
    @StateObject var weatherData = WeatherService()
    var body: some View {
        ZStack{
            Color("bgColor").ignoresSafeArea()
            
            VStack{
                VStack(alignment : .leading){
                    Text("\(locationManager.city), \(locationManager.country)")
                        .bold()
                       
                    HStack{
                        Text("Today")
                        Text(Date.now, format: .dateTime.day().month().year())
                    }
                    
                    HStack{
                        VStack(spacing : 0){
                            Image("sun-clouds")
                                .resizable()
                                .frame(width : 83, height: 83)
                            Text("\(weatherData.desc)").textCase(.uppercase).font(.callout)
                        }
                        Spacer()
                        Text("\(Int(weatherData.temp - 273.15))º")
                            .font(.system(size: 64))
                        
                    }
                }
                .padding()
                Spacer()
                HStack{
                    Spacer()
                    Image("city")
                        .resizable()
                        .frame(width : 253, height: 211)
                    Spacer()
                }
                
                Spacer()
                VStack(alignment: .leading){
                    Text("Weather Now")
                        .foregroundColor(Color.white)
                        .font(.headline)
                    HStack{
                        VStack(alignment : .leading, spacing: 14){
                            HStack{
                                HStack{
                                    Image(systemName: "thermometer")
                                        .resizable()
                                        .padding(10)
                                        .foregroundColor(Color.white)
                                        .frame(width : 38, height: 45)
                                }
                                .frame(width : 50, height: 50)
                                .background(Color("accentColorIC"))
                                .clipShape(Circle())
                                VStack(alignment : .leading){
                                    Text("Min Temp")
                                        .font(.callout)
                                        .foregroundColor(Color.white)
                                    Text("\(Int(weatherData.tempMin - 273.15))")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 24))
                                    
                                }
                                
                            }
                            
                            HStack{
                                HStack{
                                    Image(systemName: "thermometer")
                                        .resizable()
                                        .padding(10)
                                        .foregroundColor(Color.white)
                                        .frame(width : 38, height: 45)
                                }
                                .frame(width : 50, height: 50)
                                .background(Color("accentColorIC"))
                                .clipShape(Circle())
                                VStack(alignment : .leading){
                                    Text("Pressure")
                                        .font(.callout)
                                        .foregroundColor(Color.white)
                                    HStack{
                                        Text("\(weatherData.pressure)")
                                            .foregroundColor(Color.white)
                                            .font(.system(size: 24))
                                        Text("hPa").foregroundColor(Color.white)
                                    }
                                    
                                }
                                
                            }
                        }
                        
                        
                        
                        Spacer()
                        
                        VStack(alignment : .leading, spacing: 14){
                            HStack{
                                HStack{
                                    Image(systemName: "thermometer")
                                        .resizable()
                                        .padding(10)
                                        .foregroundColor(Color.white)
                                        .frame(width : 38, height: 45)
                                }
                                .frame(width : 50, height: 50)
                                .background(Color("accentColorIC"))
                                .clipShape(Circle())
                                VStack(alignment : .leading){
                                    Text("Max Temp")
                                        .font(.callout)
                                        .foregroundColor(Color.white)
                                    Text("\(Int(weatherData.tempMax - 273.15))")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 24))
                                    
                                }
                                
                            }
                            
                            HStack{
                                HStack{
                                    Image(systemName: "thermometer")
                                        .resizable()
                                        .padding(10)
                                        .foregroundColor(Color.white)
                                        .frame(width : 38, height: 45)
                                }
                                .frame(width : 50, height: 50)
                                .background(Color("accentColorIC"))
                                .clipShape(Circle())
                                VStack(alignment : .leading){
                                    Text("Feels Like")
                                        .font(.callout)
                                        .foregroundColor(Color.white)
                                    Text("\(Int(weatherData.feelsLike - 273.15))")
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 24))
                                    
                                }
                                
                            }
                        }
                    }.padding()
                }
                .padding()
                .background(Color("secondBgColor"))
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline : .now() + 1.0){
                        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
                        
                        weatherData.getWeatherData(latitude: Int(coordinate.latitude), longitude: Int(coordinate.longitude))
                                            
                    }
                    
                }
            }
        }
        .redacted(reason: weatherData.isLoading ? .placeholder : [])
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
