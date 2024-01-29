//
//  QuizViewController.swift
//  Helfy
//
//  Created by 윤성은 on 2023/10/06.

import UIKit

class QuizHomeViewController: UIViewController {
    let quizHomeView = QuizHomeView()
    var apiHandler : APIHandler = APIHandler()
    var quizHomeModelData: QuizHomeModel? {
        didSet {
            print("Hi")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        view.addSubview(quizHomeView)
  
        quizHomeView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            quizHomeView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            quizHomeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            quizHomeView.topAnchor.constraint(equalTo: view.topAnchor),
            quizHomeView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        quizHomeView.todayButton.addTarget(self, action:#selector(openTodayQuiz), for:.touchUpInside)
        quizHomeView.quizButton.addTarget(self, action:#selector(openDoQuiz), for:.touchUpInside)
        quizHomeView.wrongButton.addTarget(self, action:#selector(openWrongQuiz), for:.touchUpInside)
    }
    
    func setData() {
        DispatchQueue.global(qos: .userInteractive).async {
                    
            // API 통해 데이터 불러오기
            self.apiHandler.getQuizHomeData() { [self] data in
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


    // 버튼 링크 연결
    @objc func openTodayQuiz() {
        print("오늘의 퀴즈!")
        
        // TodayQuizViewController 인스턴스 생성
        let todayQuizVC = TodayQuizViewController()
        
        // 화면 전환 애니메이션 설정 (옵션)
        todayQuizVC.modalTransitionStyle = .crossDissolve
        
        // 화면 전환 방식 설정 (옵션)
        todayQuizVC.modalPresentationStyle = .fullScreen
        
        // 화면 전환
        self.present(todayQuizVC, animated: true, completion: nil)
    }


    @objc func openDoQuiz() {
        print("퀴즈 풀어보기!")
        
        // TodayQuizViewController 인스턴스 생성
        let doQuizVC = DoQuizViewController()
        
        // 화면 전환 애니메이션 설정 (옵션)
        doQuizVC.modalTransitionStyle = .crossDissolve
        
        // 화면 전환 방식 설정 (옵션)
        doQuizVC.modalPresentationStyle = .fullScreen
        
        // 화면 전환
        self.present(doQuizVC, animated: true, completion: nil)
    }

  @objc func openWrongQuiz() {
      print("오답 다시 풀어보기")
      
      // TodayQuizViewController 인스턴스 생성
      let wrongQuizVC = WrongQuizViewController()
      
      // 화면 전환 애니메이션 설정 (옵션)
      wrongQuizVC.modalTransitionStyle = .crossDissolve
      
      // 화면 전환 방식 설정 (옵션)
      wrongQuizVC.modalPresentationStyle = .fullScreen
      
      // 화면 전환
      self.present(wrongQuizVC, animated: true, completion: nil)
  }
}
