//
//  TabBarViewController.swift
//  Helfy
//
//  Created by 윤성은 on 10/28/23.
//

import UIKit

enum TabItem: Int, CaseIterable {
    case quiz
    case home
    case category

    var normalImage: UIImage? {
        switch self {
        case .quiz:
            return UIImage(systemName: "gamecontroller")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        case .home:
            return UIImage(systemName: "house")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        case .category:
            return UIImage(systemName: "bubble.left.and.text.bubble.right")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        }
    }

    var selectedImage: UIImage? {
        switch self {
        case .quiz:
            return UIImage(systemName: "gamecontroller.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        case .home:
            return UIImage(systemName: "house.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        case .category:
            return UIImage(systemName: "bubble.left.and.text.bubble.right.fill")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        }
    }
}

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    private var tabItems: [TabItem] = TabItem.allCases
    let HEIGHT_TAB_BAR:CGFloat = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setUp()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = HEIGHT_TAB_BAR
        tabFrame.origin.y = self.view.frame.size.height - HEIGHT_TAB_BAR
        self.tabBar.frame = tabFrame
    }

    private func setUp() {
        view.backgroundColor = UIColor.white
        tabBar.backgroundColor = UIColor(hexString: "#F9DF56")

        let tabViewControllers: [UIViewController] = [
            UINavigationController(rootViewController: QuizHomeViewController()),
            UINavigationController(rootViewController: MainViewController()),
            UINavigationController(rootViewController: CategoryViewController())
        ]
        
        tabItems.enumerated().forEach { i, item in
            let viewController = tabViewControllers[i]
            viewController.tabBarItem = UITabBarItem(
                title: nil,
                image: item.normalImage,
                selectedImage: item.selectedImage
            )
            viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: -20, right: 0)
        }
        
        self.viewControllers = tabViewControllers
        self.selectedIndex = 1
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarController.tabBar.isHidden = false
        updateTabBarItemImages()
    }

    private func updateTabBarItemImages() {
        guard let items = tabBar.items else { return }

        items.enumerated().forEach { index, item in
            let tabItem = tabItems[index]
            if index == selectedIndex {
                item.image = tabItem.selectedImage
            } else {
                item.image = tabItem.normalImage
            }
        }
    }
}
