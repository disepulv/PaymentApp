//
//  PaymentMethodsInteractor.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

protocol PaymentMethodsBusinessLogic
{
    func requestPaymentMethods(request: PaymentMethods.PaymentMethod.Request)
    func selectPaymentMethod(paymentMethodSelected: PaymentMethods.PaymentMethod.Result)
}

protocol PaymentMethodsDataStore
{
    var amount: String { get set }
    var paymentMethodSelected: PaymentMethods.PaymentMethod.Result { get set }
    var paymentMethods: [PaymentMethods.PaymentMethod.Result] { get set }

}

class PaymentMethodsInteractor: PaymentMethodsBusinessLogic, PaymentMethodsDataStore
{
    
  var presenter: PaymentMethodsPresentationLogic?
  var worker: PaymentMethodsWorker?
    var amount: String = ""
    var paymentMethodSelected = PaymentMethods.PaymentMethod.Result()
    var paymentMethods: [PaymentMethods.PaymentMethod.Result] = []
  
    func requestPaymentMethods(request: PaymentMethods.PaymentMethod.Request) {
        
        worker = PaymentMethodsWorker()
        worker?.paymentMethods(request: request)
        { [] isOk, status, message, paymentMethods in

            switch isOk {
            case true:
                self.paymentMethods = paymentMethods
                let response = PaymentMethods.PaymentMethod.Response(isOK: true)
                self.presenter?.presentPaymentMethods(response: response)
            case false:
                let response = PaymentMethods.PaymentMethod.Response(isOK: false, message: message)
                self.presenter?.presentPaymentMethods(response: response)
            }
        }
    }
    
    func selectPaymentMethod(paymentMethodSelected: PaymentMethods.PaymentMethod.Result) {
        self.paymentMethodSelected = paymentMethodSelected
        let response = PaymentMethods.PaymentMethod.Response(isOK: true)
        self.presenter?.presentSelectedPaymentMethod(response: response)
    }
}
