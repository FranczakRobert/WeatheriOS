//
//  WeatherModel.swift
//  Weather
//
//  Created by Robert Franczak on 19/02/2023.
//

import Foundation


struct WeatherModel {
    
    let conditionId : Int
    let cityName    : String
    let temperature : Double
    
    var temperatureString : String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName : String {
        
        switch conditionId {

            case 200...232 :
                return "cloud.bolt"
                
            case 300...321 :
                return "cloud.rain"
                
            case 500...531 :
                return "cloud.sun.rain"
                
            case 600...622 :
                return "cloud.snow"
                
            case 701...781 :
                return "cloud.fog"
                
            case 800 :
                return "cloud.sun"
                
            case 801...804 :
                return "cloud.fill"
                
            default:
                return "cloud"
            }
    }
}
