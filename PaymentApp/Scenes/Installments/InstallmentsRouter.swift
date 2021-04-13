//
//  InstallmentsRouter.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

@objc protocol InstallmentsRoutingLogic
{
  //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol InstallmentsDataPassing
{
  var dataStore: InstallmentsDataStore? { get }
}

class InstallmentsRouter: NSObject, InstallmentsRoutingLogic, InstallmentsDataPassing
{
  weak var viewController: InstallmentsViewController?
  var dataStore: InstallmentsDataStore?
  
  // MARK: Routing
  
  //func routeToSomewhere(segue: UIStoryboardSegue?)
  //{
  //  if let segue = segue {
  //    let destinationVC = segue.destination as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //  } else {
  //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
  //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
  //    var destinationDS = destinationVC.router!.dataStore!
  //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
  //    navigateToSomewhere(source: viewController!, destination: destinationVC)
  //  }
  //}

  // MARK: Navigation
  
  //func navigateToSomewhere(source: InstallmentsViewController, destination: SomewhereViewController)
  //{
  //  source.show(destination, sender: nil)
  //}
  
  // MARK: Passing data
  
  //func passDataToSomewhere(source: InstallmentsDataStore, destination: inout SomewhereDataStore)
  //{
  //  destination.name = source.name
  //}
}
