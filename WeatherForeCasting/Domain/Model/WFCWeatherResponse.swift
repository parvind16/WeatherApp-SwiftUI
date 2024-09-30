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
        .init(location: .init(), current: .init(), forecast: .init(forecastday: [.init(), .init()]))
    }
}
