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
    
    @Published var currentTemp: Double = 0
    
    // Cancellable variable to store in
    private var cancellables = Set<AnyCancellable>()
    
    // Data Services
    let weatherDataService = WeatherDataService()
    
    // Location Services
    private var locationManager = LocationManager()
    @Published var coordinates: CLLocationCoordinate2D? = nil
    
    // Purrbo
    @Published var purrbo = PurrboModel(tempPurrboWearsPants: 60, isWearingPants: true, tempature: .good)
    
    init() {
        addSubscribers()
        print("Weather \(weatherData)")
    }
    
    func addSubscribers() {
        
        weatherDataService.$weatherData
            .sink { [self] weatherModel in
                self.weatherData = weatherModel
                print("Weather \(weatherData)")
                if let weather = weatherData?.current.tempF {
                    self.currentTemp = weather
                }
                
            }
            
            .store(in: &cancellables)
        
        locationManager.$location
            .map(locationAndWeather)
            .sink{ returnedLocation in
                // use coordinate to get current weather
                
                self.weatherDataService.getWeather(searchText: "\(returnedLocation.latitude),\(returnedLocation.longitude)")
                self.coordinates = returnedLocation
                
            }
            .store(in: &cancellables)
    }
    
    func locationAndWeather(location: CLLocation?) -> CLLocationCoordinate2D {
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
        return coordinate
    }
    
}
