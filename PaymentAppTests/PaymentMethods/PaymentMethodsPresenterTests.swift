//
//  PaymentMethodsPresenterTests.swift
//  PaymentApp
//
//  Created by Diego on 12-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

@testable import PaymentApp
import XCTest

class PaymentMethodsPresenterTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: PaymentMethodsPresenter!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupPaymentMethodsPresenter()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupPaymentMethodsPresenter()
  {
    sut = PaymentMethodsPresenter()
  }
  
  // MARK: Test doubles
  
  class PaymentMethodsDisplayLogicSpy: PaymentMethodsDisplayLogic
  {
    var successPaymentMethodsCalled = false
    func successPaymentMethods(viewModel: PaymentMethods.PaymentMethod.ViewModel) {
        successPaymentMethodsCalled = true
    }
    
    var errorPaymentMethodsCalled = false
    func errorPaymentMethods(viewModel: PaymentMethods.PaymentMethod.ViewModel) {
        errorPaymentMethodsCalled = true
    }
    
    var successSelectedPaymentMethodCalled = false
    func successSelectedPaymentMethod(viewModel: PaymentMethods.PaymentMethod.ViewModel) {
        successSelectedPaymentMethodCalled = true
    }
    
  }
  
  // MARK: Tests
  
    func testPresentPaymentMethods()
    {
        // Given
        let spy = PaymentMethodsDisplayLogicSpy()
        sut.viewController = spy
        let responseOK = PaymentMethods.PaymentMethod.Response(isOK: true)
        let responseNOK = PaymentMethods.PaymentMethod.Response(isOK: false)

        // When
        sut.presentPaymentMethods(response: responseOK)
        sut.presentPaymentMethods(response: responseNOK)

        // Then
        XCTAssertTrue(spy.successPaymentMethodsCalled, "presentPaymentMethods(response:) should ask the view controller to display the result")
        XCTAssertTrue(spy.errorPaymentMethodsCalled, "presentPaymentMethods(response:) should ask the view controller to display the result")
    }
    
    func testPresentSelectedPaymentMethod()
    {
        // Given
        let spy = PaymentMethodsDisplayLogicSpy()
        sut.viewController = spy
        let response = PaymentMethods.PaymentMethod.Response(isOK: true)

        // When
        sut.presentSelectedPaymentMethod(response: response)

        // Then
        XCTAssertTrue(spy.successSelectedPaymentMethodCalled, "presentSelectedPaymentMethod(response:) should ask the view controller to display the result")
    }
}
