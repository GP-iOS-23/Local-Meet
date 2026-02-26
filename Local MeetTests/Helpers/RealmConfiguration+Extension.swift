//
//  RealmConfiguration+Extension.swift
//  Local MeetTests
//
//  Created by Глеб Поляков on 18.02.2026.
//

import RealmSwift
import Foundation

extension Realm.Configuration {
  static func inMemoryTestConfiguration() -> Realm.Configuration {
    Realm.Configuration(inMemoryIdentifier: UUID().uuidString)
  }
}
