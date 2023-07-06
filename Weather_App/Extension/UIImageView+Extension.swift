//
//  UIImageView+Extension.swift
//  Weather_App
//
//  Created by manjil on 06/07/2023.
//

import UIKit.UIImageView
import Kingfisher

extension UIImageView {
    func loadImage(with url: URL?, placeholder: UIImage? = nil) {
          self.kf.indicatorType = .activity
          self.kf.setImage(with: url, placeholder: placeholder)
      }
}
