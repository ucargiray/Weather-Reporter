//
//  DateToString.swift
//  WeatherApp
//
//  Created by Giray Uçar on 16.05.2021.
//

import Foundation

extension LocationCollectionViewCell {
    func format(date:String) -> String {
        var fullString = ""
        let dateComponents = date.components(separatedBy: "-")
        let monthString = dateComponents[1]
        switch monthString {
        case "01" :
            fullString = "\(dateComponents[2]) Jan"
            
        case "02":
            fullString = "\(dateComponents[2]) Feb"
            
        case "03" :
            fullString = "\(dateComponents[2]) Mar"
            
        case "04":
            fullString = "\(dateComponents[2]) Apr"
            
        case "05":
            fullString = "\(dateComponents[2]) May"
            
        case "06":
            fullString = "\(dateComponents[2]) June"
            
        case "07":
            fullString = "\(dateComponents[2]) July"
         
        case "08":
            fullString = "\(dateComponents[2]) Aug"

        case "09":
            fullString = "\(dateComponents[2]) Sep"

        case "10":
            fullString = "\(dateComponents[2]) Oct"
        case "11":
            fullString = "\(dateComponents[2]) Sep"
        case "12":
            fullString = "\(dateComponents[2]) Dec"
        default :
            fullString = ""
        }
        return fullString
    }
}
