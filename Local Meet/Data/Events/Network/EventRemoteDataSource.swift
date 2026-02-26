//
//  EventRemoteDataSource.swift
//  Local Meet
//
//  Created by Глеб Поляков on 18.02.2026.
//

import Moya
import Foundation

protocol EventRemoteDataSource {
  func fetchEvents() async throws -> [Event]
}

final class EventRemoteDataSourceImpl: EventRemoteDataSource {
  private let provider: MoyaProvider<EventAPI>
  
  init(provider: MoyaProvider<EventAPI>) {
    self.provider = provider
  }
  
  func fetchEvents() async throws -> [Event] {
    try await withCheckedThrowingContinuation { continuation in
      provider.request(.fetchEvents) { result in
        switch result {
        case .success(let response):
          do {
            let validResponse = try response.filterSuccessfulStatusCodes()
            let decoder = JSONDecoder.supabase
            let eventDTO = try decoder.decode([EventDTO].self, from: validResponse.data)
            let events = eventDTO.map { EventMapper.toDomain($0) }
            
            continuation.resume(returning: events)
          } catch {
            continuation.resume(throwing: error)
          }
        case .failure(let error):
          continuation.resume(throwing: error)
        }
      }
    }
  }
}
