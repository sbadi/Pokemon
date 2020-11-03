//
//  Identifiable.swift
//  Pokemon
//
//  Created by Alberto Bo on 28/10/2020.
//

import Foundation

extension String {

    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var sanitized: String  {
        self.capitalizedFirst.replacingOccurrences(of: "-", with: " ")
    }
    var capitalizedFirst: String {
        self.prefix(1).uppercased() + self.dropFirst()
    }

    var className: AnyClass? {

        /// get namespace
        guard let namespace =  Bundle.main.infoDictionary!["CFBundleExecutable"] as? String,
              /// get 'anyClass' with classname and namespace
              let cls: AnyClass = NSClassFromString("\(namespace).\(self)") else {
            return nil
        }
        return cls
    }
}

protocol Identifiable {

    var viewClass: AnyClass? { get }
    var viewName: String { get }
    var viewModelName: String { get }
}

extension Identifiable {
    var viewClass: AnyClass? {
        return self.viewName.className
    }
}
