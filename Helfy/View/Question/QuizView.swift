//
//  QuestionView.swift
//  Helfy
//
//  Created by 윤성은 on 11/22/23.
//

import UIKit

enum QuizType {
    case MULTIPLE_CHOICE
    case OX
}

class QuizView: UIView {
    var quizType: QuizType {
        didSet {
            print("QuizType didSet")

            update()
        }
    }
//    var newChoice = Choices(choice1: "", choice2: "", choice3: "", choice4: "")
    var newChoice: [String: String]?
    var arr: [String] = []

    var buttonStackView: UIStackView
    var choiceButtons: [UIButton] = []
    var trueButton: UIButton = UIButton()
    var falseButton: UIButton = UIButton()
    
    let quizNumber: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        return label
    }()
    
    // 텍스트 및 이미지 설정
    let quizText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        return label
    }()

    let quizImage: UIImageView = {
        let image: UIImageView = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    init(frame: CGRect, quizType: QuizType) {
        self.quizType = quizType
        self.buttonStackView = UIStackView()
        super.init(frame: frame)
        update()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var didSelectChoice: ((String) -> Void)?

    @objc func buttonClicked(_ button: UIButton) {
        guard let choice = button.titleLabel?.text else {
            return
        }

        // 버튼 클릭 이벤트를 외부로 알리는 클로저 호출
        didSelectChoice?(choice)
    }

    private func setLayout() {
        print("setLayout method is called")

        self.addSubview(quizNumber)
        self.addSubview(quizImage)
        self.addSubview(quizText)
        
        quizNumber.translatesAutoresizingMaskIntoConstraints = false
        quizImage.translatesAutoresizingMaskIntoConstraints = false
        quizText.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            quizNumber.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            quizNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            
            quizImage.topAnchor.constraint(equalTo: quizNumber.bottomAnchor, constant: 50),
            quizImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            quizImage.widthAnchor.constraint(equalToConstant: 300),
            quizImage.heightAnchor.constraint(equalToConstant: 100),
            
            quizText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            quizText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            quizText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
        ])
    }

    func updateImageLayout() {
        if let _ = quizImage.image {
            // 이미지가 있을 때의 레이아웃 설정
            NSLayoutConstraint.activate([
                quizText.topAnchor.constraint(equalTo: self.quizImage.bottomAnchor, constant: 20),
            ])
        } else {
            // 이미지가 없을 때의 레이아웃 설정
            NSLayoutConstraint.activate([
                quizText.topAnchor.constraint(equalTo: self.quizNumber.bottomAnchor, constant: 100),
            ])
        }
    }
    
    private func update() {
        // 먼저 모든 버튼을 제거
        for button in choiceButtons {
            button.removeFromSuperview()
        }
        choiceButtons.removeAll()

        trueButton.removeFromSuperview()
        falseButton.removeFromSuperview()

        setLayout()

        switch quizType {
        case .MULTIPLE_CHOICE:
            buttonStackView = {
                let buttonStack = UIStackView()
                buttonStack.axis = .vertical
                buttonStack.distribution = .fillEqually
                buttonStack.spacing = 10

                return buttonStack
            }()

            self.addSubview(buttonStackView)

            buttonStackView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                buttonStackView.topAnchor.constraint(equalTo: quizText.bottomAnchor, constant: 50),
                buttonStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                buttonStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                buttonStackView.widthAnchor.constraint(equalToConstant: 300),
                buttonStackView.heightAnchor.constraint(equalToConstant: 220)
            ])
            
            updateMultipleChoiceUI(with: self.newChoice)

            break
            
        case .OX:
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
            
            self.addSubview(trueButton)
            self.addSubview(falseButton)
            
            trueButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            falseButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            
            // AutoLayout 설정
            trueButton.translatesAutoresizingMaskIntoConstraints = false
            falseButton.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                trueButton.topAnchor.constraint(equalTo: quizText.bottomAnchor, constant: 70),
                trueButton.heightAnchor.constraint(equalToConstant: 150),
                trueButton.widthAnchor.constraint(equalToConstant: 100),
                trueButton.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -15),

                falseButton.topAnchor.constraint(equalTo: quizText.bottomAnchor, constant: 70),
                falseButton.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 15),
                falseButton.heightAnchor.constraint(equalToConstant: 150),
                falseButton.widthAnchor.constraint(equalToConstant: 100),

                trueButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                falseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])


            break
        }
    }

    func updateMultipleChoiceUI(with choices: [String: String]?) {
        if let unwrappedChoices = choices {
            arr = Array(unwrappedChoices.values)
        } else {
            print("choices is nil")
        }
        guard let choices = choices else {
            return
        }

        // 기존의 버튼들을 제거
        for button in choiceButtons {
            button.removeFromSuperview()
        }
        choiceButtons.removeAll()

        // 새로운 선택지로 버튼을 생성하여 스택뷰에 추가
        for (key, choice) in choices {
            let button = UIButton()
            button.setTitle(choice, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            button.layer.cornerRadius = 20
            button.backgroundColor = UIColor(hexString: "#F9DF56")
            button.tag = Int(key) ?? 0
            button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)

            buttonStackView.addArrangedSubview(button)
            choiceButtons.append(button)
        }
    }
}
