//
//  WFCHourlyWeatherView.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 26/09/2024.
//

import SwiftUI

struct WFCHourlyWeatherView: View {
    @ObservedObject var weatherViewModel: WFCWeatherViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(weatherViewModel.weather.forecast.forecastday) { weather in
                    let icon = weatherViewModel.getWeatherIconFor(
                        icon: weather.weather.count > 0 ? weather.weather[0].icon : "sun.max.fill"
                    )
                    let hour = weatherViewModel.getTimeFor(timestamp: weather.hour.time.rawValue)
                    let temp = weatherViewModel.getTempFor(temp: weather.day.avgtempC)
                    
                    getHourlyView(hour: hour, image: icon, temp: temp)
                }
            }
        }
    }
    
    private func getHourlyView(hour: String, image: Image, temp: String) -> some View {
        VStack(spacing: 20) {
            Text(hour)
            image.foregroundColor(.yellow)
            Text("\(temp) ℃")
        }
        .foregroundColor(.white)
        .padding()
        .background(RoundedRectangle(cornerRadius: 5)
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6050806046, green: 0.8078469634, blue: 0.9820559621, alpha: 1)), Color(#colorLiteral(red: 0.4196078431, green: 0.5333333333, blue: 0.937254902, alpha: 1))]),
                                startPoint: .topLeading, endPoint: .bottomTrailing
                            )))
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
    }
}

struct HourlyWeather_Previews: PreviewProvider {
    static var previews: some View {
        WFCHourlyWeatherView(weatherViewModel: WFCWeatherViewModel())
    }
}
