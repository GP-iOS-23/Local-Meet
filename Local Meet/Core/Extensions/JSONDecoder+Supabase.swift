//
//  JSONDecoder+Supabase.swift
//  Local Meet
//
//  Created by Глеб Поляков on 17.02.2026.
//

import Foundation

extension JSONDecoder {
  static let supabase: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .custom { decoder in
      let container = try decoder.singleValueContainer()
      let dateString = try container.decode(String.self)
      
      let formatter = ISO8601DateFormatter()
      formatter.formatOptions = [.withInternetDateTime]
      if let date = formatter.date(from: dateString) {
        return date
      }
      
      if let date = ISO8601DateFormatter().date(from: dateString) {
        return date
      }
      
      throw DecodingError.dataCorruptedError(
        in: container,
        debugDescription: "Не удалось распарсить дату: \(dateString)"
      )
    }
    
    return decoder
  }()
}
