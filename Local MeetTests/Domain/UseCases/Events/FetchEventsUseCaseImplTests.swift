//
//  FetchEventsUseCaseImplTests.swift
//  Local MeetTests
//
//  Created by Глеб Поляков on 18.02.2026.
//

import XCTest
@testable import Local_Meet

final class FetchEventsUseCaseImplTests: XCTestCase {
  func test_execute_returnsEvents_whenRepositorySucceeds() async throws {
    let repository = MockEventRepository()
    let events = [Event.mock()]
    repository.fetchResult = .success(events)
    
    let useCase = FetchEventsUseCaseImpl(repository: repository)
    
    let result = try await useCase.execute()
    
    XCTAssertEqual(result, events)
    XCTAssertEqual(repository.fetchCount, 1)
  }
  
  func test_execute_throwsError_whenRepositoryFails() async throws {
    let repository = MockEventRepository()
    repository.fetchResult = .failure(TestError.repositoryFetchError)
    
    let useCase = FetchEventsUseCaseImpl(repository: repository)
    
    do {
      _ = try await useCase.execute()
      XCTFail("Expected error")
    } catch {
      XCTAssertEqual(error as? TestError, TestError.repositoryFetchError)
    }
    
    XCTAssertEqual(repository.fetchCount, 1)
  }
}
