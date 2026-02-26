//
//  EventDTO.swift
//  Local Meet
//
//  Created by Глеб Поляков on 17.02.2026.
//

import Foundation

struct EventDTO: Codable {
  let id: UUID
  let title: String
  let description: String
  let date: Date
  let createdAt: Date
  let ownerId: UUID
  
  enum CodingKeys: String, CodingKey {
    case id, title, description, date
    case createdAt = "created_at"
    case ownerId = "owner_id"
  }
}

extension EventDTO {
  static var mock: EventDTO {
    EventDTO(id: UUID(uuidString: "8F9E5A77-9D88-4D1E-9F01-B8B1F1234567")!,
             title: "Встреча 1",
             description: "Описание встречи",
             date: Date.now,
             createdAt: Date.now,
             ownerId: UUID(uuidString: "9A8B7C66-1234-4D1E-ABCD-1234567890AB")!)
  }
}
