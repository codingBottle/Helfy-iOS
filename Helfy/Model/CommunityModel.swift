//
//  CommunityModel.swift
//  Helfy
//
//  Created by YEOMI on 12/18/23.
//

import Foundation

//GET
struct GetPost: Codable {
    let page, size: Int
    let sort: [String]
}

struct GetPostResponse: Codable {
    let totalPages, totalElements, size: Int
    let content: [PostContent]
    let number: Int
    let sort: PostSort
    let pageable: PostPageable
    let numberOfElements: Int
    let first, last, empty: Bool
}

struct PostContent: Codable {
    let id: Int
    let content, writerNickname: String
    let image: PostImage
    let likeCount: Int
    let likeStatus: Bool
    let createdTime, modifiedTime: String
}

struct PostImage: Codable {
    let id: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
    }
}

struct PostPageable: Codable {
    let offset: Int
    let sort: PostSort
    let unpaged: Bool
    let pageNumber: Int
    let paged: Bool
    let pageSize: Int
}

struct PostSort: Codable {
    let empty, unsorted, sorted: Bool
}

//POST
struct CreatePost: Codable {
    let title, content, hashTag: String
    let imageName: String

    enum CodingKeys: String, CodingKey {
        case title, content, hashTag
        case imageName
    }
}

struct CreatePostResponse: Codable {
    let id: Int
    let content, writerNickname: String
    let image: Image
    let likeCount: Int
    let likeStatus: Bool
    let createdTime, modifiedTime: String
}

struct Image: Codable {
    let id: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
    }
}

//DELETE
struct DeletePost: Codable {
    let id: Int
}

//PATCH
struct UpdatePost: Codable {
    let content: String
    let imageID: Int

    enum CodingKeys: String, CodingKey {
        case content
        case imageID = "imageId"
    }
}

struct UpdatedPost: Codable {
    let id: Int
    let content, writerNickname: String
    let image: Image
    let likeCount: Int
    let likeStatus: Bool
    let createdTime, modifiedTime: String
}

//LIKE
struct LikePosts: Codable {
    let id: Int
}

