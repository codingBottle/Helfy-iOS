//
//  MultipleChoiceView.swift
//  Helfy
//
//  Created by 윤성은 on 11/23/23.
//
// 객관식

import UIKit

class MultipleChoiceView: ChoiceView {
    var choiceButtons: [UIButton] = []
    var question: MultipleChoiceQuestion
    
    init(question: MultipleChoiceQuestion) {
        self.question = question
        super.init(frame: .zero)
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func display() {
        let buttonStackView = UIStackView()
        buttonStackView.axis = .vertical
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonStackView)
        
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        // 객관식 선택지 버튼 생성
        for index in 0..<4 {
            let button = UIButton()
            button.setTitle(question.choices[index], for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = 20
            button.backgroundColor = UIColor(hexString: "#F9DF56")
            button.tag = index

            buttonStackView.addArrangedSubview(button)
            choiceButtons.append(button)
        }
        
        // AutoLayout 설정
        for button in choiceButtons {
            button.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
                button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
                button.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
}
