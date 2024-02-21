//
//  BannerViewController.swift
//  Helfy
//
//  Created by YEOMI on 2/10/24.
//

import UIKit

class BannerViewController: UIViewController {
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bannerWidth: CGFloat = view.bounds.width * 0.9
        let bannerHeight: CGFloat = view.bounds.height * 0.8
        let bannerX: CGFloat = (view.bounds.width - bannerWidth) / 2
        let bannerY: CGFloat = (view.bounds.height - bannerHeight) / 2
        let bannerFrame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        
        let banner = BannerView(frame: bannerFrame)
        banner.onPageChanged = { [weak self] page in
            self?.pageControl.currentPage = page
        }
        
        let screenHeight = UIScreen.main.bounds.height
        
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.banners = [
            UIImage(named: "img1")!,
            UIImage(named: "img2")!,
            UIImage(named: "img3")!
        ]
        banner.bannersLink = [
            "https://www.youtube.com/watch?v=kdkcKESgRaU",
            "https://www.youtube.com/watch?v=PZ2XJ-QjSDo",
            "https://www.youtube.com/watch?v=5dUpQYvzByA"
        ]
        
        pageControl.numberOfPages = banner.banners.count
        
        view.addSubview(banner)
        view.addSubview(pageControl)
        
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            banner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            banner.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            banner.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            banner.heightAnchor.constraint(equalToConstant: 500),
            
            pageControl.topAnchor.constraint(equalTo: banner.bottomAnchor, constant: 5),
            pageControl.centerXAnchor.constraint(equalTo: banner.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func didScrollToPage(_ page: Int) {
        pageControl.currentPage = page
    }
}
