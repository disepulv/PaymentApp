//
//  CardIssuersPresenter.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

protocol CardIssuersPresentationLogic
{
    func presentCardIssuers(response: CardIssuers.CardIssuer.Response)
    func presentSelectedCardIssuer(response: CardIssuers.CardIssuer.Response)
}

class CardIssuersPresenter: CardIssuersPresentationLogic
{
  weak var viewController: CardIssuersDisplayLogic?
  
  // MARK: Do something
  
    func presentCardIssuers(response: CardIssuers.CardIssuer.Response) {
        let isOK = response.isOK
        let message = response.message
        let viewModel = CardIssuers.CardIssuer.ViewModel(isOK: isOK, message: message)

        if isOK {
            viewController?.successCardIssuers(viewModel: viewModel)
        } else {
            viewController?.errorCardIssuers(viewModel: viewModel)
        }
    }
    
    func presentSelectedCardIssuer(response: CardIssuers.CardIssuer.Response) {
        
        let isOK = response.isOK
        let message = response.message
        let viewModel = CardIssuers.CardIssuer.ViewModel(isOK: isOK, message: message)

        viewController?.successSelectedCardIssuer(viewModel: viewModel)
    }
    
}
