//
//  TemperatureView.swift
//  Weather_App
//
//  Created by manjil on 07/07/2023.
//

import UIKit

class TemperatureView: UIView {
    
    // UIImageView for the icon
    private(set) lazy var  icon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true 
        return imageView
    }()
    
    // UILabels for the regular and bold fonts
    private(set) lazy var  regularLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private(set) lazy var  boldLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "0"
        return label
    }()
    
    // UIStackView for the labels
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Add the icon to the view
        addSubview(icon)
        
        // Set up constraints for the icon
        NSLayoutConstraint.activate([
            icon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            icon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            icon.heightAnchor.constraint(equalToConstant: 40), // Set as per your requirement
            icon.widthAnchor.constraint(equalToConstant: 40) // Set as per your requirement
        ])
        
        // Add the stackView to the view
        addSubview(stackView)
        
        // Add the labels to the stackView
        stackView.addArrangedSubview(regularLabel)
        stackView.addArrangedSubview(boldLabel)
        
        // Set up constraints for the stackView
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
