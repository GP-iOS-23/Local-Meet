//
//  MockLocal.swift
//  Local MeetTests
//
//  Created by Глеб Поляков on 18.02.2026.
//

import XCTest
@testable import Local_Meet

final class MockEventLocalDataSource: EventLocalDataSource {
  var fetchResult: Result<[Event], Error>!
  var saveResult: Result<Void, Error> = .success(())
  
  private(set) var fetchCallCount = 0
  private(set) var saveCallCount = 0
  private(set) var savedEvents: [Event] = []
  
  func save(events: [Event]) async throws {
    saveCallCount += 1
    savedEvents = events
    try saveResult.get()
  }
  
  func fetchEvents() async throws -> [Event] {
    fetchCallCount += 1
    return try fetchResult.get()
  }
  
  func deleteAll() async throws { }
}
