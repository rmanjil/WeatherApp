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
        view.backgroundColor = .magenta.withAlphaComponent(0.3)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    private(set) lazy var weatherIconBackgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.opacity = 0.3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        label.textColor = .systemBlue
        label.font = .boldSystemFont(ofSize: 35)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    private(set) lazy var humidityLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private(set) lazy var windLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
    private(set) lazy var pressureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = true
        view.backgroundColor = .lightGray.withAlphaComponent(0.3)
    // Top left and top right corners
        return view
    }()
    
    // Horizontal UIStackView
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [verticalStackView1, verticalStackView2])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // Vertical UIStackViews
    private lazy var verticalStackView1: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [minTemp, windTemp])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var verticalStackView2: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [maxTemp, humidTemp])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private(set) lazy var minTemp: TemperatureView = {
        let view = TemperatureView()
        view.regularLabel.text = "Min Temp"
        view.icon.image = UIImage(systemName: "thermometer.low")
        return view
    }()
    
    private(set) lazy var maxTemp: TemperatureView = {
        let view = TemperatureView()
        view.regularLabel.text = "Max Temp"
        view.icon.image = UIImage(systemName: "thermometer.high")
        return view
    }()
    
    private(set) lazy var windTemp: TemperatureView = {
        let view = TemperatureView()
        view.regularLabel.text = "wind"
        view.icon.image = UIImage(systemName: "wind")
        return view
    }()
    
    private(set) lazy var humidTemp: TemperatureView = {
        let view = TemperatureView()
        view.regularLabel.text = "Humidity"
        view.icon.image = UIImage(systemName: "humidity")
        return view
    }()
    
    override func prepareLayout() {
        super.prepareLayout()
        addSubview(main)
        // addSubview(tableView)
        main.addSubview(weatherIconBackgroundImageView)
        main.addSubview(weatherIconImageView)
        main.addSubview(temperatureLabel)
        main.addSubview(descriptionLabel)
        main.addSubview(pressureLabel)
        
        weatherIconBackgroundImageView.fillSuperView()
        
        addSubview(bottomView)
        bottomView.addSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            main.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            main.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            main.centerXAnchor.constraint(equalTo: centerXAnchor),
            main.heightAnchor.constraint(equalTo: main.widthAnchor),
            
            weatherIconImageView.centerYAnchor.constraint(equalTo: main.centerYAnchor),
            weatherIconImageView.centerXAnchor.constraint(equalTo: main.centerXAnchor),
            weatherIconImageView.widthAnchor.constraint(equalToConstant: 40),
            weatherIconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            temperatureLabel.centerXAnchor.constraint(equalTo: main.centerXAnchor),
            temperatureLabel.topAnchor.constraint(equalTo: main.topAnchor, constant: 16),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: main.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 8),
            
//            humidityLabel.leadingAnchor.constraint(equalTo: main.leadingAnchor, constant: 16),
//            humidityLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
//
//            windLabel.leadingAnchor.constraint(equalTo: main.leadingAnchor, constant: 16),
//            windLabel.topAnchor.constraint(equalTo: humidityLabel.bottomAnchor, constant: 8),
//
            pressureLabel.leadingAnchor.constraint(equalTo: main.leadingAnchor, constant: 16),
            pressureLabel.centerXAnchor.constraint(equalTo: main.centerXAnchor),
            pressureLabel.bottomAnchor.constraint(equalTo: main.bottomAnchor, constant: -16),
            
            bottomView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            horizontalStackView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 12),
            horizontalStackView.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 12),
            horizontalStackView.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: 12),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomView.safeAreaLayoutGuide.bottomAnchor, constant: 8)
            
        ])
    }
}
