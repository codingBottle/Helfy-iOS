//
//  QuizViewController.swift
//  Helfy
//
//  Created by 윤성은 on 2023/10/06.

import UIKit

class QuizHomeViewController: UIViewController {
    let quizHomeView = QuizHomeView()
    var quizApiHandler : QuizAPIHandler = QuizAPIHandler()
    let quizViewController = QuizViewController()
    var quizHomeModelData: QuizHomeModel? {
        didSet {
            print("Hi")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        
//        if let tabBarViewController = parent as? TabBarViewController {
//                print(tabBarViewController.selectedIndex)
//            }

        view.addSubview(quizHomeView)
        
        quizHomeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            quizHomeView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            quizHomeView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            quizHomeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            quizHomeView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        quizHomeView.todayButton.addTarget(self, action:#selector(openTodayQuiz), for:.touchUpInside)
        quizHomeView.quizButton.addTarget(self, action:#selector(openDoQuiz), for:.touchUpInside)
        quizHomeView.wrongButton.addTarget(self, action:#selector(openWrongQuiz), for:.touchUpInside)
    }
    
    func setData() {
        DispatchQueue.global(qos: .userInteractive).async {
            
            // API 통해 데이터 불러오기
            self.quizApiHandler.getQuizHomeData() { [self] data in
                // 정의해둔 모델 객체에 할당
                self.quizHomeModelData = data
                
                // 데이터를 제대로 잘 받아왔다면
                guard let data = self.quizHomeModelData else {
                    
                    return print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
                }
                
                DispatchQueue.main.async {
                    self.quizHomeView.idLabel.text = data.nickname + " 님"
                    self.quizHomeView.scoreLabel.text = "나의 점수 : " + String(data.score)
                }
            }
        }
    }
    
    @objc func openTodayQuiz() {
        print("오늘의 퀴즈!")
        let todayQuizVC = TodayQuizViewController()
        todayQuizVC.modalTransitionStyle = .crossDissolve
        todayQuizVC.modalPresentationStyle = .fullScreen
        self.present(todayQuizVC, animated: true, completion: nil)
    }
    
    @objc func openDoQuiz() {
        print("퀴즈 풀어보기!")
        
        let doQuizVC = DoQuizViewController()
        doQuizVC.modalTransitionStyle = .crossDissolve
        doQuizVC.modalPresentationStyle = .fullScreen
        self.present(doQuizVC, animated: true, completion: nil)
    }
    
    @objc func openWrongQuiz() {
        print("오답 다시 풀어보기")
        
        let wrongQuizVC = WrongQuizViewController()
        wrongQuizVC.modalTransitionStyle = .crossDissolve
        wrongQuizVC.modalPresentationStyle = .fullScreen
        self.present(wrongQuizVC, animated: true, completion: nil)
    }
}
