//
//  PaymentMethodsViewControllerTests.swift
//  PaymentApp
//
//  Created by Diego on 12-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

@testable import PaymentApp
import XCTest

class PaymentMethodsViewControllerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: PaymentMethodsViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    window = UIWindow()
    setupPaymentMethodsViewController()
  }
  
  override func tearDown()
  {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupPaymentMethodsViewController()
  {
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    sut = storyboard.instantiateViewController(withIdentifier: "PaymentMethodsViewController") as? PaymentMethodsViewController
  }
  
  func loadView()
  {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: Test doubles
  
  class PaymentMethodsBusinessLogicSpy: PaymentMethodsBusinessLogic
  {
    
    var doRequestPaymentMethodsCalled = false
    func requestPaymentMethods(request: PaymentMethods.PaymentMethod.Request) {
        doRequestPaymentMethodsCalled = true
    }
    
    var doSelectPaymentMethodCalled = false
    func selectPaymentMethod(paymentMethodSelected: PaymentMethods.PaymentMethod.Result) {
        doSelectPaymentMethodCalled = true
    }

  }
  
  // MARK: Tests
  
  func testShouldDoPaymentMethodsWhenViewIsLoaded()
  {
    // Given
    let spy = PaymentMethodsBusinessLogicSpy()
    sut.interactor = spy
    
    // When
    loadView()
    
    // Then
    XCTAssertTrue(spy.doRequestPaymentMethodsCalled, "viewDidLoad() should ask the interactor to do something")
  }
 
}
