//
//  BannerView.swift
//  Helfy
//
//  Created by YEOMI on 2/10/24.
//
import UIKit

class BannerView: UIView, UIScrollViewDelegate {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.alwaysBounceVertical = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    func getScrollViewHeight() -> CGFloat {
            return scrollView.frame.size.height
        }
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    var banners: [UIImage] = [] {
        didSet {
            pageControl.numberOfPages = banners.count
            pageControl.currentPage = 0
            setupBanners()
        }
    }
    var bannersLink: [String] = [] // 각 이미지에 대한 링크 정보

    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.delegate = self
        setupView()
        bringSubviewToFront(pageControl)
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        scrollView.delegate = self
        setupView()
        bringSubviewToFront(pageControl)
        
    }

    private func setupView() {
            addSubview(scrollView)
            addSubview(pageControl)
            self.layer.cornerRadius = 20
            self.clipsToBounds = true
            let backgroundColor = UIColor(red: 249/255, green: 223/255, blue: 86/255, alpha: 1.0)
            self.backgroundColor = backgroundColor


            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: topAnchor),
                scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: pageControl.topAnchor),
                // 스크롤뷰의 하단을 페이지 컨트롤의 상단에 위치시킵니다.

                pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
                pageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
                pageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
                pageControl.heightAnchor.constraint(equalToConstant: 30) // 페이지 컨트롤의 높이를 설정합니다.
            ])
        }
    

    private func setupBanners() {
        for i in 0..<banners.count {
            let imageView = UIImageView(image: banners[i])
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = .white
            
            // 이미지 뷰에 탭 제스처 추가
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleBannerTap(_:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapGestureRecognizer)
            imageView.tag = i // 이미지 뷰의 태그를 인덱스로 설정

            scrollView.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant:  CGFloat(i) * frame.size.width),
                        imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                        imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
                       
                        
                    ])
        }

        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(banners.count), height: scrollView.frame.size.height)
    }
    @objc private func handleBannerTap(_ gesture: UITapGestureRecognizer) {
        guard let imageView = gesture.view as? UIImageView else {
            return
        }
        
        let index = imageView.tag
        
        // index가 bannersLink 배열의 유효한 인덱스인지 확인
        guard index < bannersLink.count, let url = URL(string: bannersLink[index]) else {
            return
        }
        
        UIApplication.shared.open(url)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
}

