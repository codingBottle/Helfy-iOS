//
//  CategoryViewController.swift
//  Helfy
//
//  Created by 윤성은 on 11/30/23.
//

import UIKit

class CategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var categoryView: CategoryView?
    let categoryApiHandler = CategoryAPIHandler()
    let categoryPageViewController = CategoryPageViewController()
    let categoryPageApiHandler = CategoryPageAPIHandler()
    
    var categoryModelData: CategoryModel? {
        didSet {
            print("hi")
        }
    }
    var categoryData: CategoryModel?
    
    var buttonLabels = ["가뭄", "강풍", "낙뢰", "녹조", "대설", "산사태", "적조", "지진", "지진해일", "침수", "태풍", "폭염", "풍랑", "한파", "해수면상승", "해일", "홍수", "황사", "호우", "화산폭발", "우주전파재난", "우주물체추락"]
    
    var buttonImages = [UIImage(named: "Drought"), UIImage(named: "Strong wind"), UIImage(named:"Lightning"), UIImage(named:"Green tide"), UIImage(named:"Heavy snow"), UIImage(named:"Landslide"), UIImage(named:"Red tide"), UIImage(named:"Earthquake"), UIImage(named:"Earthquake and tsunami"), UIImage(named:"Flooding"), UIImage(named:"Typhoon"), UIImage(named:"Heat wave"), UIImage(named:"Rough sea"), UIImage(named:"Cold wave"), UIImage(named:"Sea level rise"), UIImage(named:"Tsunami"), UIImage(named:"Flood"), UIImage(named:"Dust storm"), UIImage(named:"Heavy rain"), UIImage(named:"Volcanic eruption"), UIImage(named:"Space radio disaster"), UIImage(named:"Natural space object crash")]
    
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
        
        if let tabBarViewController = parent as? TabBarViewController {
                print(tabBarViewController.selectedIndex)
            }
        
        setData()
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
        ])
    }
    
    func setData() {
        DispatchQueue.global(qos: .userInteractive).async {
            print("About to call getCategoryData")

            self.categoryApiHandler.getCategoryData() { [weak self] data in
                guard let self = self else { return }
                print("getCategoryData completion handler called")

                
                DispatchQueue.main.async {
                    self.categoryData = data  // CategoryModel 배열 데이터 저장
                    self.collectionView.reloadData()  // 컬렉션 뷰 리로드
                }
            }
        }
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CategoryCell

        if let categoryModelData = categoryData {
            let labelToKey: [String: CategoryModel.CodingKeys] = [
                "가뭄": .drought,
                "강풍": .strongWind,
                "낙뢰": .lightning,
                "녹조": .greenTide,
                "대설": .heavySnow,
                "산사태": .landslide,
                "적조": .redTide,
                "지진": .earthquake,
                "지진해일": .tsunami,
                "침수": .flooding,
                "태풍": .typhoon,
                "폭염": .heatWave,
                "풍랑": .windAndWaves,
                "한파": .coldWave,
                "해수면상승": .risingSeaLevel,
                "해일": .tidalWave,
                "홍수": .flood,
                "황사": .yellowDust,
                "호우": .heavyRain,
                "화산폭발": .volcanicEruption,
                "우주전파재난": .spacePropagationDisaster,
                "우주물체추락": .theFallOfNaturalSpaceObjects
            ]
            
            if indexPath.row < buttonLabels.count {
                let buttonLabel = buttonLabels[indexPath.row]
                let buttonImage = buttonImages[indexPath.row]
                cell.categoryView.buttonLabel.text = buttonLabel
                cell.categoryView.buttonImageView.image = buttonImage

                cell.categoryView.buttonAction = { [weak self] in
                    guard let self = self,
                          let buttonLabel = cell.categoryView.buttonLabel.text,
                          let key = labelToKey[buttonLabel]?.stringValue else { return }
                    print("key : \(key)")
                    
                    // key를 category로 전달
                    self.categoryPageApiHandler.getCategoryPageData(category: key) { [weak self] data in
                        guard let self = self else { return }
                        // 정의해둔 모델 객체에 할당
                        self.categoryPageViewController.categoryPageData = data
                        
                        // 데이터를 제대로 잘 받아왔다면
                        guard let data = self.categoryPageViewController.categoryPageData else {
                            return print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
                        }
                        DispatchQueue.main.async {
                            let categoryPageViewController = CategoryPageViewController()
                            categoryPageViewController.presentCategory = key
                            categoryPageViewController.hidesBottomBarWhenPushed = true

                            self.navigationController?.pushViewController(categoryPageViewController, animated: true)
                        }
                    }
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let totalCells = buttonImages.count
        let remainder = totalCells % 9
        return totalCells + (remainder > 0 ? (9 - remainder) : 0) // 빈 셀 추가
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 3
        let height = collectionView.frame.height / 3
        return CGSize(width: width, height: height)
    }
}
