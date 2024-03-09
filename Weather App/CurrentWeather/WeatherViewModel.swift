//
//  WeatherViewModel.swift
//  Weather App
//
//  Created by Rushikesh Gaonkar on 09/03/24.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    
    @Published var weather:Weather?
    
    func getWeather(city:String) async {
        do{
            let weather = try await WebService.getWeather(city:city)
            self.weather = weather
//            print(weather)
        } catch (let error){
            print(error.localizedDescription)
        }
    }
}
