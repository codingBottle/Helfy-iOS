//
//  QuizModel.swift
//  Helfy
//
//  Created by 윤성은 on 2/19/24.
//

import Foundation

// MARK: - WelcomeElement
struct QuizModel: Codable {
    let id: Int
    let question, answer: String
    let choices: [String: String]
    let image: Image?
    let quizType: String
}

// MARK: - Image
struct QuizImage: Codable {
    let id: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
    }
}

typealias Quiz = [QuizModel]
