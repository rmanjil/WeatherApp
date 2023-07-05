//
//  UIImage+Extension.swift
//  Weather_App
//
//  Created by manjil on 05/07/2023.
//

import UIKit.UIImage

extension UIImage {
    
    func setTemplate() -> UIImage {
        return self.withRenderingMode(.alwaysTemplate)
    }
    
    private static func named(_ imageName: String) -> UIImage {
        guard let image = UIImage(named: imageName) else {
            assertionFailure("The image associated with name \(imageName) was not found. Please check you have spelled it correctly.")
            return UIImage()
        }
        return image
    }
    
    private static let symbolConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
    
    static let back = UIImage(systemName: "chevron.backward", withConfiguration: symbolConfig)

    
}
