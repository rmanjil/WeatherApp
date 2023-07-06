//
//  CurrentWeatherViewModel.swift
//  Weather_App
//
//  Created by manjil on 05/07/2023.
//

import Foundation
import Combine

class CurrentWeatherViewModel: BaseViewModel {
    
    let manager: WeatherManager
    @Published var weather: WeatherData?
    
    override init() {
        manager = WeatherManager()
    }
    
    func fetch() {
        guard !LocationManager.shared.getParameter.isEmpty else {
            assertionFailure("no location")
            return
            
        }
        Task {
            var parameter = LocationManager.shared.getParameter
            parameter["units"] = "metric"
            do {
                weather = try await manager.fetchCurrentWeather(parameter: parameter)
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
