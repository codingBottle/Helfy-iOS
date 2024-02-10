//
//  BannerView.swift
//  Helfy
//
//  Created by YEOMI on 11/18/23.
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
        scrollView.clipsToBounds = true // 이 부분을 추가합니다.
        return scrollView
    }()

    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()

    var banners: [(image: UIImage, text: String)] = [] {
        didSet {
            pageControl.numberOfPages = banners.count
            pageControl.currentPage = 0
            setupBanners()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.delegate = self
        setupView()
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        scrollView.delegate = self
        setupView()
        
    }

    private func setupView() {
        addSubview(scrollView)
        addSubview(pageControl)
        
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        backgroundColor = .gray

        let pageControlHeight: CGFloat = 50
        let imageViewHeight = self.frame.size.height * 2 / 3
        let labelHeight = self.frame.size.height / 3

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: imageViewHeight + labelHeight), // 스크롤뷰의 높이를 이미지 뷰와 레이블 높이의 합으로 설정합니다.

            pageControl.topAnchor.constraint(equalTo: scrollView.bottomAnchor), // 페이지 컨트롤의 상단을 스크롤뷰의 하단에 위치시킵니다.
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: pageControlHeight) // 페이지 컨트롤의 높이를 설정합니다.
        ])
    }

    

    private func setupBanners() {
        for i in 0..<banners.count {
            let imageView = UIImageView(image: banners[i].image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = CGRect(x: CGFloat(i) * frame.size.width, y: 0, width: frame.size.width, height: frame.size.height * 2 / 3)

            let label = UILabel()
            label.text = banners[i].text
            label.numberOfLines = 0  // 줄바꿈을 허용합니다.
            label.lineBreakMode = .byWordWrapping  // 단어 단위로 줄바꿈합니다.
            label.backgroundColor = .white
            label.frame = CGRect(x: CGFloat(i) * frame.size.width, y: frame.size.height * 2 / 3, width: frame.size.width, height: frame.size.height / 3)

            scrollView.addSubview(imageView)
            scrollView.addSubview(label)
            NSLayoutConstraint.activate([
                        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                        imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: CGFloat(i) * frame.size.width),
                        imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                        imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 2/3),
                        
                        label.topAnchor.constraint(equalTo: imageView.bottomAnchor),
                        label.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: CGFloat(i) * frame.size.width),
                        label.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                        label.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 1/3)
                    ])
        }

        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(banners.count), height: scrollView.frame.size.height)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    
}
