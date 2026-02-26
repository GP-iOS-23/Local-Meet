//
//  Message.swift
//  Local Meet
//
//  Created by Глеб Поляков on 13.02.2026.
//

import Foundation

struct Message {
  let id: UUID
  let userId: UUID
  let text: String
  let createdAt: Date
  
  enum CodingKeys: String, CodingKey {
    case id, text
    case userID = "user_id"
    case createdAt = "created_at"
  }
}
