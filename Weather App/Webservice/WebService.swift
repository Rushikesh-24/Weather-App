//
//  WebService.swift
//  Weather App
//
//  Created by Rushikesh Gaonkar on 09/03/24.
//

import Foundation

final class WebService {
    static func getWeather(city:String) async throws->Weather{
        let urlString = "https://api.weatherapi.com/v1/current.json?key=2484a7be8a6c48d488770855240903&q=\(city)"
        guard let url = URL(string: urlString) else {
            throw ErrorCases.invalidUrl
        }
        let (jsonData, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw ErrorCases.invalidResponse
        }
        do{
            let decoder = JSONDecoder()
            let currentweather = try decoder.decode(Weather.self, from: jsonData)
            return currentweather
        }catch (let error)
        {
            throw error
        }
    }
}


