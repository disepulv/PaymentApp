//
//  PaymentMethodsInteractorTests.swift
//  PaymentApp
//
//  Created by Diego on 12-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

@testable import PaymentApp
import XCTest

class PaymentMethodsInteractorTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: PaymentMethodsInteractor!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupPaymentMethodsInteractor()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupPaymentMethodsInteractor()
  {
    sut = PaymentMethodsInteractor()
  }
  
  // MARK: Test doubles
  
  class PaymentMethodsPresentationLogicSpy: PaymentMethodsPresentationLogic
  {
    var presentPaymentMethodsCalled = false
    func presentPaymentMethods(response: PaymentMethods.PaymentMethod.Response) {
        presentPaymentMethodsCalled = true
    }
    
    var presentSelectedPaymentMethodCalled = false
    func presentSelectedPaymentMethod(response: PaymentMethods.PaymentMethod.Response) {
        presentSelectedPaymentMethodCalled = true
    }
    
  }
  
  // MARK: Tests
  
  func testRequestPaymentMethods()
  {
    // Given
    let spy = PaymentMethodsPresentationLogicSpy()
    sut.presenter = spy
    let request = PaymentMethods.PaymentMethod.Request()

    // When
//    sut.requestPaymentMethods(request: request)
    
    // Then
//    waitForExpectations(timeout: 10)
//    XCTAssertTrue(spy.presentPaymentMethodsCalled, "requestPaymentMethods(request:) should ask the presenter to format the result")
  }
}
