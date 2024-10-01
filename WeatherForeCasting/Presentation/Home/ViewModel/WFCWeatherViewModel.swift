//
//  MessageListViewModel.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 26/09/2024.
//

import SwiftUI
import CoreLocation
import CoreData

class WFCWeatherViewModel: ObservableObject {
    private var getWeatherListUseCase = GetWeatherListUseCase(repository: WFCWeatherRepositoryImplementation(dataSource: WFCDataSourceImplementation()))
    
    @Published var weather = WFCWeatherResponse.dummyData()
    @Published var favorites = [WFCFavoriteEntity] ()
    var showFavoriteIcon = true

    @Published var city: String = "Dubai" {
        didSet {
            getWeatherList()
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
    
    var date: String {
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        if let date = dateFormatter.date(from: weather.location.localtime) {
            dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
            return dateFormatter.string(from: date)
        }
        return dateFormatter.string(
            from: Date(timeIntervalSince1970: TimeInterval(weather.location.localtimeEpoch))
        )
    }
    
    var weatherIcon: String {
        return weather.current.condition.text?.rawValue ?? "Clear"
    }
    
    var temperature: String {
        return getTempFor(temp: weather.current.tempC)
    }
    
    var conditions: String {
        return weather.current.condition.text?.rawValue ?? "Clear"
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
        let urlString = WFCAPIEndpoint.getUrlFor(city: self.city)
         Task {
             let result = try await getWeatherListUseCase.execute(urlString: urlString)
             switch result {
             case .success(let result):
                 DispatchQueue.main.async {
                     self.weather = result
                 }
             case .failure(let error):
                 print(error)
             }
         }
    }
    
    func getFavoriteDetail() {
        showFavoriteIcon = false
    }
}

extension WFCWeatherViewModel {
    
    func saveData(_ completion: @escaping ActionCompletion) {
        WFCCoreDataManager.sharedInstance.performAndSave(operation: { [weak self] reqContext in
            let favorite = WFCFavoriteEntity(context: reqContext)
            if let jsonData = try? JSONEncoder().encode(self?.weather) {
                favorite.fieldData = jsonData
                favorite.cityName = self?.city
            }
            return .success(true)
        }, completion: { [weak self] result in
            guard let _ = self else {
                completion(.failure(WFCCoreDataError.generic))
                return
            }
            
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case .success:
                completion(.success(true))
            }
        })
    }
    
    func fetchFavoriteRecords() {
        let fetchRequest: NSFetchRequest<WFCFavoriteEntity> = WFCFavoriteEntity.fetchRequest()
        _ = try? WFCCoreDataManager.sharedInstance.fetch(fetchRequest, map: { fetchresults in
            self.favorites = fetchresults
            return nil
        })
    }
    
}
