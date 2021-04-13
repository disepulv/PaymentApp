//
//  HomeInteractorTests.swift
//  PaymentApp
//
//  Created by Diego on 12-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

@testable import PaymentApp
import XCTest

class HomeInteractorTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: HomeInteractor!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupHomeInteractor()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupHomeInteractor()
  {
    sut = HomeInteractor()
  }
  
  // MARK: Test doubles
  
  class HomePresentationLogicSpy: HomePresentationLogic
  {
    var presentAmountCalled = false
    var response: Home.Amount.Response!
    func presentAmount(response: Home.Amount.Response) {
        presentAmountCalled = true
        self.response = response
    }
  }
  
  // MARK: Tests
  
  func testShouldCheckInvalidAmount()
  {
    // Given
    let spy = HomePresentationLogicSpy()
    sut.presenter = spy
    let request = Home.Amount.Request(amount: "dsfsd")
    
    // When
    sut.doCheckAmount(request: request)
    
    // Then
    XCTAssertTrue(spy.presentAmountCalled, "doCheckAmount(request:) should ask the presenter to format the result")
    XCTAssertFalse(spy.response!.isOK, "doCheckAmount(request:) response should be false")
  }
    
    func testShouldCheckValidAmount()
    {
      // Given
      let spy = HomePresentationLogicSpy()
      sut.presenter = spy
      let request = Home.Amount.Request(amount: "123")
      
      // When
      sut.doCheckAmount(request: request)
      
      // Then
      XCTAssertTrue(spy.presentAmountCalled, "doCheckAmount(request:) should ask the presenter to format the result")
      XCTAssertTrue(spy.response!.isOK, "doCheckAmount(request:) response should be true")
    }
}
