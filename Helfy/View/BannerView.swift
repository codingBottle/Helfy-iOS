//
//  BannerView.swift
//  Helfy
//
//  Created by YEOMI on 11/18/23.
//
import UIKit

class BannerView: UIView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let collectionView = UICollectionView(frame: CGRect(x: 50, y: 100, width: 300, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
    let pageControl = UIPageControl()
    let bannerDuration = 3.0
    var currentIndex: Int = 0
    let banners = [UIImage(named: "img1"),UIImage(named: "img2"),UIImage(named: "img3")]
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupCollectionView()
            setupPageControl()
    }
    required init?(coder: NSCoder) {
           super.init(coder: coder)
           self.backgroundColor = .white // 배경색을 흰색으로 설정
           setupCollectionView()
           setupPageControl()
       }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        self.addSubview(pageControl)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.reloadData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBannerTap))
        collectionView.addGestureRecognizer(tapGesture)
    }
    
    func setupPageControl() {
        pageControl.frame = CGRect(x: 50, y: 170, width: 300, height: 100) // 배너 아래에 위치
        pageControl.numberOfPages = banners.count
        pageControl.currentPage = currentIndex
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = UIColor(red: 249/255, green: 164/255, blue: 86/255, alpha: 1.0) // 현재 페이지 색상 설정
        pageControl.pageIndicatorTintColor = UIColor(red: 249/255, green: 223/255, blue: 86/255, alpha: 1.0)
        
        self.addSubview(collectionView)
    }
    
    
    @objc func handleBannerTap() {
        let currentImage = banners[currentIndex]
        print("Current Image:", currentImage)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        let image = banners[indexPath.item] // 해당 셀의 배너 이미지
        cell.configure(with: image) // 이미지 파라미터 추가
        return cell
    }
     
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateCurrentIndex()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updateCurrentIndex()
    }
    
    private func updateCurrentIndex() {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let indexPath = collectionView.indexPathForItem(at: visiblePoint) {
            currentIndex = indexPath.item
            pageControl.currentPage = currentIndex
        }
    }
}

class BannerCell: UICollectionViewCell {
    var bannerView: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white // 배경색을 흰색으로 설정
        setupBannerView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .white // 배경색을 흰색으로 설정
        setupBannerView()
    }

    private func setupBannerView() {
        bannerView.frame = contentView.bounds
        bannerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(bannerView)
    }

    func configure(with image: UIImage?) {
        bannerView.image = image
    }
}
