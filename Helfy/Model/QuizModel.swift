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
    let question, answer, quizType: String
    let choices: Choices
    let image: Image
}

// MARK: - Choices
struct Choices: Codable {
    let additionalProp1, additionalProp2, additionalProp3: String
}

// MARK: - Image
struct Image: Codable {
    let createdTime, modifiedTime: String
    let id: Int
    let imageURL, directory, convertImageName: String

    enum CodingKeys: String, CodingKey {
        case createdTime, modifiedTime, id
        case imageURL = "imageUrl"
        case directory, convertImageName
    }
}

typealias Quiz = [QuizModel]
