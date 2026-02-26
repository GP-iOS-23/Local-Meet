//
//  MockMoyaProvider.swift
//  Local MeetTests
//
//  Created by Глеб Поляков on 17.02.2026.
//
import Moya
import Foundation
@testable import Local_Meet

enum MockMoyaProviderError: Error {
  case fileNotFound(String)
}

final class MockMoyaProvider {
  static func makeMockProvider(
    jsonFile: String,
    statusCode: Int = 200,
    error: NSError? = nil
  ) throws -> MoyaProvider<EventAPI> {
    
    let bundle = Bundle(for: MockMoyaProvider.self)
    
    guard let url = bundle.url(forResource: jsonFile, withExtension: "json") else {
      throw MockMoyaProviderError.fileNotFound("File \(jsonFile).json not found")
    }
    let data = try Data(contentsOf: url)
    
    let endpointClosure = { (target: EventAPI) -> Endpoint in
      Endpoint(
        url: target.baseURL.appendingPathComponent(target.path).absoluteString,
        sampleResponseClosure: {
          if let error = error {
            return .networkError(error)
          } else {
            return .networkResponse(statusCode, data)
          }
        },
        method: target.method,
        task: target.task,
        httpHeaderFields: target.headers
      )
    }
    
    return MoyaProvider<EventAPI>(
      endpointClosure: endpointClosure,
      stubClosure: { _ in .delayed(seconds: 0.01) }
    )
  }
}
