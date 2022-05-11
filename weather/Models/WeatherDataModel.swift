//
//  WeatherDataModel.swift
//  weather
//
//  Created by Adam Reed on 5/9/22.
//

import Foundation

// MARK: - Empty
struct WeatherModel: Codable {
    let location: Location
    let current: Current
}

// MARK: - Current
struct Current: Codable {
    let lastUpdatedEpoch: Int?
    let lastUpdated: String?
    let tempC: Double?
    let tempF: Double?
    let isDay: Int?
    let condition: Condition?
    let windMph: Double?
    let windKph: Double?
    let windDegree: Int?
    let windDir: String?
    let pressureMB: Int?
    let pressureIn, precipMm, precipIn: Double?
    let humidity, cloud: Int?
    let feelslikeC, feelslikeF: Double?
    let visKM, visMiles, uv: Int?
    let gustMph, gustKph: Double?
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition = "condition"
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity = "humidity"
        case cloud = "cloud"
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case uv = "uv"
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text, icon: String?
    let code: Int?
}

// MARK: - Location
struct Location: Codable {
    let name, region, country: String?
    let lat, lon: Double?
    let tzID: String?
    let localtimeEpoch: Int?
    let localtime: String?
}

