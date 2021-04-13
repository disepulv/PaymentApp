//
//  InstallmentsWorker.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit
import Alamofire

class InstallmentsWorker
{    
    func installments(request: Installments.Installment.Request, completionHandler: @escaping (_ isOK: Bool, _ status: Int, _ message: String, _ installments: [Installments.Installment.Result]) -> Void) {
        if !NetworkReachabilityManager()!.isReachable {
            completionHandler(false, 0, "NO_INTERNET_CONNECTION".localized, [])
        }
        
        AF.request(APIRouter.installments(request: request))
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Installments.Installment.Result].self) { (response) in
                let statusCode = response.response!.statusCode
                switch response.result{
                case .success:
                    let installments = response.value ?? []
                    completionHandler(true, statusCode, "OK".localized, installments)
                case .failure(let error):
                    logger.debug("\(#function) - Error on paymentMethods: \(String(describing: error))")
                    completionHandler(false, statusCode, "UNKNOWN_ERROR".localized, [])
                }
            }
    }
}
