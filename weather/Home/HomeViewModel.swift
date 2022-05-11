//
//  HomeViewModel.swift
//  weather
//
//  Created by Adam Reed on 5/9/22.
//

import Foundation
import Combine
import CoreLocation

class HomeViewModel:ObservableObject {
    
    @Published var weatherData: WeatherModel? = nil
    
    // Current Search Text
    @Published var searchText: String = ""
    
    // Cancellable variable to store in
    private var cancellables = Set<AnyCancellable>()
    
    // Data Services
    let weatherDataService = WeatherDataService()
    
    private var locationManager = LocationManager()
    @Published var coordinates: CLLocationCoordinate2D? = nil
    
    init() {
        addSubscribers()
    }
    
    
    func addSubscribers() {
        weatherDataService.$weatherData
            .sink { weatherModel in
                self.weatherData = weatherModel
            }
            .store(in: &cancellables)
        
        locationManager.$location
            .map(locationAndWeather)
            .sink{ returnedLocation in
                // use coordinate to get current weather
                
                self.weatherDataService.getWeather(searchText: "\(returnedLocation.latitude),\(returnedLocation.longitude)")
                self.coordinates = returnedLocation
                print(self.coordinates?.latitude)
                print(self.coordinates?.longitude)
            }
            .store(in: &cancellables)
    }
    
    func locationAndWeather(location: CLLocation?) -> CLLocationCoordinate2D {
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
        return coordinate
    }
    
}
