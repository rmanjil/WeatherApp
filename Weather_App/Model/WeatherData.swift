//
//  WeatherData.swift
//  Weather_App
//
//  Created by manjil on 06/07/2023.
//

import Foundation

struct WeatherData: Decodable {
    let base: String
    let id: Int
    let dt: Int
    let main: Main
    let coord: Coord
    let wind: Wind
    let sys: SysDetail
    let weather: [Weather]
    let visibility: Int
    let clouds: Clouds
    let timezone: Int
    let cod: Int
    let name: String
}

struct Main: Decodable {
    let temp_max: Double
    let humidity: Int
    let feels_like: Double
    let temp_min: Double
    let temp: Double
    let pressure: Int
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
}

struct Wind: Decodable {
    let speed: Double
    let deg: Int
}

struct SysDetail: Decodable {
    let id: Int?
    let country: String
    let sunset: Int
    let type: Int?
    let sunrise: Int
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let icon: String
    let description: String
}

struct Clouds: Decodable {
    let all: Int
}


struct WeatherResponse: Decodable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [WeatherDetailData]
    let city: City
}

struct WeatherDetailData: Decodable {
    let dt: Int
    let main: MainDetail
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let rain: Rain?
    let sys: Sys
    let dt_txt: String
}

struct MainDetail: Decodable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let sea_level: Int
    let grnd_level: Int
    let humidity: Int
    let temp_kf: Double
}


struct WindDetail: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double
}

struct Rain: Decodable {
    let h3: Double

    private enum CodingKeys: String, CodingKey {
        case h3 = "3h"
    }
}

struct Sys: Decodable {
    let pod: String
}

struct City: Decodable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int
}


