//
//  EventsAPI.swift
//  Local Meet
//
//  Created by Глеб Поляков on 13.02.2026.
//
import Foundation
import Alamofire
import Moya

enum EventAPI {
  case fetchEvents
}

extension EventAPI: TargetType {
  nonisolated var baseURL: URL { URL(string: AppEnvironment.baseURL)! }
  
  nonisolated var path: String {
    switch self {
    case .fetchEvents:
      return "/rest/v1/events"
    }
  }
  
  nonisolated var method: Moya.Method {
    switch self {
    case .fetchEvents:
      return .get
    }
  }
  
  nonisolated var task: Task {
    switch self {
    case .fetchEvents:
      return .requestParameters(parameters: ["select": "*"], encoding: URLEncoding.queryString)
    }
  }
  
  nonisolated var headers: [String: String]? {
    ["apikey": AppEnvironment.supabaseKey,
     "Content-Type": "application/json"]
  }
}
