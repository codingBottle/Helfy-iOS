//
//  BannerViewController.swift
//  Helfy
//
//  Created by YEOMI on 11/18/23.
//

import UIKit

class BannerViewController: UIViewController {

    var bannerView: BannerView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 배너뷰 설정
        bannerView = BannerView(frame: view.bounds)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)

        // 배너뷰 제약조건 설정
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: view.topAnchor),
            bannerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

