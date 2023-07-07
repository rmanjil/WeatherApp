//
//  CurrentWeatherScreen.swift
//  Weather_App
//
//  Created by manjil on 05/07/2023.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    private lazy var weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red 
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(weatherIconImageView)
        contentView.addSubview(weatherLabel)
        contentView.backgroundColor = .white
        NSLayoutConstraint.activate([
            weatherIconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            weatherIconImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 32),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 32),
            
            weatherLabel.leadingAnchor.constraint(equalTo: weatherIconImageView.trailingAnchor, constant: 16),
            weatherLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            weatherLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with weather: Weather) {
        weatherIconImageView.loadImage(with: URL(string: "https://openweathermap.org/img/w/\(weather.icon).png"))
        weatherLabel.text = weather.description
    }
}

class CurrentWeatherScreen: BaseScreen {
    
    private(set) lazy var main: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray.withAlphaComponent(0.3)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    private(set) lazy var weatherIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: WeatherTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private(set) lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var windLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var pressureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func prepareLayout() {
        super.prepareLayout()
        addSubview(main)
       // addSubview(tableView)
        main.addSubview(weatherIconImageView)
        main.addSubview(temperatureLabel)
        main.addSubview(descriptionLabel)
        main.addSubview(humidityLabel)
        main.addSubview(windLabel)
        main.addSubview(pressureLabel)
        
        weatherIconImageView.fillSuperView()
        
        NSLayoutConstraint.activate([
            main.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            main.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            main.centerXAnchor.constraint(equalTo: centerXAnchor),
            main.heightAnchor.constraint(equalTo: main.widthAnchor),
            
            
            
            temperatureLabel.centerXAnchor.constraint(equalTo: main.centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: main.topAnchor, constant: 16),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: main.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 8),
            
            humidityLabel.leadingAnchor.constraint(equalTo: main.leadingAnchor, constant: 16),
            humidityLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            
            windLabel.leadingAnchor.constraint(equalTo: main.leadingAnchor, constant: 16),
            windLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 8),
            
            pressureLabel.leadingAnchor.constraint(equalTo: main.leadingAnchor, constant: 16),
            pressureLabel.topAnchor.constraint(equalTo: windLabel.bottomAnchor, constant: 8),
            pressureLabel.bottomAnchor.constraint(equalTo: main.bottomAnchor, constant: -16),
            
//            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            tableView.widthAnchor.constraint(equalToConstant: 200),
//            tableView.heightAnchor.constraint(equalToConstant: 150),
//
        ])
    }
}
