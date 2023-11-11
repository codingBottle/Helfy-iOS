//
//  TabBarViewController.swift
//  Helfy
//
//  Created by 윤성은 on 10/28/23.
//

import UIKit

class TabBarViewController: UIViewController {
    let tabBarView = BottomTabBarView(tabItems: [.quiz, .home, .community])
    let tabBarViewController = UITabBarController()

    let quizViewController = QuizViewController()
    let homeViewController = HomeViewController()
    let communityViewController = CommunityViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarViewController.viewControllers = [quizViewController, homeViewController, communityViewController]
        tabBarViewController.selectedIndex = 1 // '홈' 버튼을 초기 선택 항목으로 설정

        tabBarView.onTabSelected = { [weak self] index in
            self?.tabBarViewController.selectedIndex = index
        }

        addChild(tabBarViewController)
        view.addSubview(tabBarViewController.view)
        tabBarViewController.didMove(toParent: self)

        tabBarViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tabBarViewController.view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tabBarViewController.view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tabBarViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabBarViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        view.addSubview(tabBarView)

        tabBarView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tabBarView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tabBarView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: 56),
            tabBarView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
        ])
    }

}
