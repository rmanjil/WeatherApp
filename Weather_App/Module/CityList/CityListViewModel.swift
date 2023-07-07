//
//  CityListViewModel.swift
//  Weather_App
//
//  Created by manjil on 07/07/2023.
//

import Foundation
import Combine

struct CityModel: Codable {
    let id: Int
    let name: String
    let state: String
    let country: String
    let coord: Coordinates
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

class CityListViewModel: ObservableObject {
    
    @Published private var cityModels = [CityModel]()
    
    init() {
       extractCityModelFromJsonFile()
    }
    
    private func extractCityModelFromJsonFile() {
        guard let jsonURL = Bundle.main.url(forResource: "CityJson", withExtension: "json") else {
            print("JSON file not found.")
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            cityModels = try decoder.decode([CityModel].self, from: jsonData)
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    func filteredCityModels(searchText: String) -> [CityModel] {
        if searchText.isEmpty {
            return cityModels
        } else {
            return cityModels.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}
