//
//  UIViewController+Extensions.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//

import Foundation
import UIKit

extension UIViewController {

    func alert(message: String, title: String = "PaymentApp".localized, buttonTitle: String = "OK".localized, handler: ((UIAlertAction) -> Void)? = nil, async: Bool = false) {
        let titleString = title
        var titleMutableString = NSMutableAttributedString()
        titleMutableString = NSMutableAttributedString(string: titleString as String, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15)])

        let messageString = message.isEmpty ? "UNKNOW_ERROR".localized : message
        var messageMutableString = NSMutableAttributedString()
        messageMutableString = NSMutableAttributedString(string: messageString as String, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)])

        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.setValue(titleMutableString, forKey: "attributedTitle")
        alertController.setValue(messageMutableString, forKey: "attributedMessage")
        let OKAction = UIAlertAction(title: buttonTitle, style: .default, handler: handler)
        alertController.addAction(OKAction)
        
        if async {
            DispatchQueue.main.async {
                self.present(alertController, animated: true, completion: nil)
            }
        } else {
            present(alertController, animated: true, completion: nil)
        }
    }
}
