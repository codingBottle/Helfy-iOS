//
//  CategoryViewController.swift
//  Helfy
//
//  Created by 윤성은 on 11/30/23.
//

import UIKit

class CategoryViewController: UIViewController {
    var categoryView: CategoryView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // categoryView 생성
        categoryView = CategoryView(frame: view.bounds)
        view.addSubview(categoryView)
        view.backgroundColor = .white
        
//        // 버튼 기능 추가
//        categoryView.buttonTappedHandler = { buttonTitle in
//            // 버튼이 탭되었을 때의 동작 구현
//            print("\(buttonTitle) 버튼이 탭되었습니다.")
//        }
    }
}
