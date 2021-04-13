//
//  String+Extensions.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }

}
