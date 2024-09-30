//
//  WFCCityView.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 26/09/2024.
//

import SwiftUI

struct WFCCityView: View {
    @ObservedObject var weatherViewModel: WFCWeatherViewModel
    
    var body: some View {
        VStack {
            WFCCityNameView(city: weatherViewModel.city, date: weatherViewModel.date)
                .shadow(radius: 0)
            WFCTodayWeatherView(weatherViewModel: weatherViewModel)
                .padding()
            WFCDailyWeatherView(weatherViewModel: weatherViewModel)
                .padding(.horizontal)
        }.padding(.bottom, 30)
    }
}

struct City_Previews: PreviewProvider {
    static var previews: some View {
        WFCCityView(weatherViewModel: WFCWeatherViewModel())
    }
}
