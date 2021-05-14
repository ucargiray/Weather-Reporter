//
//  WeatherViewModel.swift
//  AppCent-WeatherApp
//
//  Created by Giray Uçar on 11.05.2021.
//

import Foundation

protocol WeatherViewModelDelegate {
    func requestSuccess()
    func requestFailed()
}

class WeatherViewModel {
    var delegate : WeatherViewModelDelegate?
    static var locations = [Weather]()
    static var certainLocation : Weather2!
    
    // THIS IS THE LIMIT FOR DISTANCE (M)
    var limit = 600000
}

extension WeatherViewModel {
    
    func findNearestLocations(url : URL) {
            URLSession.shared.dataTask(with: url) { [weak self] (data,response,error) in
                if error != nil {
                    self?.delegate?.requestFailed()
                    }
                else {
                    if data != nil {
                        guard let locations = try? JSONDecoder().decode([Weather].self, from: data!) else {
                            print("Burası")
                            self?.delegate?.requestFailed()
                            return
                        }
                        for location in locations {
                            if location.distance! < self!.limit {
                                WeatherViewModel.locations.append(location)
                            }
                        }
                        self?.delegate?.requestSuccess()
                    }
                    else {
                        self?.delegate?.requestFailed()
                    }
                }
                    
            }.resume()
    }
    
    func getCertainDetails(url : URL) {
        URLSession.shared.dataTask(with: url) { [weak self] (data,response,error) in
            if error != nil {
                self?.delegate?.requestFailed()
                }
            else {
                if data != nil {
                    guard let location = try? JSONDecoder().decode(Weather2.self, from: data!) else {
                        print("Burası")
                        self?.delegate?.requestFailed()
                        return
                    }
                    
                    WeatherViewModel.certainLocation = location
                    self?.delegate?.requestSuccess()
                }
                else {
                    self?.delegate?.requestFailed()
                }
            }
                
        }.resume()
    }
}
