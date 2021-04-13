//
//  HomeModels.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

enum Home
{
  // MARK: Use cases
    
    enum Amount
    {
        struct Request
        {
            var amount: String
        }
        struct Response {
            var isOK: Bool
            var message: String = ""
        }

        struct ViewModel {
            var isOK: Bool
            var message: String = ""
        }
        
    }
}
