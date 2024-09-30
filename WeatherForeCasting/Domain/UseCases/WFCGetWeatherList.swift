//
//  WFCGetWeatherList.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 27/09/2024.
//

import Foundation

enum UseCaseError: Error {
    case networkError, decodingError, undefinedError
}

protocol GetWeatherListProtocol {
    func execute(urlString: String) async throws -> Result<WFCWeatherResponse, UseCaseError>
}

struct GetWeatherListUseCase: GetWeatherListProtocol {
    var repository: WFCWeatherRepository
    
    func execute(urlString: String) async throws -> Result<WFCWeatherResponse, UseCaseError> {
        let resposne = try await repository.getWeatherList(urlString: urlString)
        return .success(resposne)
    }
}
