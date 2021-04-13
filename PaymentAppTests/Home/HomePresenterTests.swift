//
//  HomePresenterTests.swift
//  PaymentApp
//
//  Created by Diego on 12-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

@testable import PaymentApp
import XCTest

class HomePresenterTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: HomePresenter!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupHomePresenter()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupHomePresenter()
  {
    sut = HomePresenter()
  }
  
  // MARK: Test doubles
  
  class HomeDisplayLogicSpy: HomeDisplayLogic
  {
    var successAmountCalled = false
    func successAmount(viewModel: Home.Amount.ViewModel) {
        successAmountCalled = true
    }
    
    var errorAmountCalled = false
    func errorAmount(viewModel: Home.Amount.ViewModel) {
        errorAmountCalled = true
    }
  }
  
  // MARK: Tests
  
  func testPresentSomething()
  {
    // Given
    let spy = HomeDisplayLogicSpy()
    sut.viewController = spy
    let responseOK = Home.Amount.Response(isOK: true)
    let responseNOK = Home.Amount.Response(isOK: false)
    
    // When
    sut.presentAmount(response: responseOK)
    sut.presentAmount(response: responseNOK)
    
    // Then
    XCTAssertTrue(spy.successAmountCalled, "presentAmount(response:) should ask the view controller to display the result")
    XCTAssertTrue(spy.errorAmountCalled, "presentAmount(response:) should ask the view controller to display the result")
  }
}
