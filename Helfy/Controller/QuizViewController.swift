//
//  QuizViewController.swift
//  Helfy
//
//  Created by 윤성은 on 2023/10/06.

import UIKit

class QuizViewController: UIViewController {
    private var quizView = QuizView()
    private var rankingView = RankingView()
    private var categoryView = CategoryView()
    
    private var quizButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("퀴즈", for: .normal)
        button.tintColor = UIColor.orange // Set initial color to black
        button.addTarget(self, action: #selector(quizButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var rankingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("랭킹", for: .normal)
        button.tintColor = UIColor.black // Set initial color to black
        button.addTarget(self, action: #selector(rankingButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // ... (rest of your class) ...
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white


      // Add the buttons to the view hierarchy.
      view.addSubview(quizButton)
      view.addSubview(rankingButton)

       // Add the views to the view hierarchy.
       view.addSubview(quizView)
       view.addSubview(rankingView)

       quizView.addSubview(categoryView)

         // Set up constraints...
        quizButton.translatesAutoresizingMaskIntoConstraints = false
        rankingButton.translatesAutoresizingMaskIntoConstraints = false
        
         // Setup constraints for quiz and ranking views
       quizView.translatesAutoresizingMaskIntoConstraints = false
       rankingView.translatesAutoresizingMaskIntoConstraints = false

         // Layout for buttons
        NSLayoutConstraint.activate([
            quizButton.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            quizButton.leadingAnchor.constraint(equalTo:view.leadingAnchor, constant : 15),
                
            rankingButton.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            rankingButton.leadingAnchor.constraint(equalTo : self.quizButton.trailingAnchor, constant : 15),
         ])
         
        let guide = self.view.safeAreaLayoutGuide
            
        NSLayoutConstraint.activate([
            quizView.topAnchor.constraint(equalTo:self.quizButton.bottomAnchor, constant: 100),
            quizView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor),
            quizView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor),

//            categoryView.topAnchor.constraint(equalTo:self.quizView.bottomAnchor, constant: 100),
//            categoryView.leadingAnchor.constraint(equalTo:self.view.leadingAnchor),
//            categoryView.trailingAnchor.constraint(equalTo:self.view.trailingAnchor)

        ])

            // Initially hide the Ranking View.
            rankingView.isHidden = true
      }

     @objc func quizButtonTapped() {
         print("Quiz Button Tapped")

        // Show the Quiz View and hide the Ranking View.
         quizView.isHidden = false
         rankingView.isHidden = true
         
         self.quizButton.tintColor = UIColor.orange
         self.rankingButton.tintColor = UIColor.black

    }

    @objc func rankingButtonTapped() {
        print("Ranking Button Tapped")

        // Show the Ranking View and hide the Quiz View.
        quizView.isHidden = true
        rankingView.isHidden = false

        self.quizButton.tintColor = UIColor.black
        self.rankingButton.tintColor = UIColor.orange
    }
}
