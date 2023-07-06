//
//  CurrentWeatherController.swift
//  Weather_App
//
//  Created by manjil on 05/07/2023.
//

import UIKit

class CurrentWeatherController: BaseController {
    
    lazy var menuButton: UIBarButtonItem = {
        let menu = UIMenu(title: "", children: [
                   UIAction(title: "Option 1", handler: { _ in
                       // Handle Option 1 selection
                   }),
                   UIAction(title: "Option 2", handler: { _ in
                       // Handle Option 2 selection
                   }),
                   UIAction(title: "Option 3", handler: { _ in
                       // Handle Option 3 selection
                   })
               ])
        let button = UIBarButtonItem(image: .menu, menu: menu)
        button.tag = 1
        button.tintColor = .black
        return button
    }()
    
    private var screen: CurrentWeatherScreen  {
        baseScreen as! CurrentWeatherScreen
    }
    
    private var viewModel: CurrentWeatherViewModel  {
        baseViewModel as! CurrentWeatherViewModel
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
      
        navigationItem.rightBarButtonItem = menuButton
        
        _ = LocationManager.shared
        print("location :\(LocationManager.shared.isLocationServicesEnabled())")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self else { return }
            viewModel.fetch()
        }
    }
    
    // MARK: - override
    override func observeEvents() {
        viewModel.$weather.receive(on: RunLoop.main).sink { [weak self] value in
            guard let self, let value  else { return  }
            load(weather: value)
        }.store(in: &viewModel.bag)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        screen.tableView.isHidden = true
    }
}

// MARK: - Methods
extension CurrentWeatherController {
    private func load(weather: WeatherData) {
        screen.temperatureLabel.text = "\(weather.main.temp) °C"
        screen.descriptionLabel.text = weather.weather.first?.description
        screen.humidityLabel.text = "Humidity: \(weather.main.humidity)%"
        screen.windLabel.text = "Wind: \(weather.wind.speed) m/s"
        screen.pressureLabel.text = "Pressure: \(weather.main.pressure) hPa"
        
        if let string = weather.weather.first?.icon {
            screen.weatherIconImageView.loadImage(with: URL(string: "https://openweathermap.org/img/w/\(string).png"))
        }
        screen.tableView.reloadData()
    }
    
    @objc private func menu(_ sender: UIBarButtonItem) {
        //screen.tableView.isHidden = false
//        let menu = UIMenu(title: "", children: [
//                   UIAction(title: "Option 1", handler: { _ in
//                       // Handle Option 1 selection
//                   }),
//                   UIAction(title: "Option 2", handler: { _ in
//                       // Handle Option 2 selection
//                   }),
//                   UIAction(title: "Option 3", handler: { _ in
//                       // Handle Option 3 selection
//                   })
//               ])
//
//               let menuButton = navigationItem.rightBarButtonItem
//               menuButton?.menu = menu
              // menuButton?.showMenu()

    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CurrentWeatherController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        screen.tableView.delegate = self
        screen.tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weather?.weather.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(WeatherTableViewCell.self, for: indexPath)
        if let weather = viewModel.weather?.weather {
            let weather = weather[indexPath.row]
            cell.configure(with: weather)
        }
        
        return cell
    }
    
}