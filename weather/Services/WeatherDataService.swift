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
    
    func getWeather(searchText: String) async throws -> WeatherModel {
        
        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=a6255bf0451a425eb16234020220905&q=cheboygan&aqi=no") else { fatalError("Error getting URL") }
        let urlRequest = URLRequest(url: url)
        let (data, reponse) = try await URLSession.shared.data(for: urlRequest)
        
        guard (reponse as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error downloading weather")}
        let decodedWeather = try JSONDecoder().decode(WeatherModel.self, from: data)
        print(":firecracker::firecracker::firecracker: Weather is \(decodedWeather)")
        return decodedWeather
    }
}
