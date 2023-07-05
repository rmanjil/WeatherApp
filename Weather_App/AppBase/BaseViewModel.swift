//
//  BaseViewModel.swift
//  Weather_App
//
//  Created by manjil on 05/07/2023.
//

import Foundation
import Combine

class BaseViewModel {
    
    var bag = Set<AnyCancellable>()
    
    /// Deint call check
    deinit {
        debugPrint("De-Initialized --> \(String(describing: self))")
    }
}
