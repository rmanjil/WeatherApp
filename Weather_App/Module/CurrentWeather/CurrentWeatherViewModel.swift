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
    let cityName: String
    
    init(cityName: String) {
        self.cityName = cityName
        manager = WeatherManager()
        super.init()
    }
    
    func fetch() {
        if cityName.isEmpty {
            guard !LocationManager.shared.getParameter.isEmpty  else {
                assertionFailure("no location")
                return
                
            }
        }
        Task {
            var parameter = cityName.isEmpty ? LocationManager.shared.getParameter : ["q": cityName]
            parameter["units"] = "metric"
            do {
                weather = try await manager.fetchCurrentWeather(parameter: parameter)
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
