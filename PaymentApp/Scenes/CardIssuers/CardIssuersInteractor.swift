//
//  CardIssuersInteractor.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

protocol CardIssuersBusinessLogic
{
    func requestCardIssuers(request: CardIssuers.CardIssuer.Request)
    func selectCardIssuer(cardIssuerSelected: CardIssuers.CardIssuer.Result)
}

protocol CardIssuersDataStore
{
    var amount: String { get set }
    var cardIssuerSelected: CardIssuers.CardIssuer.Result { get set }
    var cardIssuers: [CardIssuers.CardIssuer.Result] { get set }
    var paymentMethodSelected: PaymentMethods.PaymentMethod.Result { get set }
}

class CardIssuersInteractor: CardIssuersBusinessLogic, CardIssuersDataStore
{
    
  var presenter: CardIssuersPresentationLogic?
  var worker: CardIssuersWorker?
    var amount: String = ""
    var cardIssuers: [CardIssuers.CardIssuer.Result] = []
    var cardIssuerSelected = CardIssuers.CardIssuer.Result()
    var paymentMethodSelected = PaymentMethods.PaymentMethod.Result()
  
    func requestCardIssuers(request: CardIssuers.CardIssuer.Request) {
        worker = CardIssuersWorker()
        worker?.cardIssuers(request: request)
        { [] isOk, status, message, cardIssuers in

            switch isOk {
            case true:
                self.cardIssuers = cardIssuers
                let response = CardIssuers.CardIssuer.Response(isOK: true)
                self.presenter?.presentCardIssuers(response: response)
            case false:
                let response = CardIssuers.CardIssuer.Response(isOK: false, message: message)
                self.presenter?.presentCardIssuers(response: response)
            }
        }
    }
    
    func selectCardIssuer(cardIssuerSelected: CardIssuers.CardIssuer.Result) {
        self.cardIssuerSelected = cardIssuerSelected
        let response = CardIssuers.CardIssuer.Response(isOK: true)
        self.presenter?.presentSelectedCardIssuer(response: response)
    }
    
}
