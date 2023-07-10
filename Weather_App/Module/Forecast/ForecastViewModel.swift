//
//  ForecastViewModel.swift
//  Weather_App
//
//  Created by manjil on 10/07/2023.
//

import Foundation
import Combine

class ForecastViewModel: ObservableObject {
    @Published var weatherResponse: WeatherResponse?
    let manager: WeatherManager
    init() {
        manager = WeatherManager()
        
    }

    func fetchWeatherData() {
        guard !LocationManager.shared.getParameter.isEmpty  else {
            assertionFailure("no location")
            return
            
        }
        Task {
            do {
                let value = try await manager.fetchForecast(parameter: LocationManager.shared.getParameter)
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.weatherResponse = value
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
