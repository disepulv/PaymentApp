//
//  CardIssuersModels.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

enum CardIssuers
{
  // MARK: Use cases
  
    enum CardIssuer
    {
      struct Request
      {
          var paymentMethodId: String = ""
          var cardIssuerId: String = ""
          var asDictionary: [String: AnyObject] {
              return [
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
      
      struct Result: Codable {
          var id: String?
          var name: String?
          var thumbnail: String?
          var processingMode: String?
          var secureThumbnail: String?
          var merchantAccountId: String?

          private enum CodingKeys: String, CodingKey {
              case id
              case name
              case thumbnail
              case processingMode = "processing_mode"
              case secureThumbnail = "secure_thumbnail"
              case merchantAccountId = "merchant_account_id"
          }
      }
    }

}
