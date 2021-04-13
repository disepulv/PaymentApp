//
//  CardIssuersWorker.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import Foundation
import Alamofire

class CardIssuersWorker
{
    func cardIssuers(request: CardIssuers.CardIssuer.Request, completionHandler: @escaping (_ isOK: Bool, _ status: Int, _ message: String, _ cardIssuers: [CardIssuers.CardIssuer.Result]) -> Void) {
        if !NetworkReachabilityManager()!.isReachable {
            completionHandler(false, 0, "NO_INTERNET_CONNECTION".localized, [])
        }
        
        AF.request(APIRouter.cardIssuers(request: request))
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [CardIssuers.CardIssuer.Result].self) { (response) in
                let statusCode = response.response!.statusCode
                switch response.result{
                case .success:
                    let cardIssuers = response.value ?? []
                    completionHandler(true, statusCode, "OK".localized, cardIssuers)
                case .failure(let error):
                    logger.debug("\(#function) - Error on cardIssuers: \(String(describing: error))")
                    completionHandler(false, statusCode, "UNKNOWN_ERROR".localized, [])
                }
                
            }
    }
    
}
