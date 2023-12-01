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

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        // 셀의 높이를 계산합니다. 여기서는 임의로 100을 사용했습니다.
        let cellHeight: CGFloat = 100
        // 셀이 세로로 3개 들어가려면, 셀 높이 * 3 + 위아래 스페이싱 * 2 만큼의 높이가 필요합니다.
        let collectionViewHeight = cellHeight * 3 + layout.minimumLineSpacing * 2
        categoryView = CategoryView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: collectionViewHeight), collectionViewLayout: layout)
        
        categoryView.dataSource = categoryView
        categoryView.delegate = categoryView

        self.view.addSubview(categoryView)
        view.backgroundColor = .white

        setupUI()
    }

    private func setupUI() {
        categoryView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
