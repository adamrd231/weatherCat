//
//  PreviewProvider.swift
//  weather
//
//  Created by Adam Reed on 5/14/22.
//
import Foundation
import SwiftUI
import CoreLocation

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
    
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {
        homeViewModel.weatherData = weather
        homeViewModel.coordinates = coordinates
    }
    
    
    
    
    let homeViewModel = HomeViewModel()
    
    let coordinates = CLLocationCoordinate2D(latitude: 45.6470, longitude: 84.4745)
    
    
    let weather = WeatherModel(location:
                                Location(
                                    name: "Cheboygan",
                                    region: "Michigan",
                                    country: "United States",
                                    lat: 12,
                                    lon: 12,
                                    tzID: "",
                                    localtimeEpoch: 12,
                                    localtime: ""),
                               current:
                                Current(
                                    lastUpdatedEpoch: 1,
                                    lastUpdated: "",
                                    tempC: 21,
                                    tempF: 63,
                                    isDay: 1,
                                    condition: Condition(text: "", icon: "", code: 1),
                                    windMph: 21,
                                    windKph: 34,
                                    windDegree: 98,
                                    windDir: "",
                                    pressureMB: 1,
                                    pressureIn: 1.0,
                                    precipMm: 1.0,
                                    precipIn: 1.0,
                                    humidity: 1,
                                    cloud: 1,
                                    feelslikeC: 1.0,
                                    feelslikeF: 1.0,
                                    visKM: 1,
                                    visMiles: 1,
                                    uv: 1,
                                    gustMph: 1.0,
                                    gustKph: 1.0
                                )
    )
}
