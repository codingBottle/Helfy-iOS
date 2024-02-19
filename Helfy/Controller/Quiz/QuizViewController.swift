//
//  QuizViewController.swift
//  Helfy
//
//  Created by 윤성은 on 2/19/24.
//

import UIKit

class QuizViewController: UIViewController {
    var quizView: QuizView!
    var totalQuiz: Int = 0
    var currentQuizNumber: Int = 1
    var currentQuiz: QuizModel?
    
    var quizType = ""
    var quizApiHandler: QuizAPIHandler = QuizAPIHandler()
    lazy var answer: String = ""
    var quizCategory: String = ""
    
    var convertedQuizType: QuizType? {
        switch quizType {
        case "MULTIPLE_CHOICE":
            return .MULTIPLE_CHOICE
        case "OX":
            return .OX
        default:
            return nil
        }
    }
    
    var quizModelData: Quiz? {
        didSet {
            print("Hi")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        quizView = QuizView(frame: .zero, quizType: self.convertedQuizType ?? .MULTIPLE_CHOICE)
        
        self.view.addSubview(quizView)
        
        quizView.didSelectChoice = { [weak self] choice in
            self?.handleChoiceSelection(choice)
        }
        
        quizView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            quizView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            quizView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            quizView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            quizView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            guard let data = self.quizModelData else { return }
            let currentQuiz = data[self.currentQuizNumber - 1] // 현재 퀴즈 가져오기
            print("\(currentQuiz)")

            let quizTypeString = currentQuiz.quizType
            if quizTypeString.isEmpty {
                print("Quiz type is empty")
                return
            }
            guard let quizType = QuizType(rawValue: quizTypeString) else {
                print("Invalid quiz type")
                return
            }

            self.updateQuestionNumberDisplay(current: self.currentQuizNumber, total: self.totalQuiz)
            self.quizView.quizText.text = currentQuiz.question
            print("\(self.quizView.quizText)")

            self.quizView.newChoice = currentQuiz.choices
            self.answer = currentQuiz.answer ?? ""
            self.quizView.update(quizType)
            print("quizType : \(quizType)")

            // 이미지 로드
            if let imageURLString = currentQuiz.image?.imageURL, let url = URL(string: imageURLString) {
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    if let error = error {
                        print("Error: \(error)")
                    } else if let data = data {
                        DispatchQueue.main.async {
                            self.quizView.quizImage.image = UIImage(data: data)
                            self.quizView.updateImageLayout()  // 이미지 로드 후 이미지 레이아웃 업데이트
                        }
                    }
                }
                task.resume()
            } else {
                // 이미지가 없는 경우
                DispatchQueue.main.async {
                    self.quizView.quizImage.image = nil
                    self.quizView.updateImageLayout()  // 이미지 레이아웃 업데이트
                }
            }
        }
    }
    
    func setData(quizCategory: String) {
        DispatchQueue.global(qos: .userInteractive).async {
            //만약 첫 문제를 불러온 이후라면, API를 호출하지 않고 불러온 데이터에서 다음 문제를 로드합니다.
            if self.quizModelData != nil {
                self.updateUI()
            } else {
                self.quizApiHandler.getQuizData(type: quizCategory) { data in
                    self.quizModelData = data
                    self.totalQuiz = data.count
                    self.updateUI()
                }
            }
        }
    }
    
    func validateQuizCategory(_ category: String) -> Bool {
        let validCategories = ["TODAY", "NORMAL", "WRONG"]
        return validCategories.contains(category)
    }
    
    func updateQuestionNumberDisplay(current: Int, total: Int) {
        quizView.quizNumber.text = "\(current) / \(total)"
    }
    
    func handleChoiceSelection(_ choice: String) {
        guard let currentQuiz = quizModelData?[currentQuizNumber - 1] else { return }
        let answerType: AnswerType = choice == currentQuiz.answer ? .correct : .wrong
        
        if answerType == .wrong {
            print("Wrong answer, quiz id : \(currentQuiz.id)")
        } else {
            print("⭕️⭕️⭕️⭕️⭕️ : \(currentQuiz.id)")
        }
        
        showResultModal(answerType: answerType, quizID: String(currentQuiz.id), currentQuiz: currentQuiz)
    }
    
    func showResultModal(answerType: AnswerType, quizID: String, currentQuiz: QuizModel) {
        let vc = CorrectOrWrongViewController(answerType: answerType, id: quizID)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                vc.dismiss(animated: true) {
                    if answerType == .wrong {
                        self.quizApiHandler.sendWrongAnswerStatus(id: String(currentQuiz.id), answerType: answerType) { _ in }
                    }
                    self.loadNextQuestion()
                }
            }
        }
    }
    
    func loadNextQuestion() {
        if currentQuizNumber < totalQuiz {
            currentQuizNumber += 1
            updateUI()
        } else {
            self.dismiss(animated: true, completion: nil)
            var quizHomeViewController: QuizHomeViewController = QuizHomeViewController()
            quizHomeViewController.setData()
        }
    }
}
