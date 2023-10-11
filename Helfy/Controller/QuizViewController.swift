//
//  QuizViewController.swift
//  Helfy
//
//  Created by 윤성은 on 2023/10/06.

import UIKit

class QuizViewController: UIViewController, UITabBarDelegate {
    
    private var quizView = QuizView()
    private var rankingView = RankingView()

    private lazy var segmentControl : UISegmentedControl = {
        let control = UISegmentedControl(items: ["퀴즈", "랭킹"])
        
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        
        control.backgroundColor = .white
//        control.selectedSegmentTintColor = UIColor.clear

        
        // 세그먼트의 텍스트 속성 변경
        let attributesNormal = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.black]
            
        control.setTitleTextAttributes(attributesNormal, for:.normal)
        
        // 모서리 라운딩 제거
       control.layer.cornerRadius = 0.0
       control.layer.masksToBounds = true

       return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(segmentControl)
        self.view.addSubview(quizView)
        self.view.addSubview(rankingView)
        
        setupConstraints()
    }

    @objc func segmentChanged(_ sender:UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            quizView.isHidden = false;
            rankingView.isHidden = true;
        case 1:
            quizView.isHidden = true;
            rankingView.isHidden = false;
        default:
            break;
        }
    }
    
    private func setupConstraints() {
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        quizView.translatesAutoresizingMaskIntoConstraints = false
        rankingView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            segmentControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            segmentControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            quizView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor),
            quizView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            quizView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            quizView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            rankingView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor),
            rankingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            rankingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            rankingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        rankingView.isHidden = true
    }

}
