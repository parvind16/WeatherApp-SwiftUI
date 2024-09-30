//
//  WFCWeatherRepositoryImplementation.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 27/09/2024.
//

import Foundation

struct WFCWeatherRepositoryImplementation: WFCWeatherRepository {
    
    var dataSource: WFCWeatherDataSource
    
    func getWeatherList(urlString: String) async throws -> WFCWeatherResponse {
        return try await dataSource.getWeatherList(urlString: urlString)
    }
}
