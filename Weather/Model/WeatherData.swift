//
//  WeatherData.swift
//  Weather
//
//  Created by Robert Franczak on 02/02/2023.
//

import Foundation

struct WeatherData : Codable {
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Main : Decodable & Encodable {
    let temp : Double
}

struct Weather : Codable {
    let description : String
    let id : Int
}
