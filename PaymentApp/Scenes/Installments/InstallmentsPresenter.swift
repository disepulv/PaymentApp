//
//  InstallmentsPresenter.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

protocol InstallmentsPresentationLogic
{
    func presentInstallments(response: Installments.Installment.Response)
}

class InstallmentsPresenter: InstallmentsPresentationLogic
{
  weak var viewController: InstallmentsDisplayLogic?
  
    func presentInstallments(response: Installments.Installment.Response) {
        let isOK = response.isOK
        let message = response.message
        let viewModel = Installments.Installment.ViewModel(isOK: isOK, message: message)

        if isOK {
            viewController?.successInstallments(viewModel: viewModel)
        } else {
            viewController?.errorInstallments(viewModel: viewModel)
        }
    }
  
}
