//
//  EventObject.swift
//  Local Meet
//
//  Created by Глеб Поляков on 18.02.2026.
//

import Foundation
import RealmSwift

final class EventObject: Object, Sendable {
  @Persisted(primaryKey: true) var id: UUID
  @Persisted var title: String = ""
  @Persisted var descriptionText: String?
  @Persisted var date: Date = Date()
  @Persisted var createdAt: Date = Date()
  @Persisted var ownerId: UUID
}

extension EventObject {
  convenience init(from domain: Event) {
    self.init()
    self.id = domain.id
    self.title = domain.title
    self.descriptionText = domain.description
    self.date = domain.date
    self.createdAt = domain.createdAt
    self.ownerId = domain.ownerId
  }
}
