//
//  WFCCityNameView.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 26/09/2024.
//

import SwiftUI

struct WFCCityNameView: View {
    var city: String
    var date: String
    
    var body: some View {
        HStack {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
                Text(city)
                    .font(.title)
                    .bold()
                Text(date)
            }).foregroundColor(.white)
        }
    }
}

struct CityNameView_Previews: PreviewProvider {
    static var previews: some View {
        WFCCityNameView(city: "Dubai", date: "12/12/1970")
    }
}
