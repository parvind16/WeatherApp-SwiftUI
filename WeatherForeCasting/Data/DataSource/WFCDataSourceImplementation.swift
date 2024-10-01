//
//  WFCDataSourceImplementation.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 28/09/2024.
//

import Foundation
import CoreLocation
import SwiftUI

struct WFCDataSourceImplementation: WFCWeatherDataSource {
    func getWeatherList(urlString: String) async throws -> WFCWeatherResponse {
        return try await NetworkManager<WFCWeatherResponse>.fetch(for: URL(string: urlString)!)
    }
}
