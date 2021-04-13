//
//  InstallmentsInteractor.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

protocol InstallmentsBusinessLogic
{
    func requestInstallments(request: Installments.Installment.Request)
}

protocol InstallmentsDataStore
{
    var amount: String { get set }
    var paymentMethodSelected: PaymentMethods.PaymentMethod.Result { get set }
    var cardIssuerSelected: CardIssuers.CardIssuer.Result { get set }
    var installments: [Installments.Installment.Result] { get set }
}

class InstallmentsInteractor: InstallmentsBusinessLogic, InstallmentsDataStore
{
  var presenter: InstallmentsPresentationLogic?
  var worker: InstallmentsWorker?
    var amount: String = ""
    var paymentMethodSelected = PaymentMethods.PaymentMethod.Result()
    var cardIssuerSelected = CardIssuers.CardIssuer.Result()
    var installments: [Installments.Installment.Result] = []
  
    func requestInstallments(request: Installments.Installment.Request) {
        worker = InstallmentsWorker()
        worker?.installments(request: request)
        { [] isOk, status, message, installments in

            switch isOk {
            case true:
                self.installments = installments
                let response = Installments.Installment.Response(isOK: true)
                self.presenter?.presentInstallments(response: response)
            case false:
                let response = Installments.Installment.Response(isOK: false, message: message)
                self.presenter?.presentInstallments(response: response)
            }
        }
    }

}
