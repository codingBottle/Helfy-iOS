//
//  WrongQuizViewController.swift
//  Helfy
//
//  Created by 윤성은 on 1/4/24.
//

import UIKit

class WrongQuizViewController: UIViewController {
    let quizVC = QuizViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(quizVC)
        view.addSubview(quizVC.view)
        quizVC.didMove(toParent: self)
        
        quizVC.setData(quizCategory: "WRONG")
        quizVC.quizCategory = "WRONG"

        quizVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            quizVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            quizVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            quizVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            quizVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    
}
