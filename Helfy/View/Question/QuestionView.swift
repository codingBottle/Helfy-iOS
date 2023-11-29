//
//  QuestionView.swift
//  Helfy
//
//  Created by 윤성은 on 11/22/23.
//

import UIKit

enum QuestionType {
    case MultipleQuestion
    case TrueOrFalseQuestion
}

class QuestionView: UIView {
    var text: String
    var image: UIImage?
    
    init(text: String, image: UIImage? = nil) {
        self.text = text
        self.image = image
        super.init(frame: .zero)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 텍스트
    let questionText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        return label
    }()
    
    // 이미지
    let questionImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    func setLayout() {
        addSubview(questionImage)
        addSubview(questionText)
        
        questionImage.image = self.image
        questionText.text = self.text
         
        // 이미지가 있을 때
        if self.image != nil {
            NSLayoutConstraint.activate([
                questionImage.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
                questionImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                questionImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
                questionImage.heightAnchor.constraint(equalToConstant: 200)
            ])
            
            NSLayoutConstraint.activate([
                questionText.topAnchor.constraint(equalTo: questionImage.bottomAnchor, constant: 20),
                questionText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                questionText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                questionText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                questionText.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        }
        // 이미지가 없을 때
        else {
            NSLayoutConstraint.activate([
                questionText.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
                questionText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                questionText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                questionText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                questionText.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        }
    }
}
