//
//  WFCWeatherDataSource.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 26/09/2024.
//

import Foundation

protocol WFCWeatherDataSource {
    func getWeatherList(urlString: String) async throws -> WFCWeatherResponse
}
