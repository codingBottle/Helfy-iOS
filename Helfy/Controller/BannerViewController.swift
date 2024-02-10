//
//  BannerViewController.swift
//  Helfy
//
//  Created by YEOMI on 11/18/23.
//

import UIKit
// 사용 예시
class BannerViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bannerWidth: CGFloat = view.bounds.width * 0.9
        let bannerHeight: CGFloat = view.bounds.height * 0.7
        let bannerX: CGFloat = (view.bounds.width - bannerWidth) / 2
        let bannerY: CGFloat = (view.bounds.height - bannerHeight) / 2
        let bannerFrame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        
        let banner = BannerView(frame: bannerFrame)
        banner.banners = [
            (image: UIImage(named: "bg2")!, text: "Text 1 줄바꿈 테스트 중 입니다. ext 1 줄바꿈 테스트 중 입니다. ext 1 줄바꿈 테스트 중 입니다. ext 1 줄바꿈 테스트 중 입니다. ext 1 줄바꿈 테스트 중 입니다. ext 1 줄바꿈 테스트 중 입니다. "),
            (image: UIImage(named: "img2")!, text: "Text 2"),
            (image: UIImage(named: "img3")!, text: "Text 3")
        ]
        view.addSubview(banner)
        view.backgroundColor = .green // 여기를 추가합니다.
    }
    
    
}
