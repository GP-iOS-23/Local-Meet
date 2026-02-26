//
//  EventRealmMapper.swift
//  Local Meet
//
//  Created by Глеб Поляков on 18.02.2026.
//

import Foundation

struct EventRealmMapper {
  static func toLocal(_ event: Event) -> EventObject {
    EventObject(from: event)
  }
  
  static func toDomain(_ object: EventObject) -> Event {
    Event(id: object.id,
          title: object.title,
          description: object.descriptionText ?? "",
          date: object.date,
          createdAt: object.createdAt,
          ownerId: object.ownerId)
  }
}
