//
//  EventRepositoryImpl.swift
//  Local Meet
//
//  Created by Глеб Поляков on 17.02.2026.
//

import Moya
import Foundation

final class EventRepositoryImpl: EventRepository {
  private let remote: EventRemoteDataSource
  private let local: EventLocalDataSource
  
  init(remote: EventRemoteDataSource, local: EventLocalDataSource) {
    self.remote = remote
    self.local = local
  }
  
  func fetchEvents() async throws -> [Event] {
    do {
      let events = try await remote.fetchEvents()
      try? await local.save(events: events)
      return events
    } catch {
      let cached = try await local.fetchEvents()
      if cached.isEmpty {
        throw error
      }
      return cached
    }
  }
}
