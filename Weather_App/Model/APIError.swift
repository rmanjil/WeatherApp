//
//  APIError.swift
//  Weather_App
//
//  Created by manjil on 06/07/2023.
//

import Foundation

struct APIError: Decodable {
    let cod: Int
    let message: String
}
