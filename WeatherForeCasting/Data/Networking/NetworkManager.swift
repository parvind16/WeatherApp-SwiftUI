//
//  NetworkManager.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 16/08/24.
//

import Foundation

final class NetworkManager<T: Codable> {
    static func fetch (for url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard response is HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let responseObject: T = try JSONDecoder().decode(T.self, from: data)
            return responseObject
        } catch  {
            debugPrint(error.localizedDescription)
            throw NetworkError.decodingError(err: error.localizedDescription)
        }
    }
}

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case decodingError(err: String)
    case error(err: String)
}
