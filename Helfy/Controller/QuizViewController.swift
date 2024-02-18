//
//  QuestionViewController.swift
//  Helfy
//
//  Created by 윤성은 on 11/22/23.
//

import UIKit

class QuizViewController: UIViewController {
//    lazy var quizView = QuizView(frame: .zero, quizType: self.convertedQuizType ?? .OX)
    var quizView: QuizView!
    // 총 문제수
    var totalQuiz: Int = 0
    // 현재 문제 번호
    var currentQuizNumber: Int = 1
    
    var quizType = ""
    var apiHandler: APIHandler = APIHandler()
    lazy var answer: String = ""
    
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

        // QuizView를 뷰 계층에 추가
        self.view.addSubview(quizView)
        
        quizView.didSelectChoice = { [weak self] choice in
            self?.handleChoiceSelection(choice)
        }
        
        // QuizView의 AutoLayout 설정
        quizView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quizView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            quizView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            quizView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            quizView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        setData()
    }
    
    func updateQuestionNumberDisplay(current: Int, total: Int) {
        quizView.quizNumber.text = "\(current) / \(total)"
    }
    
    func handleChoiceSelection(_ choice: String) {
        let answerType: AnswerType = choice == answer ? .correct : .wrong
        showResultModal(answerType: answerType)
    }
    
    func showResultModal(answerType: AnswerType) {
        let vc = CorrectOrWrongViewController(answerType: answerType)
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                vc.dismiss(animated: true) {
                    self.loadNextQuestion()
                }
            }
        }
    }

    func loadNextQuestion() {
        if currentQuizNumber < totalQuiz {
            setData()
            currentQuizNumber += 1
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func setData() {
        DispatchQueue.global(qos: .userInteractive).async {
            // API 통해 데이터 불러오기
            self.apiHandler.getQuizData(type: "TODAY") { data in
                // 정의해둔 모델 객체에 할당
                self.quizModelData = data
                
                // 데이터를 제대로 잘 받아왔다면
                guard let data = self.quizModelData, !data.isEmpty else {
                    return print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
                }
                
                // 총 문제 수를 계산합니다.
                self.totalQuiz = data.count
                
                DispatchQueue.main.async { [self] in
                    self.quizType = data[0].quizType ?? ""
                    print("QuizType: \(self.quizType)") // 디버깅을 위한 출력
                    
                    self.updateQuestionNumberDisplay(current: currentQuizNumber, total: totalQuiz)

                    
                    self.quizView.quizText.text = data[0].question
                    print("Quiz Text: \(self.quizView.quizText.text ?? "")")
                    
                    // 새로운 인스턴스 생성
//                    let newChoice = Choices(
//                        choice1: data[0].choices?.choice1,
//                        choice2: data[0].choices?.choice2,
//                        choice3: data[0].choices?.choice3,
//                        choice4: data[0].choices?.choice4
//                    )
                    
                    self.quizView.newChoice = data[0].choices
                    print("newChoice: \(self.quizView.newChoice)")

                    // 새로운 인스턴스 할당
//                    self.quizView.newChoice = newChoice
                    
//                    print("Quiz Choices: \(self.quizView.newChoice)")

                    self.answer = data[0].answer ?? ""
                    self.quizView.updateMultipleChoiceUI(with: data[0].choices)
                    
                    // 이미지 로드
                    if let imageURLString = data[0].image?.imageURL, let url = URL(string: imageURLString) {
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
                    }
                }
            }
        }
    }
}




//class QuestionViewController: UIViewController {
//    var questionView: QuizView!
//    var choiceView: ChoiceView!
//    var currentQuestionIndex = 0
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        
//        let text = "지진이 났을 때, 하지말아야할 행동으로 운동장으로 뛰어간다는 맞을까요~ 틀릴까요~? 태풍이 오고 있을 때 창문에 테이프를 엑스로 붙여야할까요 세로나 가로로 붙여야할까요~?"
//        let imageUrlString = ""
//        let image: UIImage? = UIImage(systemName: "square.and.arrow.up")
//        let data: [String: Any] = ["text": "Sample Question", "choices": ["맞다, 엑스", "틀리다, 엑스", "맞다, 세로나 가로", "틀리다, 세로나 가로"], "answerIndex": 1, "image": image]
//        let type: QuestionType = .MultipleQuestion
//
//        let data: [String: Any] = ["text": "Sample Question", "answer": true, "image": image]
//
//        let type: QuestionType = .TrueOrFalseQuestion
//
//        addChoiceView(data: data, type: type)
//
//        if let image = UIImage(systemName: "square.and.arrow.up") {
//            addQuestionView(text: text, image: image)
//        } else {
//            // 이미지 로드 중 에러가 발생한 경우
//            print("이미지 로드 에러")
//        }
//        
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
//    }
//    
//    func addChoiceView(data: [String: Any], type: QuestionType) {
//        // 객관식
//        if type == .MultipleQuestion {
//            let multipleChoiceView = MultipleChoiceView(question: MultipleChoiceQuestion.dictionaryMultiple(data: data))
//            choiceView = multipleChoiceView
//            choiceView.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(choiceView)
//            NSLayoutConstraint.activate([
//                choiceView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
//                choiceView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//                choiceView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//                choiceView.heightAnchor.constraint(equalToConstant: 270)
//            ])
//            choiceView.display()
//            for button in multipleChoiceView.choiceButtons {
//                button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//            }
//        } else {
//            // true or false
//            choiceView = TrueOrFalseQuestionView(question: TrueOrFalseQuestion.dictionaryTrueOrFalse(data: data))
//            choiceView.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview(choiceView)
//            NSLayoutConstraint.activate([
//                choiceView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
//                choiceView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//                choiceView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//                choiceView.heightAnchor.constraint(equalToConstant: 250)
//            ])
//
//            choiceView.display()
//            if let trueOrFalseView = choiceView as? TrueOrFalseQuestionView {
//                trueOrFalseView.trueButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//                trueOrFalseView.falseButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//            }
//        }
//    }
//    
//    func addQuestionView(text: String, image: UIImage?) {
//        questionView = QuizView(text: text, image: nil)
//        questionView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(questionView)
//        
//        // QuestionView에 대한 제약 조건 설정
//        NSLayoutConstraint.activate([
//            questionView.topAnchor.constraint(equalTo: self.view.topAnchor),
//            questionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            questionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            questionView.bottomAnchor.constraint(equalTo: choiceView.topAnchor, constant: -10),
//        ])
//    }
//
//    @objc func buttonTapped(_ sender: UIButton) {
//        // 사용자의 선택 저장
//        let userChoice = sender.tag // 각 버튼에 고유한 태그를 부여하여 구분
//
//        // 답안 체크
//        let isCorrect = checkAnswer(userChoice: userChoice)
//
//        // 답안에 따른 버튼 색상 변경
//        if isCorrect == true {
//            sender.backgroundColor = UIColor.systemGreen
//        } else {
//            sender.backgroundColor = UIColor.red
//        }
//        // 정답이 맞으면 다음 문제 로드
//        loadNextQuestion()
//    }
//    
//    func checkAnswer(userChoice: Int) -> Bool {
//        // MultipleChoiceQuestion 타입의 경우
//        if let multipleChoiceView = choiceView as? MultipleChoiceView {
//            let correctAnswer = multipleChoiceView.question.answerIndex
//            return userChoice == correctAnswer // 여기를 수정하였습니다.
//        }
//        // TrueOrFalseQuestion 타입의 경우
//        else if let trueOrFalseView = choiceView as? TrueOrFalseQuestionView {
//            let correctAnswer = trueOrFalseView.question.answer
//            return userChoice == (correctAnswer ? 1 : 0)
//        }
//        // 위의 경우가 아닌 경우
//        else {
//            return false
//        }
//    }
//    
//    func loadNextQuestion() {
//        
//    }
//
//}
