//
//  QuestionView.swift
//  Helfy
//
//  Created by 윤성은 on 11/22/23.
//

import UIKit

enum QuizType: String {
    case MULTIPLE_CHOICE = "MULTIPLE_CHOICE"
    case OX = "OX"
}

class QuizView: UIView {
    var quizType: QuizType {
        didSet {
            print("QuizType didSet")
            
            update(quizType)
        }
    }
    
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
        image.clipsToBounds = true
        return image
    }()
    
    init(frame: CGRect, quizType: QuizType) {
        self.quizType = quizType
        self.buttonStackView = UIStackView()
        super.init(frame: frame)
        update(quizType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var didSelectChoice: ((String) -> Void)?
    
    @objc func buttonClicked(_ button: UIButton) {
        guard let choice = button.titleLabel?.text else {
            return
        }
        
        didSelectChoice?(choice)
    }
    
    func update(_ quizType: QuizType) {
        for button in choiceButtons {
            button.removeFromSuperview()
        }
        choiceButtons.removeAll()
        
        trueButton.removeFromSuperview()
        falseButton.removeFromSuperview()
        
        setUpLayout()
        
        switch quizType {
        case .MULTIPLE_CHOICE:
            buttonStackView.axis = .vertical
            buttonStackView.spacing = 10
            buttonStackView.distribution = .fillEqually
            
            guard let newChoice = newChoice else {
                return
            }
            
            for (key, choice) in newChoice {
                let button = UIButton()
                button.setTitle(choice, for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
                button.titleLabel?.numberOfLines = 0  // 여러 줄로 표시하도록 설정
                button.titleLabel?.lineBreakMode = .byWordWrapping  // 단어 단위로 줄바꿈
                button.layer.cornerRadius = 20
                button.backgroundColor = UIColor(hexString: "#F9DF56")
                button.tag = Int(key) ?? 0
                button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
                button.contentEdgeInsets = UIEdgeInsets(top: 3, left: 2, bottom: 3, right: 2)

                buttonStackView.addArrangedSubview(button)
                choiceButtons.append(button)
            }

        case .OX:
            buttonStackView.axis = .horizontal
            buttonStackView.spacing = 13
            buttonStackView.distribution = .fillEqually
            
            trueButton = UIButton()
            trueButton.setTitle("O", for: .normal)
            trueButton.titleLabel?.font = .systemFont(ofSize: 50)
            trueButton.backgroundColor = UIColor(hexString: "#F9DF56")
            trueButton.layer.cornerRadius = 20
            trueButton.tag = 1
            trueButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            
            falseButton = UIButton()
            falseButton.setTitle("X", for: .normal)
            falseButton.titleLabel?.font = .systemFont(ofSize: 50)
            falseButton.backgroundColor = UIColor(hexString: "#F9A456")
            falseButton.layer.cornerRadius = 20
            falseButton.tag = 0
            falseButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
            
            buttonStackView.addArrangedSubview(trueButton)
            buttonStackView.addArrangedSubview(falseButton)
        }
    }
    
    var quizTextTopConstraint: NSLayoutConstraint?
    
    func setUpLayout() {
        addSubview(quizNumber)
        addSubview(quizText)
        addSubview(quizImage)
        addSubview(buttonStackView)
        
        quizNumber.translatesAutoresizingMaskIntoConstraints = false
        quizText.translatesAutoresizingMaskIntoConstraints = false
        quizImage.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            quizNumber.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            quizNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            
            quizText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            quizText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            quizText.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            quizImage.topAnchor.constraint(equalTo: quizText.bottomAnchor, constant: 50),
            quizImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            quizImage.widthAnchor.constraint(equalToConstant: 250),
            quizImage.heightAnchor.constraint(equalToConstant: 200),
            
            buttonStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            buttonStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 250),
            buttonStackView.widthAnchor.constraint(equalToConstant: 350)
        ])
        
        updateImageLayout()
    }
    
    func updateImageLayout() {
        if quizImage.image == nil {
            quizImage.isHidden = true
            quizTextTopConstraint?.isActive = false
            quizTextTopConstraint = quizText.topAnchor.constraint(equalTo: quizNumber.bottomAnchor, constant: 150)
            quizTextTopConstraint?.isActive = true
        } else {
            quizImage.isHidden = false
            quizTextTopConstraint?.isActive = false
            quizTextTopConstraint = quizText.topAnchor.constraint(equalTo: quizNumber.bottomAnchor, constant: 50)
            quizTextTopConstraint?.isActive = true
        }
        self.layoutIfNeeded()
    }
}
