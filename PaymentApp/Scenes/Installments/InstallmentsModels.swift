//
//  InstallmentsModels.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

enum Installments
{
    enum Installment
    {
      struct Request
      {
          var amount: String
          var issuerId: String
          var paymentMethodId: String
          var asDictionary: [String: AnyObject] {
              return [
                "amount": amount,
                "issuer.id": issuerId,
                "payment_method_id": paymentMethodId
                  ] as [String: AnyObject]
          }
      }

      struct Response {
          var isOK: Bool
          var message: String = ""
      }

      struct ViewModel {
          var isOK: Bool
          var message: String = ""
      }
        
        struct PayerCost: Codable {
            var installments: Double
            var installmentRate: Double
            var discountRate: Double
            var recommendedMessage: String
            // ...
            
            private enum CodingKeys: String, CodingKey {
                case installments
                case installmentRate = "installment_rate"
                case discountRate = "discount_rate"
                case recommendedMessage = "recommended_message"
            }
        }
        
        struct Issuer: Codable {
            var id: String
            var name: String
            var secureThumbnail: String
            var thumbnail: String
            
            private enum CodingKeys: String, CodingKey {
                case id
                case name
                case secureThumbnail = "secure_thumbnail"
                case thumbnail
            }
        }
      
      struct Result: Codable {
            var issuer: Issuer?
            var agreements: String?
            var payerCosts: [PayerCost]?
            var processingMode: String?
            var paymentTypeId: String?
            var paymentMethodId: String?
            // ...
        
          private enum CodingKeys: String, CodingKey {
              case issuer
              case agreements
              case payerCosts = "payer_costs"
              case processingMode = "processing_mode"
              case paymentTypeId = "payment_type_id"
              case paymentMethodId = "payment_method_id"
          }
      }
    }
}
