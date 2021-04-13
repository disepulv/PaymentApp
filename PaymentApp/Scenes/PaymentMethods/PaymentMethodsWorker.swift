//
//  PaymentMethodsWorker.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import Foundation
import Alamofire

class PaymentMethodsWorker
{
 
    func paymentMethods(request: PaymentMethods.PaymentMethod.Request, completionHandler: @escaping (_ isOK: Bool, _ status: Int, _ message: String, _ paymentsMethods: [PaymentMethods.PaymentMethod.Result]) -> Void) {
        if !NetworkReachabilityManager()!.isReachable {
            completionHandler(false, 0, "NO_INTERNET_CONNECTION".localized, [])
        }
        
        AF.request(APIRouter.paymentMethods(request: request))
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [PaymentMethods.PaymentMethod.Result].self) { (response) in
                let statusCode = response.response!.statusCode
                switch response.result{
                case .success:
                    let paymentMethods = response.value ?? []
                    completionHandler(true, statusCode, "OK".localized, paymentMethods)
                case .failure(let error):
                    logger.debug("\(#function) - Error on paymentMethods: \(String(describing: error))")
                    completionHandler(false, statusCode, "UNKNOWN_ERROR".localized, [])
                }
            }
    }
}
