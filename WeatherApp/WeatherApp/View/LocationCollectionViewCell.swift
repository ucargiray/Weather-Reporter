//
//  LocationCollectionViewCell.swift
//  AppCent-WeatherApp
//
//  Created by Giray Uçar on 12.05.2021.
//

import UIKit

class LocationCollectionViewCell: UICollectionViewCell {
    
    var nsCache = NSCache<NSString, UIImage>()
    var newArray = Array<String>()
    var selectedDay = 0
    
    fileprivate var bg : UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    var data : ConsolidatedWeather? {
        didSet {
            guard let data = data else { return }
            let url = URL(string: "https://www.metaweather.com/static/img/weather/ico/\(data.weatherStateAbbr).ico")
            bg.loadImageUsingCacheWithUrlString(urlString: String(describing:url!))
            var newDate = format(date: data.applicableDate)
            print(newDate)
            title.text = newDate
        }
    }
    
    fileprivate var title : UILabel = {
       let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        return title
    }()
    
    override init(frame : CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bg)
        contentView.addSubview(title)
        bg.translatesAutoresizingMaskIntoConstraints = false
        bg.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10).isActive = true
        bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10).isActive = true
        bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10).isActive = true
        bg.bottomAnchor.constraint(equalTo: title.topAnchor,constant: -15).isActive = true
        
        
        title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.cornerRadius = 15
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
