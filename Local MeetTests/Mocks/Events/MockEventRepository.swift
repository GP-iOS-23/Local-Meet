//
//  MockEventRepository.swift
//  Local MeetTests
//
//  Created by Глеб Поляков on 18.02.2026.
//

import XCTest
@testable import Local_Meet

final class MockEventRepository: EventRepository {
  var fetchResult: Result<[Event], Error>?
  var fetchCount = 0
  
  func fetchEvents() async throws -> [Event] {
    fetchCount += 1
    
    switch fetchResult {
    case .success(let events):
      return events
    case .failure(let error):
      throw error
    case nil:
      return []
    }
  }
}
