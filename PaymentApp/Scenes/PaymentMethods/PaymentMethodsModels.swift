//
//  PaymentMethodsModels.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

enum PaymentMethods
{
  // MARK: Use cases
  
    enum PaymentMethod
    {
        struct Request
        {
            var paymentMethodId: String = ""
        }
        struct Response {
            var isOK: Bool
            var message: String = ""
        }

        struct ViewModel {
            var isOK: Bool
            var message: String = ""
        }
        
        struct Result:Codable {
            var id: String?
            var name: String?
            var status: String?
            var thumbnail: String?
            var paymentTypeId: String?
            var secureThumbnail: String?
            var deferredCapture: String?

            private enum CodingKeys: String, CodingKey {
                case id
                case name
                case status
                case thumbnail
                case paymentTypeId = "payment_type_id"
                case secureThumbnail = "secure_thumbnail"
                case deferredCapture = "deferred_capture"
            }
        }
    }
}
