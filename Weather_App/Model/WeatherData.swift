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
    let sys: Sys
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

struct Sys: Decodable {
    let id: Int
    let country: String
    let sunset: Int
    let type: Int
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
