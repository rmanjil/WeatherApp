//
//  UITableView+Extension.swift
//  Weather_App
//
//  Created by manjil on 06/07/2023.
//

import UIKit.UITableView

extension UITableView {
    func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        self.register(cellClass, forCellReuseIdentifier: String(describing: cellClass.identifier))
    }
    
    func dequeueCell<T: UITableViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.identifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue \(String(describing: cellClass)) with reuseId of \(String(describing: T.self))")
        }
        return cell
    }
    
    func registerHeader<T: UITableViewHeaderFooterView>(_ name: T.Type) {
        register(name, forHeaderFooterViewReuseIdentifier: name.identifier)
    }
    
    func dequeueHeader<T: UITableViewHeaderFooterView>(_ name: T.Type) -> T? {
        dequeueReusableHeaderFooterView(withIdentifier: name.identifier) as? T
    }
}
