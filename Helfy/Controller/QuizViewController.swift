//
//  QuizViewController.swift
//  Helfy
//
//  Created by 윤성은 on 2023/10/06.

import UIKit

class QuizViewController: UIViewController {
    private var quizView = QuizView()
    private var rankingView = RankingView()
    
    private lazy var quizButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("퀴즈", for: .normal)
        button.tintColor = UIColor.orange
        button.titleLabel?.font = UIFont.systemFont(ofSize: 23) // Set font size here
        button.addTarget(self, action: #selector(quizButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var rankingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("랭킹", for: .normal)
        button.tintColor = UIColor.black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        button.addTarget(self, action: #selector(rankingButtonTapped), for: .touchUpInside)
        return button
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        view.addSubview(quizView)
        view.addSubview(rankingView)
        
        view.addSubview(quizButton)
        view.addSubview(rankingButton)
        
        quizButton.translatesAutoresizingMaskIntoConstraints = false
        rankingButton.translatesAutoresizingMaskIntoConstraints = false
        
        quizView.translatesAutoresizingMaskIntoConstraints = false
        rankingView.translatesAutoresizingMaskIntoConstraints = false
        
        // 버튼 레이아웃
        NSLayoutConstraint.activate([
            quizButton.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant : 15),
            quizButton.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant : 20),
            
            rankingButton.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant : 15),
            rankingButton.leadingAnchor.constraint(equalTo : self.quizButton.trailingAnchor, constant : 15),
        ])
        
        rankingView.isHidden = true
    }
    
    // 퀴즈 버튼 눌렀을 때 동작
    @objc func quizButtonTapped() {
        print("Quiz Button Tapped")

        quizView.isHidden = false
        rankingView.isHidden = true
         
        self.quizButton.tintColor = UIColor.orange
        self.rankingButton.tintColor = UIColor.black

    }

    // 랭킹 버튼 눌렀을 때 동작
    @objc func rankingButtonTapped() {
        print("Ranking Button Tapped")

        quizView.isHidden = true
        rankingView.isHidden = false

        self.quizButton.tintColor = UIColor.black
        self.rankingButton.tintColor = UIColor.orange
    }
}
