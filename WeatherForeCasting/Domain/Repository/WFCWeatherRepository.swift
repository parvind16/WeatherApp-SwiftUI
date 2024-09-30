//
//  WFCWeatherRepository.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 27/09/2024.
//

import Foundation

protocol WFCWeatherRepository {
    func getWeatherList(urlString: String)  async throws -> WFCWeatherResponse
}
