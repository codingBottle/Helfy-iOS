//
//  QuizViewController.swift
//  Helfy
//
//  Created by 윤성은 on 2023/10/06.

import UIKit

class QuizViewController: UIViewController {
    let quizView = QuizView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(quizView)
        
        quizView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            quizView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            quizView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            quizView.topAnchor.constraint(equalTo: view.topAnchor),
            quizView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        quizView.todayButton.addTarget(self, action:#selector(openTodayQuiz), for:.touchUpInside)
        quizView.quizButton.addTarget(self, action:#selector(openDoQuiz), for:.touchUpInside)
        quizView.wrongButton.addTarget(self, action:#selector(openWrongQuiz), for:.touchUpInside)
   }

    
   // 버튼 링크 연결
   @objc func openTodayQuiz() {
       print("오늘의 퀴즈!")
   }

  @objc func openDoQuiz() {
     print("퀴즈 풀어보기!")
  }

  @objc func openWrongQuiz() {
      print("오답 다시 풀어보기")
  }
}
