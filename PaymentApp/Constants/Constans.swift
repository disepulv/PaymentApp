//
//  Constans.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//

import Foundation
import UIKit

struct Constants {

    struct Images {
        static let baseLogo = UIImage(named: "base_logo")
        static let defaultCard = UIImage(named: "default_card")
    }

    struct Colors {
        static let defaultBGColor = #colorLiteral(red: 0.9625921845, green: 0.8430694938, blue: 0, alpha: 1)
        static let defaultCellBGColor = #colorLiteral(red: 0.9112721086, green: 0.9109323621, blue: 0.9292862415, alpha: 1)
    }

}

struct Api {
    struct Server {
        static let publicKey = "444a9ef5-8a6b-429f-abdf-587639155d88"
        static let baseURL = "https://api.mercadopago.com"
        static let version = "/v1"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
