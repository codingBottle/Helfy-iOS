//
//  QuestionModel.swift
//  Helfy
//
//  Created by 윤성은 on 11/22/23.
//

import UIKit

class QuestionTestModel {
    var text: String
    var image: UIImage?
    
    init(text: String, image: UIImage? = nil) {
        self.text = text
        self.image = image
    }
}

class MultipleChoiceQuiz: QuestionTestModel {
    var choices: [String]
    var answerIndex: Int
    
    init(text: String, choices: [String], answerIndex: Int, image: UIImage? = nil) {
        self.choices = choices
        self.answerIndex = answerIndex
        super.init(text: text, image: image)
    }
    
    static func dictionaryMultiple(data: [String: Any]) -> MultipleChoiceQuiz {
        let text = data["text"] as! String
        let choices = data["choices"] as! [String]
        let answerIndex = data["answerIndex"] as! Int
        let image = data["image"] as? UIImage
        return MultipleChoiceQuiz(text: text, choices: choices, answerIndex: answerIndex, image: image)
    }
}

class TrueOrFalseQuestion: QuestionTestModel {
    var answer: Bool
    
    init(text: String, answer: Bool, image: UIImage? = nil) {
        self.answer = answer
        super.init(text: text, image: image)
    }
    
    static func dictionaryTrueOrFalse(data: [String: Any]) -> TrueOrFalseQuestion {
        let text = data["text"] as! String
        let answer = data["answer"] as! Bool
        let image = data["image"] as? UIImage
        return TrueOrFalseQuestion(text: text, answer: answer, image: image)
    }
}

