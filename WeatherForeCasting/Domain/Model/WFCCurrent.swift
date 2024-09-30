//
//  WFCCurrent.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 27/09/2024.
//

import Foundation

// MARK: - Current
struct WFCCurrent: Codable {
    var lastUpdatedEpoch: Int?
    var lastUpdated: String?
    var tempC, tempF: Double
    var isDay: Int
    var condition: Condition
    var windMph, windKph: Double
    var windDegree: Int
    var windDir: String
    var pressureMB: Int
    var pressureIn, precipMm, precipIn: Double
    var humidity, cloud: Int
    var feelslikeC, feelslikeF, windchillC, windchillF: Double
    var heatindexC, heatindexF, dewpointC, dewpointF: Double
    var visKM, visMiles, uv: Int
    var gustMph, gustKph: Double
    var timeEpoch: Int?
    var time: String?
    var snowCM, willItRain, chanceOfRain, willItSnow: Int?
    var chanceOfSnow: Int?

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
        case timeEpoch = "time_epoch"
        case time
        case snowCM = "snow_cm"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceOfSnow = "chance_of_snow"
    }
    
    init() {
        lastUpdatedEpoch = 0
        lastUpdated = ""
        tempC = 0.0
        tempF = 0.0
        isDay = 1
        condition = .init()
        windMph = 0.0
        windKph = 0.0
        windDegree = 0
        windDir = ""
        pressureMB = 0
        pressureIn = 0.0
        precipMm = 0.0
        precipIn = 0.0
        humidity = 0
        cloud = 0
        feelslikeC = 0.0
        feelslikeF = 0.0
        windchillC = 0.0
        windchillF = 0.0
        heatindexC = 0.0
        heatindexF = 0.0
        dewpointC = 0.0
        dewpointF = 0.0
        visKM = 0
        visMiles = 0
        uv = 0
        gustMph = 0.0
        gustKph = 0.0
        timeEpoch = 0
        time = ""
        snowCM = 0 
        willItRain = 0
        chanceOfRain = 0 
        willItSnow = 0
        chanceOfSnow = 0
    }
}

// MARK: - Condition
struct Condition: Codable {
    var text: WFCText?
    var icon: WFCIcon?
    var code: Int
   
    init() {
        text = .clear
        icon = .cdnWeatherapiCOMWeather64X64Day113PNG
        code = 0
    }
}

enum WFCIcon: String, Codable {
    case cdnWeatherapiCOMWeather64X64Day113PNG = "//cdn.weatherapi.com/weather/64x64/day/113.png"
    case cdnWeatherapiCOMWeather64X64Day176PNG = "//cdn.weatherapi.com/weather/64x64/day/176.png"
    case cdnWeatherapiCOMWeather64X64Day386PNG = "//cdn.weatherapi.com/weather/64x64/day/386.png"
    case cdnWeatherapiCOMWeather64X64Night113PNG = "//cdn.weatherapi.com/weather/64x64/night/113.png"
    case cdnWeatherapiCOMWeather64X64Night116PNG = "//cdn.weatherapi.com/weather/64x64/day/116.png"
    case cdnWeatherapiCOMWeather64X64Night389PNG = "//cdn.weatherapi.com/weather/64x64/day/389.png"
    case cdnWeatherapiCOMWeather64X64Night143PNG = "//cdn.weatherapi.com/weather/64x64/day/143.png"
    case cdnWeatherapiCOMWeather64X64Night122PNG = "//cdn.weatherapi.com/weather/64x64/day/122.png"
    case cdnWeatherapiCOMWeather64X64Night119PNG =  "//cdn.weatherapi.com/weather/64x64/night/119.png"
    
}

enum WFCText: String, Codable {
    case clear = "Clear "
    case patchyLightRainInAreaWithThunder = "Patchy light rain in area with thunder"
    case patchyRainNearby = "Patchy rain nearby"
    case sunny = "Sunny"
    case cloudy = "Partly cloudy"
    case rain = "Moderate or heavy rain with thunder"
    case mist = "Mist"
    case overcast = "Overcast "
    case Cloudy = "Cloudy "
    case clear1 = "Clear"
}
