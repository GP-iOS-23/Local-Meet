//
//  FetchEventsUseCase.swift
//  Local Meet
//
//  Created by Глеб Поляков on 13.02.2026.
//

protocol FetchEventsUseCase {
  func execute() async throws -> [Event]
}

final class FetchEventsUseCaseImpl: FetchEventsUseCase {
  private let repository: EventRepository
  
  init(repository: EventRepository) {
    self.repository = repository
  }
  
  func execute() async throws -> [Event] {
    try await repository.fetchEvents()
  }
}
