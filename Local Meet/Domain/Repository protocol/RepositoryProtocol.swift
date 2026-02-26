//
//  RepositoryProtocol.swift
//  Local Meet
//
//  Created by Глеб Поляков on 17.02.2026.
//

protocol EventRepository {
  func fetchEvents() async throws -> [Event]
}
