//
//  CategoryPageModel.swift
//  Helfy
//
//  Created by YEOMI on 12/1/23.
//

import Foundation

// MARK: - Helfy
struct CategoryPageModel: Codable {
    let id: Int
    let category, content, newsURL, youtubeURL: String
    let image: Image

    enum CodingKeys: String, CodingKey {
        case id, category, content
        case newsURL = "news_url"
        case youtubeURL = "youtube_url"
        case image
    }
}

// MARK: - Image
struct Image: Codable {
    let id: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
    }
}
