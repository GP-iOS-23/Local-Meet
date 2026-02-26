//
//  EventRealmMapperTests.swift
//  Local MeetTests
//
//  Created by Глеб Поляков on 18.02.2026.
//

import XCTest
@testable import Local_Meet

final class EventRealmMapperTests: XCTestCase {
  func test_toLocal_mapsCorrectly() {
    let event = Event.mock
    let object = EventRealmMapper.toLocal(event)
    
    XCTAssertEqual(event.id, object.id)
    XCTAssertEqual(event.title, object.title)
    XCTAssertEqual(event.description, object.descriptionText)
    XCTAssertEqual(event.date, object.date)
    XCTAssertEqual(event.createdAt, object.createdAt)
    XCTAssertEqual(event.ownerId, object.ownerId)
  }
  
  func test_toDomain_mapsCorrectly() {
    let object = EventObject()
    object.id = UUID()
    object.title = "Test"
    object.descriptionText = "Desc"
    object.date = Date()
    object.createdAt = Date()
    object.ownerId = UUID()
    
    let event = EventRealmMapper.toDomain(object)
    XCTAssertEqual(event.id, object.id)
    XCTAssertEqual(event.title, object.title)
    XCTAssertEqual(event.description, object.descriptionText)
    XCTAssertEqual(event.date, object.date)
    XCTAssertEqual(event.createdAt, object.createdAt)
    XCTAssertEqual(event.ownerId, object.ownerId)
  }
}


/*
 XCTAssertEqual failed:
 ("Optional(
    "EventObject
        id = 652AF428-0FF7-4C57-97DB-609AEB23BF95
        title = Test
        descriptionText = Desc
        date = 2026-02-26 15:10:14 +0000
        createdAt = 2026-02-26 15:10:14 +0000
        ownerId = 7A3F3827-3517-4E07-90BA-867A45DF45F8
  
    "Desc"
 
 */
