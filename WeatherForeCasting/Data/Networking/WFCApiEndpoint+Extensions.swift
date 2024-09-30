//
//  WFCApiEndpoint.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 27/09/24.
//

import Foundation

extension WFCAPIEndpoint {
    static let baseUrl = "https://api.weatherapi.com/v1/"
    
    static func getUrlFor(city: String) -> String {
        return "\(baseUrl)forecast.json?q=\(city)&days=5,key=\(key)"
    }
}
