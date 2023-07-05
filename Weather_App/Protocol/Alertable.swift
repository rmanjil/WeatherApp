//
//  Alertable.swift
//  Weather_App
//
//  Created by manjil on 05/07/2023.
//

import UIKit.UIAlert

public protocol Alertable {
    var title: String { get }
    var style: UIAlertAction.Style { get }
    var tag: Int { get }
}

enum AlertConstant: Alertable {
    case ok
    case delete
    case cancel
    case logout
    
    var title: String {
        switch self {
        case .delete: return "Delete"
        case .ok:
            return "Ok"
        case .cancel:
            return "Cancel"
        case .logout: return "Logout"
        }
    }
    
    var style: UIAlertAction.Style {
        switch self {
        case .delete, .logout:
            return .destructive
        case .cancel:
            return .cancel
        default:
            return .default
        }
        
    }
    
    var tag: Int {
        return 0
    }
}
