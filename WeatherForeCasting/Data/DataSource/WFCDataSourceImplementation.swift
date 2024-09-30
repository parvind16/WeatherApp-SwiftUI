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
        return WFCWeatherResponse.dummyData()
    }
    
//    private func getWeatherInternal(city: String, for urlString: String) async throws -> WFCWeatherResponse {
//        do {
//            NetworkManager<WFCWeatherResponse>.fetch(for: URL(string: urlString)!) { (result) in
//                switch result {
//                case .success(_): break
//                case .failure(let err):
//                    print(err)
//                }
//            }
//        } catch {
//          
//        }
//    }
}
