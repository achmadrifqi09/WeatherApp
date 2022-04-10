//
//  ViewController.swift
//  WeatherApp
//
//  Created by Achmad Rifqi on 10/04/22.
//

import Foundation
import CoreLocation


final class LocationModel : NSObject, ObservableObject, CLLocationManagerDelegate{
    var locationManager : CLLocationManager?
    func checkIfLocationServicesIsEnable(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        }else{
            print("Location service disable")
        }
        
    }
    
   private func checkLocationAuthorization(){
        guard let locationManager = locationManager else {
            return
        }

        
        switch locationManager.authorizationStatus{
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("location restricted")
        case .denied:
            print("location denied")
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
