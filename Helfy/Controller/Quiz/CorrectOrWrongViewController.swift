//
//  CorrectOrWrongViewController.swift
//  Helfy
//
//  Created by 윤성은 on 2/19/24.
//

import UIKit

enum AnswerType {
    case correct
    case wrong
}

class CorrectOrWrongViewController: UIViewController {
    var answerType: AnswerType
    var id: String
    
    let iconLabel = UILabel()
    
    init(answerType: AnswerType, id: String) {
        self.answerType = answerType
        self.id = id
        super.init(nibName: nil, bundle: nil)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUI() {
        iconLabel.textAlignment = .center
        iconLabel.font = UIFont.systemFont(ofSize: 100)
        
        switch answerType {
        case .correct:
            iconLabel.text = "⭕️"
        case .wrong:
            iconLabel.text = "❌"
        }
        
        view.addSubview(iconLabel)
        
        // 레이아웃 설정
        iconLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
