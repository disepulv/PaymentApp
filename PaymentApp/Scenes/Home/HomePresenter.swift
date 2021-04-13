//
//  HomePresenter.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

protocol HomePresentationLogic
{
    func presentAmount(response: Home.Amount.Response)
}

class HomePresenter: HomePresentationLogic
{
  weak var viewController: HomeDisplayLogic?

  func presentAmount(response: Home.Amount.Response)
  {
    let isOK = response.isOK
    let message = response.message
    let viewModel = Home.Amount.ViewModel(isOK: isOK, message: message)

    if isOK {
        viewController?.successAmount(viewModel: viewModel)
    } else {
        viewController?.errorAmount(viewModel: viewModel)
    }
  }
}
