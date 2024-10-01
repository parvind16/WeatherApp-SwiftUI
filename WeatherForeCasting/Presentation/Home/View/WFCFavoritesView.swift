//
//  WFCFavoritesView.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 30/09/24.
//

import SwiftUI

struct WFCFavoritesView: View {
    @ObservedObject var weatherViewModel: WFCWeatherViewModel
    
    var body: some View {
        List {
            ForEach(weatherViewModel.favorites) { weather in
                LazyVStack {
                    NavigationLink {
                        // destination view to navigation to
                        WFCFavoriteDetailView(weatherViewModel: weatherViewModel)
                    } label: {
                        dailyCell(weather: weather)
                    }
                }
            }
        }
        .navigationBarTitle("Favorite")
        .onAppear {
            weatherViewModel.fetchFavoriteRecords()
        }
    }
    
    private func dailyCell(weather: WFCFavoriteEntity) -> some View {
        HStack {
            Text(weather.cityName?.capitalized ?? "")
                .frame(width: 50)
            Spacer()
        }
        .foregroundColor(.white)
        .padding(.horizontal, 40)
        .padding(.vertical, 15)
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

#Preview {
    WFCFavoritesView(weatherViewModel: WFCWeatherViewModel())
}
