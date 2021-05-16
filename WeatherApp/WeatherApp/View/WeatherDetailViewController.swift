//
//  WeatherDetailViewController.swift
//  AppCent-WeatherApp
//
//  Created by Giray Uçar on 11.05.2021.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    private lazy var weatherViewModel: WeatherViewModel = {
           let vm = WeatherViewModel()
           vm.delegate = self
           return vm
    }()
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    var urlComponents = URLComponents()
    var weather : Weather?
    var weather2 : Weather2?
    var url : URL!
    var selectedDay = 0
    var myCell : LocationCollectionViewCell!
    var colors : [UIColor]!
    
    // VIEW COMPONENTS
    var view1 : UIView!
    var view2 : UIView!
    var weatherStateNameLabel , weatherStateNameValueLabel : UILabel!
    var predictabilityLabel , predictabilityValueLabel : UILabel!
    var applicableDateLabel , applicableDateValueLabel : UILabel!
    var minTempLabel , minTempValueLabel: UILabel!
    var maxTempLabel , maxTempValueLabel: UILabel!
    var theTempLabel , theTempValueLabel: UILabel!
    var windSpeedLabel , windSpeedValueLabel: UILabel!
    var airPressureLabel , airPressureValueLabel : UILabel!
    var humidityLabel , humidityValueLabel : UILabel!
    
    fileprivate let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(LocationCollectionViewCell.self,forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        self.url = URL(string: "https://www.metaweather.com/api/location/\(weather!.woeid!)")
        weatherViewModel.getCertainDetails(url: url!)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // CHANGE COLORS
        colors = [.darkGray,.black]
        self.navigationItem.title = weather?.title
        
    }

    func createDetailComponents() {
        view1 = UIView()
        view2 = UIView()
        view1.translatesAutoresizingMaskIntoConstraints = false
        view2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        NSLayoutConstraint.activate([
            view1.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor,constant: -5),
            view1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            view1.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor,constant: 5),
            view1.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            view2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            view2.topAnchor.constraint(equalTo: view1.bottomAnchor, constant: 20),
            view2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            view2.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
        ])
        view2.layer.borderWidth = 0.3
        view2.layer.borderColor = UIColor.lightGray.cgColor
        view2.layer.cornerRadius = 15
    }
    
    func createView1Components() {
        view1.addSubview(collectionView)
        collectionView.backgroundColor = .white
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view1.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view1.leadingAnchor, constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: view1.bottomAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view1.trailingAnchor, constant: -5),
        ])
        collectionView.backgroundColor = .systemGray
        collectionView.contentInset = UIEdgeInsets(top: CGFloat(10), left: CGFloat(10), bottom: CGFloat(10), right: CGFloat(10))
        collectionView.layer.cornerRadius = 20
        collectionView.layer.borderWidth = 0.5
        
    }
    
    func createView2Components() {
        weatherStateNameLabel = UILabel()
        weatherStateNameValueLabel = UILabel()
        predictabilityLabel = UILabel()
        predictabilityValueLabel = UILabel()
        applicableDateLabel = UILabel()
        applicableDateValueLabel = UILabel()
        minTempLabel = UILabel()
        minTempValueLabel = UILabel()
        maxTempLabel = UILabel()
        maxTempValueLabel = UILabel()
        theTempLabel = UILabel()
        theTempValueLabel = UILabel()
        windSpeedLabel = UILabel()
        windSpeedValueLabel = UILabel()
        airPressureLabel = UILabel()
        airPressureValueLabel = UILabel()
        humidityLabel = UILabel()
        humidityValueLabel = UILabel()
        weatherStateNameValueLabel.translatesAutoresizingMaskIntoConstraints = false
                    predictabilityValueLabel.translatesAutoresizingMaskIntoConstraints = false
        applicableDateValueLabel.translatesAutoresizingMaskIntoConstraints = false
        minTempValueLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempValueLabel.translatesAutoresizingMaskIntoConstraints = false
        theTempValueLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedValueLabel.translatesAutoresizingMaskIntoConstraints = false
        airPressureValueLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityValueLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherStateNameLabel.translatesAutoresizingMaskIntoConstraints = false
        predictabilityLabel.translatesAutoresizingMaskIntoConstraints = false
        predictabilityValueLabel.translatesAutoresizingMaskIntoConstraints = false
        applicableDateLabel.translatesAutoresizingMaskIntoConstraints = false
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        theTempLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        airPressureLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        view2.addSubview(weatherStateNameLabel)
        view2.addSubview(weatherStateNameValueLabel)
        view2.addSubview(predictabilityLabel)
        view2.addSubview(predictabilityValueLabel)
        view2.addSubview(applicableDateLabel)
        view2.addSubview(applicableDateValueLabel)
        view2.addSubview(minTempLabel)
        view2.addSubview(minTempValueLabel)
        view2.addSubview(maxTempLabel)
        view2.addSubview(maxTempValueLabel)
        view2.addSubview(theTempLabel)
        view2.addSubview(theTempValueLabel)
        view2.addSubview(windSpeedLabel)
        view2.addSubview(windSpeedValueLabel)
        view2.addSubview(airPressureLabel)
        view2.addSubview(airPressureValueLabel)
        view2.addSubview(humidityLabel)
        view2.addSubview(humidityValueLabel)
        NSLayoutConstraint.activate([
            applicableDateLabel.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 10),
            applicableDateLabel.topAnchor.constraint(equalTo: view2.topAnchor, constant: 10),
            applicableDateValueLabel.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -10),
            applicableDateValueLabel.topAnchor.constraint(equalTo: view2.topAnchor, constant: 10),
            weatherStateNameLabel.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 10),
            weatherStateNameLabel.topAnchor.constraint(equalTo: applicableDateLabel.bottomAnchor, constant: 20),
            weatherStateNameValueLabel.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -10),
            weatherStateNameValueLabel.topAnchor.constraint(equalTo: applicableDateValueLabel.bottomAnchor, constant: 20),
            minTempLabel.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 10),
            minTempLabel.topAnchor.constraint(equalTo: weatherStateNameLabel.bottomAnchor, constant: 20),
            minTempValueLabel.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -10),
            minTempValueLabel.topAnchor.constraint(equalTo: weatherStateNameValueLabel.bottomAnchor, constant: 20),
            maxTempLabel.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 10),
            maxTempLabel.topAnchor.constraint(equalTo: minTempLabel.bottomAnchor, constant: 20),
            maxTempValueLabel.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -10),
            maxTempValueLabel.topAnchor.constraint(equalTo: minTempValueLabel.bottomAnchor, constant: 20),
            theTempLabel.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 10),
            theTempLabel.topAnchor.constraint(equalTo: maxTempLabel.bottomAnchor, constant: 20),
            theTempValueLabel.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -10),
            theTempValueLabel.topAnchor.constraint(equalTo: maxTempValueLabel.bottomAnchor,constant: 20),
            humidityLabel.leadingAnchor.constraint(equalTo: view2.leadingAnchor,constant: 10),
            humidityLabel.topAnchor.constraint(equalTo: theTempLabel.bottomAnchor, constant: 20),
            humidityValueLabel.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -10),
            humidityValueLabel.topAnchor.constraint(equalTo: theTempValueLabel.bottomAnchor, constant: 20),
            airPressureLabel.leadingAnchor.constraint(equalTo: view2.leadingAnchor,constant: 10),
            airPressureLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 20),
            airPressureValueLabel.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -10),
            airPressureValueLabel.topAnchor.constraint(equalTo: humidityValueLabel.bottomAnchor, constant: 20),
            windSpeedLabel.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 10),
            windSpeedLabel.topAnchor.constraint(equalTo: airPressureLabel.bottomAnchor,constant: 20),
            windSpeedValueLabel.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -10),
            windSpeedValueLabel.topAnchor.constraint(equalTo: airPressureValueLabel.bottomAnchor, constant: 20),
            predictabilityLabel.leadingAnchor.constraint(equalTo: view2.leadingAnchor, constant: 10),
            predictabilityLabel.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor,constant:20),
            predictabilityValueLabel.trailingAnchor.constraint(equalTo: view2.trailingAnchor, constant: -10),
            predictabilityValueLabel.topAnchor.constraint(equalTo: windSpeedValueLabel.bottomAnchor, constant: 20),
        ])
        showDetails(weather: (self.weather2?.consolidatedWeather[0])!)
    }
    
    func showDetails(weather : ConsolidatedWeather) {
        let color = self.colors.randomElement()
        
        weatherStateNameLabel.text = "Weather State"
        weatherStateNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        weatherStateNameValueLabel.textColor = color
        UIView.transition(with: weatherStateNameValueLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {self.weatherStateNameValueLabel.text = weather.weatherStateName}, completion: nil)
        
        applicableDateLabel.text = "Date"
        applicableDateLabel.font = UIFont.boldSystemFont(ofSize: 17)
        applicableDateValueLabel.textColor = color
        UIView.transition(with: applicableDateValueLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {self.applicableDateValueLabel.text = weather.applicableDate}, completion: nil)
        
        minTempLabel.text = "Min Temperature"
        minTempLabel.font = UIFont.boldSystemFont(ofSize: 17)
        minTempValueLabel.textColor = color
        UIView.transition(with: minTempValueLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {self.minTempValueLabel.text = String(format:"%2.1f °C",weather.minTemp)}, completion: nil)
        
        maxTempLabel.text = "Max Temperature"
        maxTempLabel.font = UIFont.boldSystemFont(ofSize: 17)
        maxTempValueLabel.textColor = color
        UIView.transition(with: maxTempValueLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {self.maxTempValueLabel.text = String(format:"%2.1f °C",weather.maxTemp)}, completion: nil)
        
        theTempLabel.text = "Current Temperature"
        theTempLabel.font = UIFont.boldSystemFont(ofSize: 17)
        theTempValueLabel.textColor = color
        UIView.transition(with: theTempValueLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {self.theTempValueLabel.text = String(format:"%2.1f °C",weather.theTemp)}, completion: nil)
        
        humidityLabel.text = "Humidity"
        humidityLabel.font = UIFont.boldSystemFont(ofSize: 17)
        humidityValueLabel.textColor = color
        UIView.transition(with: humidityValueLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {self.humidityValueLabel.text = String("%\(weather.humidity)")}, completion: nil)
        
        airPressureLabel.text = "Air Pressure"
        airPressureLabel.font = UIFont.boldSystemFont(ofSize: 17)
        airPressureValueLabel.textColor = color
        UIView.transition(with: airPressureValueLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {self.airPressureValueLabel.text = String("\(weather.airPressure) hPa")}, completion: nil)
        
        windSpeedLabel.text = "Wind Speed"
        windSpeedLabel.font = UIFont.boldSystemFont(ofSize: 17)
        windSpeedValueLabel.textColor = color
        UIView.transition(with: windSpeedValueLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {self.windSpeedValueLabel.text = String(format:"%2.1f km",weather.windSpeed)}, completion: nil)
        
        predictabilityLabel.text = "Predictability"
        predictabilityLabel.font = UIFont.boldSystemFont(ofSize: 17)
        predictabilityValueLabel.textColor = color
        UIView.transition(with: predictabilityValueLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {self.predictabilityValueLabel.text = "%\(weather.predictability)"}, completion: nil)
    }
    
    func createAlertMessage(title:String,message:String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let tryAgainButton = UIAlertAction(title: "Try again", style: .default, handler: { _ in
            self.weatherViewModel.getCertainDetails(url: self.url)
            self.dismiss(animated: true, completion: nil)
        })
        controller.addAction(tryAgainButton)
        self.present(controller, animated: true, completion: nil)
    }
    
}

extension WeatherDetailViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? LocationCollectionViewCell
        myCell.data = WeatherViewModel.certainLocation.consolidatedWeather[indexPath.item]
        return myCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetails(weather: (weather2?.consolidatedWeather[indexPath.item])!)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.8 , height: collectionView.frame.width / 2.3)
    }
    
}
extension WeatherDetailViewController : WeatherViewModelDelegate {
    func requestSuccess() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.weather2 = WeatherViewModel.certainLocation
            self.createDetailComponents()
            self.createView1Components()
            self.createView2Components()
        }
    }
    
    func requestFailed() {
        DispatchQueue.main.async {
            self.createAlertMessage(title: "Error", message: "Couldn't get the data.\nServer down or no internet connection available")
        }
    }
    
    
}
