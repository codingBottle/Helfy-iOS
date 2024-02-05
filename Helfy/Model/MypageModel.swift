//
//  MypageModel.swift
//  Helfy
//
//  Created by 윤성은 on 11/8/23.
//

import Foundation

// MARK: - Welcome
struct MypageModel: Codable {
    let userInfo: UserInfo
    let rankInfo: RankInfo
}

// MARK: - RankInfo
struct RankInfo: Codable {
    let rank, score: Int
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let region, nickname: String
}
