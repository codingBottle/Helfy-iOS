//
//  MainModel.swift
//  Helfy
//
//  Created by 윤성은 on 2/5/24.
//

import Foundation

// MARK: - Welcome
struct MainModel: Codable {
    let weatherCode: String
    let temp: Double
    let humidity: Int
}
