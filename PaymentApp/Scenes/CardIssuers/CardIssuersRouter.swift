//
//  CardIssuersRouter.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

@objc protocol CardIssuersRoutingLogic
{
    func routeToInstallments(segue: UIStoryboardSegue?)
}

protocol CardIssuersDataPassing
{
  var dataStore: CardIssuersDataStore? { get }
}

class CardIssuersRouter: NSObject, CardIssuersRoutingLogic, CardIssuersDataPassing
{
  weak var viewController: CardIssuersViewController?
  var dataStore: CardIssuersDataStore?
  
  // MARK: Routing
  
  func routeToInstallments(segue: UIStoryboardSegue?)
  {
    if let segue = segue {
      let destinationVC = segue.destination as! InstallmentsViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToInstallments(source: dataStore!, destination: &destinationDS)
    } else {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let destinationVC = storyboard.instantiateViewController(withIdentifier: "InstallmentsViewController") as! InstallmentsViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToInstallments(source: dataStore!, destination: &destinationDS)
      navigateToInstallments(source: viewController!, destination: destinationVC)
    }
  }

  // MARK: Navigation
  
  func navigateToInstallments(source: CardIssuersViewController, destination: InstallmentsViewController)
  {
    source.show(destination, sender: nil)
  }
  
  // MARK: Passing data
  
  func passDataToInstallments(source: CardIssuersDataStore, destination: inout InstallmentsDataStore)
  {
    destination.amount = source.amount
    destination.paymentMethodSelected = source.paymentMethodSelected
    destination.cardIssuerSelected = source.cardIssuerSelected
  }
}
