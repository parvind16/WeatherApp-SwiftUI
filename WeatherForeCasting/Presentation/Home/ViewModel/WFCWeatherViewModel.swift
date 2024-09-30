//
//  MessageListViewModel.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 26/09/2024.
//

import SwiftUI
import CoreLocation


class WFCWeatherViewModel: ObservableObject {
    private var getWeatherListUseCase = GetWeatherListUseCase(repository: WFCWeatherRepositoryImplementation(dataSource: WFCDataSourceImplementation()))
        
    @Published var weather = WFCWeatherResponse.dummyData()
    
    @Published var city: String = "Dubai" {
        didSet {
            getLocation()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh a"
        return formatter
    }()
    
    init() {
        getLocation()
    }
    
    var date: String {
        return dateFormatter.string(
            from: Date(timeIntervalSince1970: TimeInterval(weather.current.lastUpdated ?? "") ?? 0)
        )
    }
    
    var weatherIcon: String {
        //if let current = weather.current {
        return weather.current.condition.text.rawValue
        //}
       // return "dayClearSky"
    }
    
    var temperature: String {
        return getTempFor(temp: weather.current.tempC)
    }
    
    var conditions: String {
       return weather.current.condition.text.rawValue
    }
    
    var windSpeed: String {
        return String(format: "%0.1f", weather.current.windMph)
    }
    
    var humidity: String {
        return String(format: "%d%%", weather.current.humidity)
    }
    
    var rainChances: String {
        return String(format: "%0.1f%%", weather.current.dewpointC)
    }
    
    func getTimeFor(timestamp: Int) -> String {
        return timeFormatter.string(
            from: Date(timeIntervalSince1970: TimeInterval(timestamp))
        )
    }
    
    func getTempFor(temp: Double) -> String {
        return String(format: "%0.1f", temp)
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(
            from: Date(timeIntervalSince1970: TimeInterval(timestamp))
        )
    }
    
    private func getLocation() {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let places = placemarks, let place = places.first {
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }
    
    private func getWeather(coord: CLLocationCoordinate2D?) {
        if let coord = coord {
            let urlString = WFCAPIEndpoint.getUrlFor(city: city)
            getWeatherInternal(city: city, for: urlString)
        } else {
            let urlString = WFCAPIEndpoint.getUrlFor(city: city)
            getWeatherInternal(city: city, for: urlString)
        }
    }
    
    private func getWeatherInternal(city: String, for urlString: String) {
        NetworkManager<WFCWeatherResponse>.fetch(for: URL(string: urlString)!) { (result) in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.weather = response
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getWeatherIconFor(icon: String) -> Image {
        switch icon {
        case "01d":
            return Image(systemName: "sun.max.fill")     // Clear sky day
        case "01n":
            return Image(systemName: "moon.fill")        // Clear sky night
        case "02d":
            return Image(systemName: "cloud.sun.fill")
        case "02n":
            return Image(systemName: "cloud.moon.fill")
        case "03d":
            return Image(systemName: "cloud.fill")
        case "03n":
            return Image(systemName: "cloud.fill")
        case "04d":
            return Image(systemName: "cloud.fill")
        case "04n":
            return Image(systemName: "cloud.fill")
        case "09d":
            return Image(systemName: "cloud.drizzle.fill")
        case "09n":
            return Image(systemName: "cloud.drizzle.fill")
        case "10d":
            return Image(systemName: "cloud.heavyrain.fill")
        case "10n":
            return Image(systemName: "cloud.heavyrain.fill")
        case "11d":
            return Image(systemName: "cloud.bolt.fill")
        case "11n":
            return Image(systemName: "cloud.bolt.fill")
        case "13d":
            return Image(systemName: "cloud.snow.fill")
        case "13n":
            return Image(systemName: "cloud.snow.fill")
        case "50d":
            return Image(systemName: "cloud.fog.fill")
        case "50n":
            return Image(systemName: "cloud.fog.fill")
        default:
            return Image(systemName: "sun.max.fill")
        }
    }

    func getWeatherList() {
        Task {
            let result = try await getWeatherListUseCase.execute(urlString: "")
            switch result {
            case .success(let messages): 
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}
