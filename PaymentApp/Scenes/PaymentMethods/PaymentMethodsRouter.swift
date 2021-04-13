//
//  PaymentMethodsRouter.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

@objc protocol PaymentMethodsRoutingLogic
{
    func routeToCardIssuers(segue: UIStoryboardSegue?)
}

protocol PaymentMethodsDataPassing
{
  var dataStore: PaymentMethodsDataStore? { get }
}

class PaymentMethodsRouter: NSObject, PaymentMethodsRoutingLogic, PaymentMethodsDataPassing
{
  weak var viewController: PaymentMethodsViewController?
  var dataStore: PaymentMethodsDataStore?
  
  // MARK: Routing
  
  func routeToCardIssuers(segue: UIStoryboardSegue?)
  {
    if let segue = segue {
      let destinationVC = segue.destination as! CardIssuersViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToCardIssuers(source: dataStore!, destination: &destinationDS)
    } else {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let destinationVC = storyboard.instantiateViewController(withIdentifier: "CardIssuersViewController") as! CardIssuersViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToCardIssuers(source: dataStore!, destination: &destinationDS)
      navigateToCardIssuers(source: viewController!, destination: destinationVC)
    }
  }

  // MARK: Navigation
  
  func navigateToCardIssuers(source: PaymentMethodsViewController, destination: CardIssuersViewController)
  {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
  
  func passDataToCardIssuers(source: PaymentMethodsDataStore, destination: inout CardIssuersDataStore)
  {
    destination.amount = source.amount
    destination.paymentMethodSelected = source.paymentMethodSelected
  }
}
