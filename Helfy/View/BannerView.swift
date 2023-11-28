//
//  BannerView.swift
//  Helfy
//
//  Created by YEOMI on 11/18/23.
//
import UIKit

class BannerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let collectionView = UICollectionView(frame: CGRect(x: 50, y: 100, width: 300, height: 100), collectionViewLayout: UICollectionViewFlowLayout())
    let pageControl = UIPageControl()
    let bannerDuration = 3.0
    var bannerTimer: Timer?
    var currentIndex: Int = 0
    let colors: [UIColor] = [UIColor.red, UIColor.green, UIColor.blue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        setupCollectionView()
        setupPageControl()
        startBannerTimer()
    }
    
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BannerCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        
        collectionView.reloadData()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBannerTap))
        collectionView.addGestureRecognizer(tapGesture)
    }
    
    func setupPageControl() {
        pageControl.frame = CGRect(x: 50, y: 170, width: 300, height: 100) // 배너 아래에 위치
        pageControl.numberOfPages = colors.count
        pageControl.currentPage = currentIndex
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = UIColor(red: 249/255, green: 164/255, blue: 86/255, alpha: 1.0) // 현재 페이지 색상 설정
        pageControl.pageIndicatorTintColor = UIColor(red: 249/255, green: 223/255, blue: 86/255, alpha: 1.0)
        
        view.addSubview(pageControl)
    }
    
    func startBannerTimer() {
        bannerTimer = Timer.scheduledTimer(timeInterval: bannerDuration, target: self, selector: #selector(updateBanner), userInfo: nil, repeats: true)
    }
    
    @objc func updateBanner() {
        currentIndex = (currentIndex + 1) % colors.count
        collectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @objc func handleBannerTap() {
        let currentColor = colors[currentIndex]
        print("Current Color:", currentColor)
    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        let color = colors[indexPath.item] // 해당 셀의 배너 색상
        cell.configure(with: color) // 색상 파라미터 추가
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
    var bannerView: UIView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBannerView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupBannerView()
    }

    private func setupBannerView() {
        bannerView.frame = contentView.bounds
        bannerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(bannerView)
    }

    func configure(with color: UIColor) {
        bannerView.backgroundColor = color
    }
}
