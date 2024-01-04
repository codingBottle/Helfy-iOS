//
//  QuestionViewController.swift
//  Helfy
//
//  Created by 윤성은 on 11/22/23.
//

import UIKit

class QuestionViewController: UIViewController {
    var questionView: QuestionView!
    var choiceView: ChoiceView!
    var currentQuestionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let text = "지진이 났을 때, 하지말아야할 행동으로 운동장으로 뛰어간다는 맞을까요~ 틀릴까요~? 태풍이 오고 있을 때 창문에 테이프를 엑스로 붙여야할까요 세로나 가로로 붙여야할까요~?"
//        let imageUrlString = ""
        let image: UIImage? = UIImage(systemName: "square.and.arrow.up")
//        let data: [String: Any] = ["text": "Sample Question", "choices": ["맞다, 엑스", "틀리다, 엑스", "맞다, 세로나 가로", "틀리다, 세로나 가로"], "answerIndex": 1, "image": image]
//        let type: QuestionType = .MultipleQuestion

        let data: [String: Any] = ["text": "Sample Question", "answer": true, "image": image]

        let type: QuestionType = .TrueOrFalseQuestion

        addChoiceView(data: data, type: type)

        if let image = UIImage(systemName: "square.and.arrow.up") {
            addQuestionView(text: text, image: image)
        } else {
            // 이미지 로드 중 에러가 발생한 경우
            print("이미지 로드 에러")
        }
        
//        if let imageUrl = URL(string: imageUrlString) {
//            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
//                if let error = error {
//                    print("Error downloading image: \(error)")
//                } else if let data = data {
//                    DispatchQueue.main.async {
//                        self.addQuestionView(text: text, image: UIImage(data: data))
//                    }
//                }
//            }.resume()
//        }
    }
    
    func addChoiceView(data: [String: Any], type: QuestionType) {
        // 객관식
        if type == .MultipleQuestion {
            let multipleChoiceView = MultipleChoiceView(question: MultipleChoiceQuestion.dictionaryMultiple(data: data))
            choiceView = multipleChoiceView
            choiceView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(choiceView)
            NSLayoutConstraint.activate([
                choiceView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                choiceView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                choiceView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                choiceView.heightAnchor.constraint(equalToConstant: 270)
            ])
            choiceView.display()
            for button in multipleChoiceView.choiceButtons {
                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            }
        } else {
            // true or false
            choiceView = TrueOrFalseQuestionView(question: TrueOrFalseQuestion.dictionaryTrueOrFalse(data: data))
            choiceView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(choiceView)
            NSLayoutConstraint.activate([
                choiceView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                choiceView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                choiceView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                choiceView.heightAnchor.constraint(equalToConstant: 250)
            ])

            choiceView.display()
            if let trueOrFalseView = choiceView as? TrueOrFalseQuestionView {
                trueOrFalseView.trueButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                trueOrFalseView.falseButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            }
        }
    }
    
    func addQuestionView(text: String, image: UIImage?) {
        questionView = QuestionView(text: text, image: nil)
        questionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(questionView)
        
        // QuestionView에 대한 제약 조건 설정
        NSLayoutConstraint.activate([
            questionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            questionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            questionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            questionView.bottomAnchor.constraint(equalTo: choiceView.topAnchor, constant: -10),
        ])
    }

    @objc func buttonTapped(_ sender: UIButton) {
        // 사용자의 선택 저장
        let userChoice = sender.tag // 각 버튼에 고유한 태그를 부여하여 구분

        // 답안 체크
        let isCorrect = checkAnswer(userChoice: userChoice)

        // 답안에 따른 버튼 색상 변경
        if isCorrect == true {
            sender.backgroundColor = UIColor.systemGreen
        } else {
            sender.backgroundColor = UIColor.red
        }
        // 정답이 맞으면 다음 문제 로드
        loadNextQuestion()
    }
    
    func checkAnswer(userChoice: Int) -> Bool {
        // MultipleChoiceQuestion 타입의 경우
        if let multipleChoiceView = choiceView as? MultipleChoiceView {
            let correctAnswer = multipleChoiceView.question.answerIndex
            return userChoice == correctAnswer // 여기를 수정하였습니다.
        }
        // TrueOrFalseQuestion 타입의 경우
        else if let trueOrFalseView = choiceView as? TrueOrFalseQuestionView {
            let correctAnswer = trueOrFalseView.question.answer
            return userChoice == (correctAnswer ? 1 : 0)
        }
        // 위의 경우가 아닌 경우
        else {
            return false
        }
    }
    
    func loadNextQuestion() {
        
    }

}
