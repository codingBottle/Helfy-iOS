//
//  BannerViewController.swift
//  Helfy
//
//  Created by YEOMI on 2/10/24.
//
import UIKit

class BannerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bannerWidth: CGFloat = view.bounds.width * 0.9
        let bannerHeight: CGFloat = view.bounds.height * 0.7
        let bannerX: CGFloat = (view.bounds.width - bannerWidth) / 2
        let bannerY: CGFloat = (view.bounds.height - bannerHeight) / 2
        let bannerFrame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        
        let banner = BannerView(frame: bannerFrame)
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.banners = [
            UIImage(named: "img1")!,
            UIImage(named: "img2")!,
            UIImage(named: "img3")!
        ]

        view.addSubview(banner)
        
        view.backgroundColor = .white // 여기를 추가합니다.
        let screenHeight = UIScreen.main.bounds.height
        NSLayoutConstraint.activate([
            banner.topAnchor.constraint(equalTo: view.topAnchor, constant: screenHeight * 0.3),
            banner.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            banner.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            banner.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    
}

