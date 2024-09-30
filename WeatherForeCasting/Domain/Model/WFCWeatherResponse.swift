//
//  WFCWeatherResponse.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 27/09/2024.
//

import Foundation

struct WFCWeatherResponse: Codable {
    let location: WFCLocation
    let current: WFCCurrent
    let forecast: WFCForecast
    
    static func dummyData() -> WFCWeatherResponse {
        let current = WFCCurrent(lastUpdatedEpoch: 0, lastUpdated: "", tempC: 0.0, tempF: 0.0, isDay: 0, condition: Condition(text: Text(rawValue: "") ?? .sunny, icon: Icon(rawValue: "") ?? .cdnWeatherapiCOMWeather64X64Night113PNG, code: 0), windMph: 0.0, windKph: 0.0, windDegree: 1, windDir: "", pressureMB: 0, pressureIn: 0.0, precipMm: 0.0, precipIn: 0.0, humidity: 1, cloud: 1, feelslikeC: 0.0, feelslikeF: 0.0, windchillC: 0.0, windchillF: 0.0, heatindexC: 0.0, heatindexF: 0.0, dewpointC: 0.0, dewpointF: 0.0, visKM: 1, visMiles: 1, uv: 1, gustMph: 0.0, gustKph: 0.0, timeEpoch: 1, time: "", snowCM: 0, willItRain: 0, chanceOfRain: 0, willItSnow: 0, chanceOfSnow: 0)
        
        let forecastday = WFCForecastday(date: "", dateEpoch: 0, day: WFCDay(maxtempC: 0, maxtempF: 0, mintempC: 0, mintempF: 0, avgtempC: 0, avgtempF: 0, maxwindMph: 0, maxwindKph: 0, totalprecipMm: 0, totalprecipIn: 0, totalsnowCM: 0, avgvisKM: 0, avgvisMiles: 0, avghumidity: 0, dailyWillItRain: 0, dailyChanceOfRain: 0, dailyWillItSnow: 0, dailyChanceOfSnow: 0, condition: Condition(text: Text(rawValue: "") ?? .sunny, icon: Icon(rawValue: "") ?? .cdnWeatherapiCOMWeather64X64Night113PNG , code: 0), uv: 0), astro: WFCAstro(sunrise: "", sunset: "", moonrise: "", moonset: "", moonPhase: "", moonIllumination: 0, isMoonUp: 0, isSunUp: 0), hour: [current])
        
        return  WFCWeatherResponse(location: WFCLocation(name: "", region: "", country: "", lat: 0, lon: 0, tzID: "", localtimeEpoch: 0, localtime: ""),
                                  current: current,
                                  forecast: WFCForecast(forecastday: [forecastday]))
    }
}
