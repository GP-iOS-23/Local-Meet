//
//  EventMapperTests.swift
//  Local MeetTests
//
//  Created by Глеб Поляков on 18.02.2026.
//

import XCTest
@testable import Local_Meet

final class EventMapperTests: XCTestCase {
  func testMapperMapsCorrectly() {
    let dto = EventDTO.mock
    let event = EventMapper.toDomain(dto)
    
    XCTAssertEqual(event.id, dto.id)
    XCTAssertEqual(event.title, dto.title)
    XCTAssertEqual(event.description, dto.description)
    XCTAssertEqual(event.date, dto.date)
    XCTAssertEqual(event.createdAt, dto.createdAt)
    XCTAssertEqual(event.ownerId, dto.ownerId)
  }
}
