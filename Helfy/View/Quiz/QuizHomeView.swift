//
//  QuizView.swift
//  Helfy
//
//  Created by 윤성은 on 2023/12/19.
//

import UIKit

class QuizHomeView: UIView {
    var scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 점수 : "
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.sizeToFit()
        return label
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.text = "님"
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let exLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘은 어떤 퀴즈를 풀어볼까요?"
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    let todayButton: UIButton = createButton(withTitle: "오늘의 퀴즈")
    let quizButton: UIButton = createButton(withTitle: "퀴즈 풀어보기")
    let wrongButton: UIButton = createButton(withTitle: "오답 다시 풀어보기")

    static func createButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        button.backgroundColor = UIColor(hexString:"#F9DF56")
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.black, for:.normal)
        
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 330).isActive = true

        return button
    }

    override init(frame:CGRect) {
        super.init(frame:frame)
       
        let containerView: UIView = {
            let containerView = UIView()
            containerView.backgroundColor = UIColor(hexString:"#F9DF56")
            containerView.addSubview(scoreLabel)
            containerView.addSubview(idLabel)
            containerView.addSubview(exLabel)
            return containerView
        }()
        
        let buttonStack: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.distribution = .fill
            stackView.spacing = 20
            return stackView
        }()
        
        self.backgroundColor = UIColor.white

        buttonStack.addArrangedSubview(todayButton)
        buttonStack.addArrangedSubview(quizButton)
        buttonStack.addArrangedSubview(wrongButton)

        addSubview(containerView)
        addSubview(buttonStack)

        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        exLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            scoreLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50),
            scoreLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            idLabel.topAnchor.constraint(equalTo: scoreLabel.topAnchor, constant: 70),
            idLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            exLabel.topAnchor.constraint(equalTo: idLabel.topAnchor, constant: 30),
            exLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            containerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            buttonStack.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 50),
            buttonStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            buttonStack.widthAnchor.constraint(equalToConstant: 330),
//            buttonStack.heightAnchor.constraint(equalToConstant: 200),
//            buttonStack.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8),
//            buttonStack.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4)

        ])
    }

    required init?(coder aDecoder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
