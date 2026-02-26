//
//  AppEnvironment.swift
//  Local Meet
//
//  Created by Глеб Поляков on 13.02.2026.
//
import Foundation

enum AppEnvironment {
  nonisolated static var baseURL: String {
    Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String ?? ""
  }
  
  nonisolated static var supabaseKey: String {
    Bundle.main.object(forInfoDictionaryKey: "SUPABASE_KEY") as? String ?? ""
  }
}
