//
//  TrueOrFalseQuestionView.swift
//  Helfy
//
//  Created by 윤성은 on 11/23/23.
//
// O/X

import UIKit

class TrueOrFalseQuestionView: ChoiceView {
    var question: TrueOrFalseQuestion

    var trueButton: UIButton!
    var falseButton: UIButton!

    init(question: TrueOrFalseQuestion) {
        self.question = question
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func display() {
        
        // O/X 선택지 버튼 생성
        trueButton = UIButton()
        trueButton.setTitle("O", for: .normal)
        trueButton.titleLabel?.font = .systemFont(ofSize: 50)
        trueButton.backgroundColor = UIColor(hexString: "#F9DF56")
        trueButton.layer.cornerRadius = 20
        trueButton.tag = 1

        falseButton = UIButton()
        falseButton.setTitle("X", for: .normal)
        falseButton.titleLabel?.font = .systemFont(ofSize: 50)
        falseButton.backgroundColor = UIColor(hexString: "#F9A456")
        falseButton.layer.cornerRadius = 20
        falseButton.tag = 0

        addSubview(trueButton)
        addSubview(falseButton)

        // AutoLayout 설정
        trueButton.translatesAutoresizingMaskIntoConstraints = false
        falseButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            trueButton.heightAnchor.constraint(equalToConstant: 200),
            trueButton.widthAnchor.constraint(equalToConstant: 130),
            trueButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            trueButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            
            falseButton.leadingAnchor.constraint(equalTo: trueButton.trailingAnchor, constant: 30),
            falseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            falseButton.heightAnchor.constraint(equalToConstant: 200),
            falseButton.widthAnchor.constraint(equalToConstant: 130)
        ])
    }
}

