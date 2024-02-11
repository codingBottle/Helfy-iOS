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
        scrollView.clipsToBounds = true // 이 부분을 추가합니다.
        return scrollView
    }()
    
    func getScrollViewHeight() -> CGFloat {
            return scrollView.frame.size.height
        }
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray  // 페이지 인디케이터의 색상을 설정합니다.
        pageControl.currentPageIndicatorTintColor = .black
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
                pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
                pageControl.heightAnchor.constraint(equalToConstant: 50) // 페이지 컨트롤의 높이를 설정합니다.
            ])
        }
    

    private func setupBanners() {
        for i in 0..<banners.count {
            let imageView = UIImageView(image: banners[i].image)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.frame = CGRect(x: CGFloat(i) * frame.size.width, y: 0, width: frame.size.width, height: frame.size.height * 2 / 3)
            imageView.backgroundColor = .white

            let label = UILabel()
            label.text = banners[i].text
            label.textAlignment = .center
            label.numberOfLines = 0  // 줄바꿈을 허용합니다.
            label.sizeToFit()
            label.lineBreakMode = .byWordWrapping  // 단어 단위로 줄바꿈합니다.
            label.backgroundColor = UIColor(red: 249/255, green: 223/255, blue: 86/255, alpha: 1.0)
            label.font = UIFont.systemFont(ofSize: 25)
            label.frame = CGRect(x: CGFloat(i) * frame.size.width, y: frame.size.height * 1.6 / 3, width: frame.size.width, height: frame.size.height * 1 / 3)

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
