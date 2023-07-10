//
//  ForecastScreen.swift
//  Weather_App
//
//  Created by manjil on 10/07/2023.
//

import SwiftUI
import UIKit

struct ForecastScreen: View {
    @ObservedObject var viewModel: ForecastViewModel
    @State private var isPresented = false

    
    var body: some View {
        VStack {
            if let weatherResponse = viewModel.weatherResponse {
                Text("Weather in \(weatherResponse.city.name), \(weatherResponse.city.country)")
                    .font(.largeTitle)
                    .padding()
                
                Text("City Information")
                    .font(.title2)
                    .padding(.top)
                
                VStack(alignment: .leading) {
                    Text("City ID: \(weatherResponse.city.id)")
                    Text("Population: \(weatherResponse.city.population)")
                    Text("Timezone: \(weatherResponse.city.timezone)")
                    Text("Coordinates: \(weatherResponse.city.coord.lat), \(weatherResponse.city.coord.lon)")
                    Text("Sunrise: \(Date(timeIntervalSince1970: TimeInterval(weatherResponse.city.sunrise)))")
                    Text("Sunset: \(Date(timeIntervalSince1970: TimeInterval(weatherResponse.city.sunset)))")
                }
                .padding()
                
                Text("Weather Data")
                    .font(.title2)
                    .padding(.top)
                
                List(weatherResponse.list, id: \.dt) { weatherData in
                    VStack(alignment: .leading) {
                        Text("Date & Time: \(weatherData.dt_txt)")
                            .font(.headline)
                        Text("Temperature: \(weatherData.main.temp)°")
                        Text("Feels Like: \(weatherData.main.feels_like)°")
                        Text("Min Temp: \(weatherData.main.temp_min)°")
                        Text("Max Temp: \(weatherData.main.temp_max)°")
                        Text("Humidity: \(weatherData.main.humidity)%")
                        Text("Weather: \(weatherData.weather.first?.main ?? "") - \(weatherData.weather.first?.description ?? "")")
                    }
                    .padding()
                }
            } else {
                Text("Loading...")
            }
            Button("New Feature") {
                print("new")
                isPresented.toggle()
            }.sheet(isPresented: $isPresented) {
                ViewControllerRepresentable()
            }
        }
        .onAppear {
            viewModel.fetchWeatherData()
        }
        .navigationTitle("Today")
    }
}

struct ForecastScreen_Previews: PreviewProvider {
    static var previews: some View {
        ForecastScreen(viewModel: ForecastViewModel())
    }
}


struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = InProgressController
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ViewControllerRepresentable>) -> InProgressController {
        // Create your UIViewController here
        return InProgressController()
    }
    
    func updateUIViewController(_ uiViewController: InProgressController, context: UIViewControllerRepresentableContext<ViewControllerRepresentable>) {
        // Update your UIViewController here
    }
}
