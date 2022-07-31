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

struct Cloud: Hashable {
    var id = UUID()
    var xPosition: CGFloat = -300
    var yPosition: CGFloat = 0
}

class HomeViewModel:ObservableObject {
    
    @Published var weatherData: WeatherModel? = nil
    @Published var cloudyness: Int? = nil
    
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
    
    func setupWeather() async {
        weatherData = try? await weatherDataService.getWeather(searchText: "")
    }
    
    func locationAndWeather(location: CLLocation?) -> CLLocationCoordinate2D {
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
        return coordinate
    }
    
    //Clouds
    @Published var clouds = [
        Cloud(
            xPosition: CGFloat(Int.random(in: -350...350)),
            yPosition: 0),
        Cloud(
            xPosition: CGFloat(Int.random(in: -350...350)),
            yPosition: 0),
        Cloud(
            xPosition: CGFloat(Int.random(in: -350...350)),
            yPosition: 0)
    ]

    
}

