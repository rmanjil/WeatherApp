//
//  UIView+Extension.swift
//  Weather_App
//
//  Created by manjil on 06/07/2023.
//

import UIKit.UIView

extension UIView {
    static var identifier: String {
        "\(self)"
    }
    
    func fillSuperView(inset: UIEdgeInsets = .zero) {
        guard let superView = superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: inset.left).isActive = true
        self.topAnchor.constraint(equalTo: superView.topAnchor, constant: inset.top).isActive = true
        superView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: inset.right).isActive = true
        superView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: inset.bottom).isActive = true
    }
}
