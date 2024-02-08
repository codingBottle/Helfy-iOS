//
//  CategoryViewController.swift
//  Helfy
//
//  Created by 윤성은 on 11/30/23.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "카테고리"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
//        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)  // 추가된 부분
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(CategoryCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()

    
    var pageController: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .darkGray
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
        view.addSubview(pageController)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        pageController.addTarget(self, action: #selector(handlePageControl(_:)), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            pageController.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            pageController.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageController.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            pageController.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }
    
    @objc func handlePageControl(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        let x = CGFloat(currentPage) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/collectionView.frame.width)
        pageController.currentPage = Int(pageIndex)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 선택된 카테고리 가져오기
        let selectedCategory = Category.allCases[indexPath.row]
        print("Selected category: \(selectedCategory.rawValue)")
        
        
        // 카테고리 정보 뷰 컨트롤러 생성
        //        let categoryVC = CategoryPageViewController()
        //
        //        // 카테고리 정보 뷰 컨트롤러에 선택된 카테고리 설정
        //        categoryVC.category = selectedCategory
        //
        //        // 카테고리 정보 뷰 컨트롤러 표시
        //        navigationController?.pushViewController(categoryVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let totalCells = buttonImages.count
        let remainder = totalCells % 9
        return totalCells + (remainder > 0 ? (9 - remainder) : 0) // 빈 셀 추가
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell
        if indexPath.row < buttonImages.count {
            cell.categoryView.buttonImageView.image = buttonImages[indexPath.row]
            cell.categoryView.buttonLabel.text = buttonTitles[indexPath.row]
        } else {
            cell.categoryView.buttonImageView.image = nil
            cell.categoryView.buttonLabel.text = nil
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            let totalSpacing = layout.minimumInteritemSpacing * 4
//            let width = (collectionView.frame.width - totalSpacing) / 3
//            let height = (collectionView.frame.height - totalSpacing) / 3
//
//            let height: CGFloat = 100 // 셀 높이를 원하는 값으로 고정
//            return CGSize(width: width, height: height)
//        }
    
        let width = collectionView.frame.width / 3
        let height = collectionView.frame.height / 3
        return CGSize(width: width, height: height)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let padding: CGFloat = 30 * 2
//        let sectionInsets: CGFloat = 10 * 2
//        let cellCount: CGFloat = 3
//        let width = (collectionView.frame.width - padding - sectionInsets) / cellCount
//        let height = (collectionView.frame.height - sectionInsets) / 3
//        return CGSize(width: width, height: height)
//    }


}
