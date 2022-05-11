//
//  WeatherDataService.swift
//  weather
//
//  Created by Adam Reed on 5/9/22.
//

import SwiftUI
import Combine

class WeatherDataService {
    @Published var weatherData: WeatherModel? = nil
    var weatherSubscription: AnyCancellable?
    
    func getWeather(searchText: String) {
        
        var urlString = "https://api.weatherapi.com/v1/current.json?key=a6255bf0451a425eb16234020220905&q=\(searchText)&aqi=no"
        guard let url = URL(string: urlString) else { return }
        
        weatherSubscription = NetworkingManager.download(url: url)
            .decode(type: WeatherModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: {[weak self] (returnedWeather) in
                
                self?.weatherData = returnedWeather
                print("Getting Weather: \(self?.weatherData?.current.tempF)")
                
            })
    }
}
