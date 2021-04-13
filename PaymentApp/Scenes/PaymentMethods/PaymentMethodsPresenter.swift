//
//  PaymentMethodsPresenter.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

protocol PaymentMethodsPresentationLogic
{
    
    func presentPaymentMethods(response: PaymentMethods.PaymentMethod.Response)
    func presentSelectedPaymentMethod(response: PaymentMethods.PaymentMethod.Response)
}

class PaymentMethodsPresenter: PaymentMethodsPresentationLogic
{

    
  weak var viewController: PaymentMethodsDisplayLogic?
  
    func presentPaymentMethods(response: PaymentMethods.PaymentMethod.Response)
    {
      let isOK = response.isOK
      let message = response.message
      let viewModel = PaymentMethods.PaymentMethod.ViewModel(isOK: isOK, message: message)

      if isOK {
          viewController?.successPaymentMethods(viewModel: viewModel)
      } else {
          viewController?.errorPaymentMethods(viewModel: viewModel)
      }
    }
    
    func presentSelectedPaymentMethod(response: PaymentMethods.PaymentMethod.Response) {
        
        let isOK = response.isOK
        let message = response.message
        let viewModel = PaymentMethods.PaymentMethod.ViewModel(isOK: isOK, message: message)

        viewController?.successSelectedPaymentMethod(viewModel: viewModel)
    }
}
