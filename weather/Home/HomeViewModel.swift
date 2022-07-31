//
//  HomeViewModel.swift
//  weather
//
//  Created by Adam Reed on 5/9/22.
//

import Foundation
import Combine
import CoreLocation
import SwiftUI

@MainActor
final class HomeViewModel:ObservableObject {
    
    // Data Services
    let weatherDataService = WeatherDataService()
    @Published var weatherData: WeatherModel? = nil
    
    // Current Search Text
    @Published var searchText: String = ""
    
    // Location Services
    private var locationManager = LocationManager()
    
    @Published var weatherDashboard: [WeatherItem] = []
    
    // Purrbo
    @Published var purrbo = PurrboModel(tempPurrboWearsPants: 60, isWearingPants: true, tempature: .good)
    
    func setupWeather() async {
        let location = locationManager.location
        guard let coordinate = location?.coordinate else { return }
        weatherData = try? await weatherDataService.getWeather(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        if let weather = weatherData {
            weatherDashboard = setupWeatherDashboardItems(model: weather)
        }
        
    }
    
    func setupWeatherDashboardItems(model: WeatherModel) -> [WeatherItem] {
        
        var returnedDashboardItems:[WeatherItem] = []
        
        let currentLocationStat = WeatherItem(title: "Current Location", description: model.location.region ?? "n/a")
        returnedDashboardItems.append(currentLocationStat)
        
        let currentTempature = WeatherItem(title: "Tempature F", description: model.current.tempF?.description ?? "n/a")
        returnedDashboardItems.append(currentTempature)
        
        let currentTempatureFeelsLike = WeatherItem(title: "Feels like F", description: model.current.feelslikeF?.description ?? "n/a")
        returnedDashboardItems.append(currentTempatureFeelsLike)
        
        let windSpeedStat = WeatherItem(title: "Wind Speed", description: model.current.windMph?.description ?? "n/a")
        returnedDashboardItems.append(windSpeedStat)
        
        let currentTempatureC = WeatherItem(title: "Tempature C", description: model.current.tempC?.description ?? "n/a")
        returnedDashboardItems.append(currentTempatureC)
        
        let currentTempatureFeelsLikeC = WeatherItem(title: "Feels like C", description: model.current.feelslikeC?.description ?? "n/a")
        returnedDashboardItems.append(currentTempatureFeelsLikeC)
        
        return returnedDashboardItems
    }
    
}

