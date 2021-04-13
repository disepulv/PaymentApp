//
//  HomeViewControllerTests.swift
//  PaymentApp
//
//  Created by Diego on 12-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

@testable import PaymentApp
import XCTest

class HomeViewControllerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: HomeViewController!
  var window: UIWindow!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    window = UIWindow()
    setupHomeViewController()
  }
  
  override func tearDown()
  {
    window = nil
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupHomeViewController()
  {
    let bundle = Bundle.main
    let storyboard = UIStoryboard(name: "Main", bundle: bundle)
    sut = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
  }
  
  func loadView()
  {
    window.addSubview(sut.view)
    RunLoop.current.run(until: Date())
  }
  
  // MARK: Test doubles
  
  class HomeBusinessLogicSpy: HomeBusinessLogic
  {
    var doRequestAmountCalled = false
    func doCheckAmount(request: Home.Amount.Request) {
        doRequestAmountCalled = true
    }
    
  }
  
  // MARK: Tests
  
  func testShouldEmptyAmount()
  {
    // Given
    
    // When
    loadView()
    
    // Then
    XCTAssertEqual(sut.amountTextField.text, "", "should be empty amount")
  }
}
