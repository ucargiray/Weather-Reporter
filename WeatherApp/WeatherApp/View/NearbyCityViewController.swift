//
//  NearCityViewController.swift
//  AppCent-WeatherApp
//
//  Created by Giray Uçar on 11.05.2021.
//

import UIKit
import MapKit

class NearbyCityViewController: UIViewController {
    
    var weathers = [Weather]()
    var indexOfLocation = 0
    
    fileprivate var closeLocationTableView : UITableView = {
        let tb = UITableView(frame: .zero)
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "nearCityCell")
        return tb
    }()
    var infoLabel : UILabel!
    var map : MKMapView!
    var annotations : [CityLocation]!

    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        self.navigationItem.title = "Find Others"
        closeLocationTableView.dataSource = self
        closeLocationTableView.delegate = self
        self.weathers = WeatherViewModel.locations
        self.annotations = []
        self.createTableView()
        self.createInfoLabel()
        self.createMap()
        self.navigationController?.navigationBar.barTintColor = .systemGray4
        self.navigationController?.navigationBar.tintColor = .black
        
    }
    
    func createMap() {
        map = MKMapView(frame: .zero)
        map.mapType = .standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(map)
        
        NSLayoutConstraint.activate([
            map.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            map.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            map.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            map.bottomAnchor.constraint(equalTo: infoLabel.topAnchor, constant: -20)
        ])
        for location in weathers {
            let components = location.latt_long!.components(separatedBy: ",")
            let coordinate = CLLocationCoordinate2D(latitude: Double(components[0])!, longitude: Double(components[1])!)
            let locationAnnotation = CityLocation(title: location.title!, coordinate: coordinate, info: location.location_type!)
            self.annotations.append(locationAnnotation)
        }
        map.showsUserLocation = true
        map.addAnnotations(annotations)
    }
    
    func createTableView() {
        view.addSubview(closeLocationTableView)
        NSLayoutConstraint.activate([
            closeLocationTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            closeLocationTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            closeLocationTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            closeLocationTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        ])
        closeLocationTableView.layer.borderWidth = 0.5
        closeLocationTableView.layer.borderColor = UIColor.lightGray.cgColor
        closeLocationTableView.layer.cornerRadius = 20
        
    }
    
    func createInfoLabel() {
        infoLabel = UILabel()
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(infoLabel)
        infoLabel.text = "More info about other cities"
        infoLabel.font = UIFont.systemFont(ofSize: 18)
        infoLabel.numberOfLines = 0
        NSLayoutConstraint.activate( [
            infoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            infoLabel.bottomAnchor.constraint(equalTo: closeLocationTableView.topAnchor, constant: -15)
        ])
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailVC" {
            let detailVC = segue.destination as? WeatherDetailViewController
            detailVC?.weather = WeatherViewModel.locations[self.indexOfLocation]
        }
    }
}
extension NearbyCityViewController : MKMapViewDelegate {
    
}

extension NearbyCityViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nearCityCell", for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = weathers[indexPath.row].title!
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexOfLocation = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "goToDetailVC", sender: nil)
    }
    
    
}

extension NearbyCityViewController : WeatherViewModelDelegate {
    func requestSuccess() {
        
    }
    
    func requestFailed() {
    }
    
}
