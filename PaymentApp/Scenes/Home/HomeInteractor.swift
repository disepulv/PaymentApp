//
//  HomeInteractor.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic
{
    func doCheckAmount(request: Home.Amount.Request)
}

protocol HomeDataStore
{
    var amount: String { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore
{
  var presenter: HomePresentationLogic?
  var worker: HomeWorker?
  var amount: String = ""
  
  // MARK: Do something
  
    func doCheckAmount(request: Home.Amount.Request) {
        let amount = Int(request.amount) ?? 0
        guard amount > 0 else {
            let response = Home.Amount.Response(isOK: false, message: "Ingrese un monto válido".localized)
            self.presenter?.presentAmount(response: response)
            return
        }
        
        self.amount = request.amount
        let response = Home.Amount.Response(isOK: true)
        self.presenter?.presentAmount(response: response)
    }
}
