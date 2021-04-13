//
//  HomeWorkerTests.swift
//  PaymentApp
//
//  Created by Diego on 12-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

@testable import PaymentApp
import XCTest

class HomeWorkerTests: XCTestCase
{
  // MARK: Subject under test
  
  var sut: HomeWorker!
  
  // MARK: Test lifecycle
  
  override func setUp()
  {
    super.setUp()
    setupHomeWorker()
  }
  
  override func tearDown()
  {
    super.tearDown()
  }
  
  // MARK: Test setup
  
  func setupHomeWorker()
  {
    sut = HomeWorker()
  }
  
  // MARK: Test doubles
  
  // MARK: Tests
  
  func testSomething()
  {
    // Given
    
    // When
    
    // Then
  }
}
