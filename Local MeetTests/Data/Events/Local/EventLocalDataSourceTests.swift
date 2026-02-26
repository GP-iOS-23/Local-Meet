//
//  EventRealmDataSourceTests.swift
//  Local MeetTests
//
//  Created by Глеб Поляков on 18.02.2026.
//

import XCTest
@testable import Local_Meet

final class EventLocalDataSourceTests: XCTestCase {
  func test_saveAndFetch_returnsSavedEvents() async throws {
    let ds = try EventLocalDataSourceImpl(configuration: .inMemoryTestConfiguration())
    let events = [Event.mock]
    
    try await ds.save(events: events)
    let fetchedEvents = try await ds.fetchEvents()
    
    XCTAssertEqual(fetchedEvents.count, 1)
    XCTAssertEqual(fetchedEvents.first?.id, events.first?.id)
  }
  
  func test_save_updateExistingEvent() async throws {
    let ds = try EventLocalDataSourceImpl(configuration: .inMemoryTestConfiguration())
    var event = Event.mock
    
    try await ds.save(events: [event])
    event = event.copy(title: "Updated")
    
    try await ds.save(events: [event])
    let fetched = try await ds.fetchEvents()
    XCTAssertEqual(fetched.first?.title, "Updated")
  }
  
  func test_fetchEmpty_returnsEmptyArray() async throws {
    let ds = try EventLocalDataSourceImpl(configuration: .inMemoryTestConfiguration())
    let fetchedEvents = try await ds.fetchEvents()
    
    XCTAssertTrue(fetchedEvents.isEmpty)
  }
}
