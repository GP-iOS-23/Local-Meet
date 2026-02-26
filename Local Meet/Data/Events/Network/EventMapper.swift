//
//  EventMapper.swift
//  Local Meet
//
//  Created by Глеб Поляков on 17.02.2026.
//

import Foundation

struct EventMapper {
  static func toDomain(_ dto: EventDTO) -> Event {
    Event(id: dto.id,
          title: dto.title,
          description: dto.description,
          date: dto.date,
          createdAt: dto.createdAt,
          ownerId: dto.ownerId)
  }
}
