//
//  QuizView.swift
//  Helfy
//
//  Created by 윤성은 on 2023/12/19.
//

import UIKit

class QuizView: UIView {
    let scoreLabel: UILabel = {
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
    
//    func configure(with model: QuizModel) {
//       scoreLabel.text = "나의 점수 : \(model.score)"
//       idLabel.text = "\(model.uid)님"
//   }
    
    let todayButton: UIButton = createButton(withTitle: "오늘의 퀴즈")
    let quizButton: UIButton = createButton(withTitle: "퀴즈 풀어보기")
    let wrongButton: UIButton = createButton(withTitle: "오답 다시 풀어보기")

    static func createButton(withTitle title: String) -> UIButton {
        // 버튼 생성 메소드
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22) // 폰트 사이즈 수정
        button.backgroundColor = UIColor(hexString:"#F9DF56")
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.black, for:.normal)
        
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 300).isActive = true

        return button
    }

    override init(frame:CGRect) {
        super.init(frame:frame)
        
        let scoreStackView = UIStackView()
        scoreStackView.addArrangedSubview(scoreLabel)
        scoreStackView.axis = .horizontal
        scoreStackView.alignment = .trailing
        scoreStackView.distribution = .fill
        scoreStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
        scoreStackView.isLayoutMarginsRelativeArrangement = true

        let idStackView = UIStackView()
        idStackView.addArrangedSubview(idLabel)
        idStackView.alignment = .leading
        idStackView.distribution = .fill
        idStackView.layoutMargins = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 0)
        idStackView.isLayoutMarginsRelativeArrangement = true
       
        let exStackView = UIStackView()
        exStackView.addArrangedSubview(exLabel)
        exStackView.alignment = .leading
        exStackView.distribution = .fill
        exStackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        exStackView.isLayoutMarginsRelativeArrangement = true
       
        let labelStack = UIStackView(arrangedSubviews: [idStackView, exStackView])
        labelStack.axis = .vertical
        labelStack.alignment = .leading
        labelStack.distribution = .fillEqually
        labelStack.spacing = 5
       
        let containerStack = UIStackView(arrangedSubviews: [scoreStackView, labelStack])
        containerStack.axis = .vertical
        containerStack.distribution = .fillEqually
        containerStack.spacing = 20 // scoreLabel과 labelStack 사이 간격 20 설정
        containerStack.backgroundColor = UIColor(hexString:"#F9DF56")
        
        // UIStackView를 생성
        let buttonStack: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .center
            stackView.spacing = 20
            return stackView
        }()
        
        self.backgroundColor = UIColor.white
                
        labelStack.addArrangedSubview(idStackView)
        labelStack.addArrangedSubview(exStackView)

        containerStack.addArrangedSubview(scoreStackView)
        containerStack.addArrangedSubview(labelStack)

        buttonStack.addArrangedSubview(todayButton)
        buttonStack.addArrangedSubview(quizButton)
        buttonStack.addArrangedSubview(wrongButton)

        addSubview(containerStack)
        addSubview(buttonStack)
        
        scoreStackView.translatesAutoresizingMaskIntoConstraints = false
        idStackView.translatesAutoresizingMaskIntoConstraints = false
        exStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            containerStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerStack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerStack.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
//            scoreStackView.trailingAnchor.constraint(equalTo: containerStack.trailingAnchor, constant: -50),
//            idStackView.leadingAnchor.constraint(equalTo: containerStack.leadingAnchor, constant: 50),
//            exStackView.leadingAnchor.constraint(equalTo: containerStack.leadingAnchor, constant: 20),
            
            buttonStack.topAnchor.constraint(equalTo: containerStack.bottomAnchor, constant: 20),
            buttonStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonStack.widthAnchor.constraint(equalToConstant: 300),
        ])
    }


    required init?(coder aDecoder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
