//
//  WFCForecastday.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 27/09/2024.
//

import Foundation

// MARK: - Forecast
struct WFCForecast: Codable {
    let forecastday: [WFCForecastday]
}

// MARK: - Forecastday
struct WFCForecastday: Codable, Identifiable {
    var date: String
    var dateEpoch: Int
    var day: WFCDay
    var astro: WFCAstro
    var hour: [WFCCurrent]

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }
    
    init() {
        date = ""
        dateEpoch = 0
        day = .init()
        astro = .init()
        hour = .init()
    }
}

// MARK: - Astro
struct WFCAstro: Codable {
    var sunrise, sunset, moonrise, moonset: String
    var moonPhase: String
    var moonIllumination, isMoonUp, isSunUp: Int

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
        case isMoonUp = "is_moon_up"
        case isSunUp = "is_sun_up"
    }
    
    init() {
        sunrise = ""
        sunset = ""
        moonrise = ""
        moonset = ""
        moonPhase = ""
        moonIllumination = 0
        isMoonUp = 0
        isSunUp = 0
    }
}

// MARK: - Day
struct WFCDay: Codable {
    var maxtempC, maxtempF, mintempC, mintempF: Double
    var avgtempC, avgtempF, maxwindMph, maxwindKph: Double
    var totalprecipMm, totalprecipIn: Double
    var totalsnowCM, avgvisKM, avgvisMiles, avghumidity: Double?
    var dailyWillItRain, dailyChanceOfRain, dailyWillItSnow, dailyChanceOfSnow: Int
    var condition: Condition
    var uv: Int

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case maxwindMph = "maxwind_mph"
        case maxwindKph = "maxwind_kph"
        case totalprecipMm = "totalprecip_mm"
        case totalprecipIn = "totalprecip_in"
        case totalsnowCM = "totalsnow_cm"
        case avgvisKM = "avgvis_km"
        case avgvisMiles = "avgvis_miles"
        case avghumidity
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case condition, uv
    }
    init() {
        maxtempC = 0.0
        maxtempF = 0.0
        mintempC = 0.0
        mintempF = 0.0
        avgtempC = 0.0
        avgtempF = 0.0
        maxwindMph = 0.0
        maxwindKph = 0.0
        totalprecipMm = 0.0
        totalprecipIn = 0.0
        totalsnowCM = 0
        avgvisKM = 0
        avgvisMiles = 0
        avghumidity = 0
        dailyWillItRain = 0
        dailyChanceOfRain = 0
        dailyWillItSnow = 0
        dailyChanceOfSnow = 0
        condition = .init()
        uv = 0
    }
}

// MARK: - Location
struct WFCLocation: Codable {
    var name, region, country: String
    var lat, lon: Double
    var tzID: String
    var localtimeEpoch: Int
    var localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }
    
    init() {
        name = ""
        region = ""
        country = ""
        lat = 0.0
        lon = 0.0
        tzID = ""
        localtimeEpoch = 0
        localtime = ""
    }
}

extension WFCForecastday {
    var id: UUID {
        return UUID()
    }
}
