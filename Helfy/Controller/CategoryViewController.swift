//
//  CategoryViewController.swift
//  Helfy
//
//  Created by 윤성은 on 11/30/23.
//

import UIKit

class CategoryViewController: UIViewController {
    var categoryView: CategoryView!
    
    let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 3 // 총 페이지 수 설정
        pc.currentPage = 0 // 현재 페이지 설정
        pc.pageIndicatorTintColor = .gray
        pc.currentPageIndicatorTintColor = .black
        return pc
    }()
    
    @objc func handlePageControl(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        let indexPath = IndexPath(item: currentPage * 9, section: 0)
        categoryView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        categoryView = CategoryView(frame: .zero, collectionViewLayout: layout)
        categoryView.isPagingEnabled = true
        categoryView.dataSource = categoryView
        categoryView.delegate = self

        self.view.addSubview(categoryView)
        view.addSubview(pageControl)
        view.backgroundColor = .white

        setupUI()
        
        pageControl.addTarget(self, action: #selector(handlePageControl), for: .valueChanged)

    }

    private func setupUI() {
        categoryView.translatesAutoresizingMaskIntoConstraints = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        // Calculate the height of the collectionView
        let cellHeight = view.frame.width / 3
        let collectionViewHeight = cellHeight * 3

        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryView.heightAnchor.constraint(equalToConstant: collectionViewHeight),
            categoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            pageControl.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: 10),
//            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension CategoryViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3
//        let height: CGFloat = 100 // 높이를 100으로 변경
        return CGSize(width: width, height: width)
    }


    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = Category.allCases[indexPath.item]
        print("\(selectedCategory.rawValue) was tapped!")

        // CategoryPage 뷰 컨트롤러를 생성합니다.
//         let categoryPageViewController = CategoryPageViewController(category: selectedCategory.rawValue)
        
        // UINavigationController를 생성하고, rootViewController로 categoryPageViewController를 설정합니다.
//        let navController = UINavigationController(rootViewController: categoryPageViewController)

        // 생성한 UINavigationController를 모달로 표시합니다.
//        self.present(navController, animated: true, completion: nil)
    }
}

extension CategoryViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}
