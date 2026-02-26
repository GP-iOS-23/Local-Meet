//
//  EventRepositoryImplTests.swift
//  Local MeetTests
//
//  Created by Глеб Поляков on 18.02.2026.
//

import XCTest
@testable import Local_Meet

enum TestError: Error, Equatable {
  case remoteFailure
  case localFailure
  case repositoryFetchError
}

final class EventRepositoryImplTests: XCTestCase {
  func test_fetchEvents_remoteSuccess_savesAndReturnsRemote() async throws {
    let remote = MockEventRemoteDataSource()
    let local = MockEventLocalDataSource()
    
    let events = [Event.mock()]
    
    remote.fetchResult = .success(events)
    local.fetchResult = .success([])
    local.saveResult = .success(())
    
    let repository = EventRepositoryImpl(remote: remote, local: local)
    
    let result = try await repository.fetchEvents()
    
    XCTAssertEqual(result, events)
    XCTAssertEqual(remote.fetchCallCount, 1)
    XCTAssertEqual(local.saveCallCount, 1)
    XCTAssertEqual(local.fetchCallCount, 0)
    XCTAssertEqual(local.savedEvents, events)
  }
  
  func test_fetchEvents_remoteFails_returnsCached() async throws {
    let remote = MockEventRemoteDataSource()
    let local = MockEventLocalDataSource()
    
    let cached = [Event.mock()]
    
    remote.fetchResult = .failure(TestError.remoteFailure)
    local.fetchResult = .success(cached)
    
    let repository = EventRepositoryImpl(remote: remote, local: local)
    
    let result = try await repository.fetchEvents()
    
    XCTAssertEqual(result, cached)
    XCTAssertEqual(remote.fetchCallCount, 1)
    XCTAssertEqual(local.saveCallCount, 0)
    XCTAssertEqual(local.fetchCallCount, 1)
  }
  
  func test_fetchEvents_remoteSuccess_saveFails_stillReturnsRemote() async throws {
    let remote = MockEventRemoteDataSource()
    let local = MockEventLocalDataSource()
    
    let events = [Event.mock()]
    
    remote.fetchResult = .success(events)
    local.fetchResult = .success([])
    local.saveResult = .failure(TestError.localFailure)
    
    let repository = EventRepositoryImpl(remote: remote, local: local)
    
    let result = try await repository.fetchEvents()
    
    XCTAssertEqual(result, events)
    XCTAssertEqual(remote.fetchCallCount, 1)
    XCTAssertEqual(local.saveCallCount, 1)
    XCTAssertEqual(local.fetchCallCount, 0)
  }
  
  func test_fetchEvents_remoteFails_cacheEmpty_throwsOriginalError() async {
    let remote = MockEventRemoteDataSource()
    let local = MockEventLocalDataSource()
    
    remote.fetchResult = .failure(TestError.remoteFailure)
    local.fetchResult = .success([])
    
    let repository = EventRepositoryImpl(remote: remote, local: local)
    
    do {
      _ = try await repository.fetchEvents()
      XCTFail("Expected error")
    } catch {
      XCTAssertEqual(error as? TestError, TestError.remoteFailure)
    }
    
    XCTAssertEqual(remote.fetchCallCount, 1)
    XCTAssertEqual(local.fetchCallCount, 1)
    XCTAssertEqual(local.saveCallCount, 0)
  }
  
  func test_fetchEvents_remoteFails_localFails_throwsLocalError() async {
    let remote = MockEventRemoteDataSource()
    let local = MockEventLocalDataSource()
    
    remote.fetchResult = .failure(TestError.remoteFailure)
    local.fetchResult = .failure(TestError.localFailure)
    
    let repository = EventRepositoryImpl(remote: remote, local: local)
    
    do {
      _ = try await repository.fetchEvents()
      XCTFail("Expected error")
    } catch {
      XCTAssertEqual(error as? TestError, TestError.localFailure)
    }
    
    XCTAssertEqual(remote.fetchCallCount, 1)
    XCTAssertEqual(local.fetchCallCount, 1)
    XCTAssertEqual(local.saveCallCount, 0)
  }
  
  func test_fetchEvents_remoteFails_saveNotCalled() async throws {
    let remote = MockEventRemoteDataSource()
    let local = MockEventLocalDataSource()
    
    remote.fetchResult = .failure(TestError.remoteFailure)
    local.fetchResult = .success([Event.mock()])
    
    let repository = EventRepositoryImpl(remote: remote, local: local)
    
    _ = try await repository.fetchEvents()
    
    XCTAssertEqual(remote.fetchCallCount, 1)
    XCTAssertEqual(local.fetchCallCount, 1)
    XCTAssertEqual(local.saveCallCount, 0)
  }
}
