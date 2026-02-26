//
//  EventLocalDataSource.swift
//  Local Meet
//
//  Created by Глеб Поляков on 18.02.2026.
//

import RealmSwift

protocol EventLocalDataSource {
  func save(events: [Event]) async throws
  func fetchEvents() async throws -> [Event]
  func deleteAll() async throws
}

final class EventLocalDataSourceImpl: EventLocalDataSource {
  private let realm: Realm
  
  init(configuration: Realm.Configuration = .defaultConfiguration) throws {
    self.realm = try Realm(configuration: configuration)
  }
  
  func save(events: [Event]) async throws {
    let objects = events.map(EventRealmMapper.toLocal)
    
    try realm.write {
      realm.add(objects, update: .modified)
    }
  }
  
  func fetchEvents() async throws -> [Event] {
    let objects = realm.objects(EventObject.self)
    return objects.map(EventRealmMapper.toDomain)
  }
  
  func deleteAll() async throws {
    try realm.write {
      realm.delete(realm.objects(EventObject.self))
    }
  }
}
