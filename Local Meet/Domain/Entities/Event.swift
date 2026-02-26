//
//  Event.swift
//  Local Meet
//
//  Created by Глеб Поляков on 13.02.2026.
//

import Foundation

struct Event: Equatable {
  let id: UUID
  let title: String
  let description: String
  let date: Date
  let createdAt: Date
  let ownerId: UUID  
}

extension Event {
  nonisolated static var mock: Event {
    Event(id: UUID(uuidString: "9ea4da85-e9c7-4285-9742-32fa672234d2")!,
          title: "Встреча_1",
          description: "Описание встречи",
          date: .now,
          createdAt: .distantFuture,
          ownerId: UUID(uuidString: "7e0a0b48-ceb2-44c1-9f14-4f5a3f520f64")!)
  }
  
  nonisolated static func mock(
    id: UUID = UUID(),
    title: String = "Test",
    description: String = "Desc",
    date: Date = Date(),
    createdAt: Date = Date(),
    ownerId: UUID = UUID()
  ) -> Event {
    Event(id: id,
          title: title,
          description: description,
          date: date,
          createdAt: createdAt,
          ownerId: ownerId)
  }
  
  nonisolated func copy(
    title: String? = nil,
    description: String? = nil,
    date: Date? = nil,
    createdAt: Date? = nil,
    ownerId: UUID? = nil
  ) -> Event {
    Event(id: self.id,
          title: title ?? self.title,
          description: description ?? self.description,
          date: date ?? self.date,
          createdAt: createdAt ?? self.createdAt,
          ownerId: ownerId ?? self.ownerId)
  }
}
