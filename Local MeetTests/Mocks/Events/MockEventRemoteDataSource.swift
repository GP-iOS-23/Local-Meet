//
//  MockRemote.swift
//  Local MeetTests
//
//  Created by Глеб Поляков on 18.02.2026.
//

import XCTest
@testable import Local_Meet

final class MockEventRemoteDataSource: EventRemoteDataSource {
  var fetchResult: Result<[Event], Error>!
  private(set) var fetchCallCount = 0
  
  func fetchEvents() async throws -> [Event] {
    fetchCallCount += 1
    return try fetchResult.get()
  }
}
