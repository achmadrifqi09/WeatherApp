//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Achmad Rifqi on 10/04/22.
//

import CoreLocation
import MapKit
import UIKit

class LocationManager : NSObject, ObservableObject{
    private let locationManager = CLLocationManager()
    @Published var location : CLLocation? = nil
    @Published var city : String = ""
    @Published var country : String = ""
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationManager : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else{
            return
        }
        self.location = location
        fetchCityAndCountry(from: location) { city, country, error in
            guard let city = city, let country = country, error == nil else {return}
            self.city = city
            self.country = country
        }
      
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }

    

}



