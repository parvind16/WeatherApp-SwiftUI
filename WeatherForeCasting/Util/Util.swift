//
//  Util.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 30/09/24.
//

import Foundation

extension Bundle {
    func dataFromResource(_ resource: String) throws -> Data? {
        guard let mockURL = url(forResource: resource, withExtension: "json")
        else { return nil }
        let data = try Data(contentsOf: mockURL)
        return data
    }
}
