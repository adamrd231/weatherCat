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

@MainActor
final class HomeViewModel:ObservableObject {
    
    // Data Services
    let weatherDataService = WeatherDataService()
    @Published var weatherData: WeatherModel? = nil
    
    // Current Search Text
    @Published var searchText: String = ""
    
    // Location Services
    private var locationManager = LocationManager()
    @Published var coordinates: CLLocationCoordinate2D? = nil
    
    // Purrbo
    @Published var purrbo = PurrboModel(tempPurrboWearsPants: 60, isWearingPants: true, tempature: .good)
    
    func setupWeather() async {
        let location = locationManager.location
        print("Current location is: \(location)")
        guard let coordinate = location?.coordinate else { return }
        weatherData = try? await weatherDataService.getWeather(latitude: coordinate.latitude, longitude: coordinate.longitude)
    }
    
}

