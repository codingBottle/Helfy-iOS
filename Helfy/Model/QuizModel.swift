//
//  QuizModel.swift
//  Helfy
//
//  Created by 윤성은 on 12/27/23.
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
struct Image: Codable {
    let id: Int
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
    }
}

typealias Quiz = [QuizModel]
