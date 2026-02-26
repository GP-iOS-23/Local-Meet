//
//  EventRepositoryImplTests.swift
//  Local MeetTests
//
//  Created by Глеб Поляков on 18.02.2026.
//

import XCTest
import Moya
import Alamofire
@testable import Local_Meet

final class EventRemoteDataSourceImplTests: XCTestCase {
  
  func testFetchEventsSuccess() async throws {
    let sut = try makeSUT(jsonFile: "MockEvents")
    let events = try await sut.fetchEvents()
    
    XCTAssertEqual(events.count, 1)
    XCTAssertEqual(events.first?.title, "Встреча 1")
  }
  
  func testFetchEventsFailure() async throws {
    let sut = try makeSUT(jsonFile: "MockEvents", statusCode: 401)
    
    await XCTAssertThrowsErrorAsync(try await sut.fetchEvents()) { error in
      XCTAssertTrue(error is MoyaError)
    }
  }
  
  func testFetchEventsDecodingFailure() async throws {
    let sut = try makeSUT(jsonFile: "InvalidJson")
    
    await XCTAssertThrowsErrorAsync(try await sut.fetchEvents()) { error in
      XCTAssertTrue(error is DecodingError)
    }
  }
  
  func testFetchEventsEmptyArray() async throws {
    let sut = try makeSUT(jsonFile: "EmptyEvents")
    
    let events = try await sut.fetchEvents()
    
    XCTAssertTrue(events.isEmpty)
  }
  
  private func makeSUT(
    jsonFile: String,
    statusCode: Int = 200
  ) throws -> EventRemoteDataSourceImpl {
    let provider = try MockMoyaProvider.makeMockProvider(
      jsonFile: jsonFile,
      statusCode: statusCode)
    return EventRemoteDataSourceImpl(provider: provider)
  }
}
