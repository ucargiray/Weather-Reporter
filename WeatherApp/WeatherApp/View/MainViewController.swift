//
//  MainViewController.swift
//  AppCent-WeatherApp
//
//  Created by Giray Uçar on 11.05.2021.
//

import UIKit
import CoreLocation
import MapKit
import CoreGraphics
class MainViewController: UIViewController {
    
    var weathers = [Weather]()
    var firstWeather = Weather()
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var weatherTableView : UITableView = {
        let tb = UITableView(frame: .zero)
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.register(UITableViewCell.self, forCellReuseIdentifier: "weatherCell")
        return tb
    }()
    
    private lazy var weatherViewModel: WeatherViewModel = {
           let vm = WeatherViewModel()
           vm.delegate = self
           return vm
    }()
    
    var urlComponents = URLComponents()
    let locationManager = CLLocationManager()
    var userLocation = ""
    
    var locationLabel : UILabel!
    var infoLabel : UILabel!
    var nearLabel : UILabel!
    var showMoreDetailButton : UIButton!
    
    var indexOfLocation = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationManager()
        urlComponents.scheme = "https"
        urlComponents.host = "www.metaweather.com"
        urlComponents.path = "/api/location/search/"
        createURLRequestPart()
        self.navigationItem.title = "Home"
        self.view.alpha = 0.8
        self.activityIndicator.alpha = 1
        UIApplication.shared.windows[0].isUserInteractionEnabled = false
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        
        self.tabBarController?.tabBar.barTintColor = .systemGray4
        
        self.navigationController?.navigationBar.backgroundColor = .lightGray
        self.navigationController?.navigationBar.barTintColor = .systemGray4
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    func createURLRequestPart() {
        DispatchQueue.main.async { [weak self] in
            if self!.userLocation != "" {
                let request = URLQueryItem(name: "lattlong", value: self?.userLocation)
                self?.urlComponents.queryItems = [ request ]
                self?.weatherViewModel.findNearestLocations(url: self!.urlComponents.url!)
                self?.weathers = WeatherViewModel.locations
            }
        }
    }
    
    func configureLocationManager() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    // CREATE ALERT MESSAGE WHEN CONNECTION IS NOT SUCCESSFULL
    func createAlertMessage(title:String,message:String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let tryAgainButton = UIAlertAction(title: "Try again", style: .default, handler: { _ in
            self.weatherViewModel.findNearestLocations(url: self.urlComponents.url!)
            self.dismiss(animated: true, completion: nil)
        })
        controller.addAction(tryAgainButton)
        self.present(controller, animated: true, completion: nil)
    }
    
    func manageLayouts() {
        infoLabel = UILabel()
        locationLabel = UILabel()
        view.addSubview(infoLabel)
        view.addSubview(locationLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            infoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            locationLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            locationLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
        infoLabel.text = "Closest Location 🌍"
        infoLabel.textAlignment = .center
        locationLabel.text = self.firstWeather.title
        infoLabel.font = UIFont(name: "Helvetica", size: 30)
        locationLabel.font = UIFont(name: "Helvetica-Bold", size: 35)
        locationLabel.textAlignment = .center
        createTableView()
        createButton()
        createNearLabel()
    }
    
    func createButton() {
        showMoreDetailButton = UIButton(type: .system)
        showMoreDetailButton.setTitle("Show \(self.firstWeather.title!)", for: .normal)
        showMoreDetailButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        showMoreDetailButton.translatesAutoresizingMaskIntoConstraints = false
        showMoreDetailButton.addTarget(self, action: #selector(showDetail), for: UIControl.Event.touchUpInside)
        view.addSubview(showMoreDetailButton)
        NSLayoutConstraint.activate([
            showMoreDetailButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 50),
            showMoreDetailButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            showMoreDetailButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 30),
        ])
        showMoreDetailButton.layer.borderWidth = 2
        showMoreDetailButton.layer.cornerRadius = 25
        showMoreDetailButton.contentEdgeInsets = .init(top: CGFloat(20), left: CGFloat(0), bottom: CGFloat(20), right: CGFloat(0))
        showMoreDetailButton.backgroundColor = .systemGray2
        showMoreDetailButton.layer.borderColor = UIColor.systemGray.cgColor
        showMoreDetailButton.setTitleColor(.white, for: .normal)
        showMoreDetailButton.layer.shadowColor = UIColor.black.cgColor
        showMoreDetailButton.layer.shadowRadius = 10
        showMoreDetailButton.layer.shadowOffset = .zero
        showMoreDetailButton.layer.shadowOpacity = 1
        
    }
    
    func createNearLabel() {
        self.nearLabel = UILabel()
        nearLabel.translatesAutoresizingMaskIntoConstraints = false
        nearLabel.text = "Nearby Locations"
        self.view.addSubview(nearLabel)
        NSLayoutConstraint.activate([
            nearLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nearLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nearLabel.bottomAnchor.constraint(equalTo: weatherTableView.topAnchor, constant: -7),
        ])
    }
    
    @objc func showDetail() {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let detailVC = segue.destination as? WeatherDetailViewController
            detailVC?.weather = self.firstWeather
        }
    }
    
    func createTableView() {
        view.addSubview(weatherTableView)
        
        NSLayoutConstraint.activate([
            weatherTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            weatherTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            weatherTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            weatherTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)
        ])
        weatherTableView.layer.borderWidth = 0.5
        weatherTableView.layer.borderColor = UIColor.lightGray.cgColor
        weatherTableView.layer.cornerRadius = 20
    }
}

extension MainViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.userLocation = "\(locValue.latitude),\(locValue.longitude)"
        // THIS IS FOR SAVING USER'S PHONE CHARGE
        self.locationManager.stopUpdatingLocation()
        
    }
    
}

extension MainViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weathers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath)
        cell.textLabel?.text = weathers[indexPath.row].title
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.indexOfLocation = indexPath.row
    }
     
}
extension MainViewController : WeatherViewModelDelegate {
    func requestSuccess() {
        DispatchQueue.main.async {
            self.weathers = WeatherViewModel.locations
            self.firstWeather = self.weathers[0]
            self.weathers.remove(at: 0)
            self.activityIndicator.stopAnimating()
            self.createGradientLayer()
            UIApplication.shared.windows[0].isUserInteractionEnabled = true
            self.view.alpha = 1
            self.weatherTableView.reloadData()
            self.manageLayouts()
        }
    }
    
    func requestFailed() {
        DispatchQueue.main.async {
            UIApplication.shared.windows[0].isUserInteractionEnabled = true
            self.createAlertMessage(title: "Error", message: "Couldn't get the data.\nServer down or no internet connection available")
            
        }
    }
    
}
