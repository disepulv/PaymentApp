//
//  HomeRouter.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

@objc protocol HomeRoutingLogic
{
    func routeToPaymentMethods(segue: UIStoryboardSegue?)
}

protocol HomeDataPassing
{
  var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing
{
  weak var viewController: HomeViewController?
  var dataStore: HomeDataStore?
  
  // MARK: Routing
  
  func routeToPaymentMethods(segue: UIStoryboardSegue?)
  {
    if let segue = segue {
      let destinationVC = segue.destination as! PaymentMethodsViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToPaymentMethods(source: dataStore!, destination: &destinationDS)
    } else {
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      let destinationVC = storyboard.instantiateViewController(withIdentifier: "PaymentMethodsViewController") as! PaymentMethodsViewController
      var destinationDS = destinationVC.router!.dataStore!
      passDataToPaymentMethods(source: dataStore!, destination: &destinationDS)
      navigateToPaymentMethods(source: viewController!, destination: destinationVC)
    }
  }

  // MARK: Navigation
  
  func navigateToPaymentMethods(source: HomeViewController, destination: PaymentMethodsViewController)
  {
//    source.show(destination, sender: nil)
    let navController = UINavigationController(rootViewController: destination)
    source.present(navController, animated: true, completion: nil)
  }
  
  // MARK: Passing data
  
  func passDataToPaymentMethods(source: HomeDataStore, destination: inout PaymentMethodsDataStore)
  {
    destination.amount = source.amount
  }
}
