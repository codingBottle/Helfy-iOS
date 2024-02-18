//
//  Qtest.swift
//  Helfy
//
//  Created by 윤성은 on 1/17/24.
//

//import UIKit
//
//enum QuizType {
//    case MULTIPLE_CHOICE
//    case OX
//}
//
//class QuizView: UIView {
//    var quizType: QuizType
//    var newChoice = Choices(additionalProp1: "", additionalProp2: "", additionalProp3: "")
//    var arr: [String] = []
//    
//    var choiceButtons: [UIButton] = []
//    var trueButton: UIButton = UIButton()
//    var falseButton: UIButton = UIButton()
//    
//    init(frame: CGRect, quizType: QuizType) {
//        self.quizType = quizType
//        super.init(frame: frame)
//        setLayout()
//        setUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // 텍스트
//    let quizText: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.numberOfLines = 0
//        label.font = .boldSystemFont(ofSize: 22)
//        label.textAlignment = .center
//        return label
//    }()
//    
//    // 이미지
//    let quizImage: UIImageView = {
//        let image: UIImageView = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        image.contentMode = .scaleAspectFit
//        return image
//    }()
//    
//    func setLayout() {
//        self.addSubview(quizImage)
//        self.addSubview(quizText)
//        
//        quizImage.translatesAutoresizingMaskIntoConstraints = false
//        quizText.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            quizText.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
//            quizText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            
//            quizImage.topAnchor.constraint(equalTo: quizText.bottomAnchor, constant: 50),
//            quizImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//        ])
//    }
//
//    func setUI() {
//        switch quizType {
//        case .MULTIPLE_CHOICE:
//            var choiceButtons: [UIButton] = []
//            
//            let buttonStackView: UIStackView = {
//                let buttonStack = UIStackView()
//                buttonStack.axis = .vertical
//                buttonStack.distribution = .fillEqually
//                buttonStack.spacing = 10
//                buttonStack.translatesAutoresizingMaskIntoConstraints = false
//
//                return buttonStack
//            }()
//
//            self.addSubview(buttonStackView)
//
//            // Use newChoice data for buttons
//            let testChoices = ["1", "2", "3", "4"]
//
//            // Create buttons based on testChoices
//            for choice in testChoices {
//                let button = UIButton()
//                button.setTitle(choice, for: .normal)
//                button.setTitleColor(.black, for: .normal)
//                button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
//                button.layer.cornerRadius = 20
//                button.backgroundColor = UIColor(hexString: "#F9DF56")
//
//                buttonStackView.addArrangedSubview(button)
//                choiceButtons.append(button)
//            }
//
//            buttonStackView.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                buttonStackView.topAnchor.constraint(equalTo: quizText.bottomAnchor, constant: 50),
//                buttonStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//                buttonStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//                buttonStackView.widthAnchor.constraint(equalToConstant: 350),
//                buttonStackView.heightAnchor.constraint(equalToConstant: 220)
//            ])
//
//            break
//
//        case .OX:
//            // O/X 선택지 버튼 생성
//            trueButton = UIButton()
//            trueButton.setTitle("O", for: .normal)
//            trueButton.titleLabel?.font = .systemFont(ofSize: 50)
//            trueButton.backgroundColor = UIColor(hexString: "#F9DF56")
//            trueButton.layer.cornerRadius = 20
//            trueButton.tag = 1
//            
//            falseButton = UIButton()
//            falseButton.setTitle("X", for: .normal)
//            falseButton.titleLabel?.font = .systemFont(ofSize: 50)
//            falseButton.backgroundColor = UIColor(hexString: "#F9A456")
//            falseButton.layer.cornerRadius = 20
//            falseButton.tag = 0
//            
//            self.addSubview(trueButton)
//            self.addSubview(falseButton)
//            
//            // AutoLayout 설정
//            trueButton.translatesAutoresizingMaskIntoConstraints = false
//            falseButton.translatesAutoresizingMaskIntoConstraints = false
//            
//            NSLayoutConstraint.activate([
//                trueButton.topAnchor.constraint(equalTo: quizText.bottomAnchor, constant: 50),
//                trueButton.heightAnchor.constraint(equalToConstant: 200),
//                trueButton.widthAnchor.constraint(equalToConstant: 130),
//                trueButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//                trueButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
//                
//                falseButton.topAnchor.constraint(equalTo: quizText.bottomAnchor, constant: 50),
//                falseButton.leadingAnchor.constraint(equalTo: trueButton.trailingAnchor, constant: 30),
//                falseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//                falseButton.heightAnchor.constraint(equalToConstant: 200),
//                falseButton.widthAnchor.constraint(equalToConstant: 130)
//            ])
//            break
//        }
//    }
//}
