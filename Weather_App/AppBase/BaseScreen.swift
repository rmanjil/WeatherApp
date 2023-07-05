//
//  BaseScreen.swift
//  Weather_App
//
//  Created by manjil on 05/07/2023.
//

import UIKit

class BaseScreen: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareLayout() {
        backgroundColor = .white
    }
    
    
    /// Deinit call check
    deinit {
        debugPrint("De-Initialized --> \(String(describing: self))")
    }
    
}
