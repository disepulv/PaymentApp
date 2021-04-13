//
//  APIRouter.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//

import Alamofire

enum APIRouter: URLRequestConvertible {
    case paymentMethods(request: PaymentMethods.PaymentMethod.Request)
    case cardIssuers(request: CardIssuers.CardIssuer.Request)
    case installments(request: Installments.Installment.Request)

    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .paymentMethods:
            return .get
        case .cardIssuers:
            return .get
        case .installments:
            return .get
        }
    }

    // MARK: - Path
    private var path: String {
        switch self {
        case .paymentMethods:
            return "/payment_methods"
        case .cardIssuers:
            return "/payment_methods/card_issuers"
        case .installments:
            return "/payment_methods/installments"
        }
    }

    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .paymentMethods:
            return nil
        case let .cardIssuers(request):
            return request.asDictionary
        case let .installments(request):
            return request.asDictionary
        }
    }

    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest
    {
        let urlString = Api.Server.baseURL
        var urlRequest: URLRequest
        let publicKeyItem = URLQueryItem(name: "public_key", value: Api.Server.publicKey)
        var queryItems = [publicKeyItem]
        
        // Parameters
        if let parameters = parameters {
            let queryParams = parameters.map {
                URLQueryItem(name: $0.0, value: $0.1 as? String ?? "")
            }
            queryItems += queryParams
        }
        
        var urlComps = URLComponents(string: urlString + Api.Server.version + path)!
        urlComps.queryItems = queryItems
        urlRequest = URLRequest(url: urlComps.url!)
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue

        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)

        logger.debug("\(#function) - UrlRequest : \(urlRequest) - Method : \(method.rawValue)")

        return urlRequest
    }
}
