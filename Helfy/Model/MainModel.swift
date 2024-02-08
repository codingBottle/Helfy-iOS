//
//  MainModel.swift
//  Helfy
//
//  Created by 윤성은 on 2/5/24.
//

import Foundation

// MARK: - Welcome
struct MainModel: Codable {
    let userInfo: IdInfo
    let weatherInfo: WeatherInfo
}

// MARK: - UserInfo
struct IdInfo: Codable {
    let id: Int
    let nickname: String
}

// MARK: - WeatherInfo
struct WeatherInfo: Codable {
    let weatherCode: String
    let temp: Double
    let humidity: Int
}
