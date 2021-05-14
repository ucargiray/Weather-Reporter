//
//  Location.swift
//  AppCent-WeatherApp
//
//  Created by Giray Uçar on 13.05.2021.
//
import MapKit
import UIKit

class CityLocation: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String

    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
