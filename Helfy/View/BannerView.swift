//
//  BannerView.swift
//  Helfy
//
//  Created by YEOMI on 2/10/24.
//

import UIKit

class BannerView: UIView, UIScrollViewDelegate {

    // Properties
    var banners: [UIImage] = [] {
        didSet { setupBanners() }
    }
    var bannersLink: [String] = []
    var onPageChanged: ((Int) -> Void)?

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

    // Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // Setup View
    private func commonInit() {
        scrollView.delegate = self
        setupView()
    }

    private func setupView() {
        addSubview(scrollView)

        self.layer.cornerRadius = 20
        self.clipsToBounds = true

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }

    private func setupBanners() {
        for i in 0..<banners.count {
            let imageView = UIImageView(image: banners[i])
            imageView.contentMode = .scaleAspectFill
//            imageView.layer.cornerRadius = 20
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.backgroundColor = .white
            imageView.isUserInteractionEnabled = true
            imageView.tag = i

            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleBannerTap(_:)))
            imageView.addGestureRecognizer(tapGestureRecognizer)

            scrollView.addSubview(imageView)

            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: CGFloat(i) * frame.size.width),
                imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                imageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            ])
        }
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(banners.count), height: scrollView.frame.size.height)
    }

    // Actions
    @objc private func handleBannerTap(_ gesture: UITapGestureRecognizer) {
        guard let imageView = gesture.view as? UIImageView else { return }
        let index = imageView.tag
        guard index < bannersLink.count, let url = URL(string: bannersLink[index]) else { return }
        UIApplication.shared.open(url)
    }

    // ScrollView Delegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        onPageChanged?(Int(pageNumber))
    }

    // Public Methods
    func getScrollViewHeight() -> CGFloat {
        return scrollView.frame.size.height
    }
}
