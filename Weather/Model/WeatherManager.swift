//
//  WeatherManager.swift
//  Weather
//
//  Created by Robert Franczak on 01/02/2023.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFaild(_ error: Error)
}

struct WeatherManager {
    
    var delegate : WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a9d3b7815b0282cc976f369abea4f99b&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with URL_String: String)
    {
        // crate URL
        if let url = URL(string: URL_String) {
            
            // create session
            let session = URLSession(configuration: .default)
            
            // Give a session a task
//            let task = session.dataTask(
//                with: url,
//                completionHandler: handle(data: response: error:)
//            )
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFaild(error!)
                    return
                }
                
                if let safeData = data {
                    
                    if let weather = self.parseJSON(weatherData: safeData) {
                        
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            // Start task
            task.resume()
        }
    }
    
    func parseJSON(weatherData data: Data) -> WeatherModel? {
        
        do{
            let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
    
            let id   = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
        
            print(weather.temperatureString)
            print(weather.conditionName)
            
            return weather

        } catch {
            self.delegate?.didFaild(error)
        }
        return nil
    }
    
    
    
//    func handle(data: Data?, response: URLResponse?, error:Error?) -> Void {
//        if error != nil {
//            print(error!)
//            return
//        }
//
//        if let safeData = data {
//            let dataString = String(data: safeData, encoding: .utf8)
//
//            print(dataString!)
//        }
//    }
}
