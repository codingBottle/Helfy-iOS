//
//  CategoryPageViewController.swift
//  Helfy
//
//  Created by YEOMI on 11/29/23.
//

import UIKit

class CategoryPageViewController: UIViewController {
    
    var categoryPageView = CategoryPageView()
    let apiHandler = CategoryPageAPIHandler()
    var presentCategory: String?

    lazy var newsURL = categoryPageView.newsURL
    lazy var youtubeURL = categoryPageView.youtubeURL
    
    var categoryPageModelData: CategoryPageModel? {
        didSet {
            print("hi")
        }
    }
    
    var categoryPageData: CategoryPageModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        categoryPageView = CategoryPageView(frame: view.frame)
        view.addSubview(categoryPageView)
        
        setData()
        setupUI()
        
        categoryPageView.newsButton.addTarget(self, action: #selector(newsButtonTapped), for: .touchUpInside)
        categoryPageView.youtubeButton.addTarget(self, action: #selector(youtubeButtonTapped), for: .touchUpInside)
    }

    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(categoryPageView)

        categoryPageView.translatesAutoresizingMaskIntoConstraints = false
        
        print("alpha : \(categoryPageView.alpha)")
        print("frame : \(categoryPageView.frame)")
        
        NSLayoutConstraint.activate([
            categoryPageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryPageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryPageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryPageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setData() {
        DispatchQueue.global(qos: .userInteractive).async {
            guard let presentCategory = self.presentCategory else { return }

            // API 통해 데이터 불러오기
            self.apiHandler.getCategoryPageData(category: presentCategory) { [weak self] data in
                guard let self = self else { return }
                // 정의해둔 모델 객체에 할당
                self.categoryPageData = data
                
                // 데이터를 제대로 잘 받아왔다면
                guard let data = self.categoryPageData else {
                    return print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
                }
                
                DispatchQueue.main.async {
                    self.categoryPageView.categoryLabel.text = data.category
                    self.categoryPageView.contentView.text = data.content
                    self.categoryPageView.newsURL = data.newsURL
                    self.categoryPageView.youtubeURL = data.youtubeURL
                }
                guard let imageUrl = URL(string: data.image.imageURL) else {
                    print("Invalid URL")
                    return
                }

                ImageLoader.loadImage(url: data.image.imageURL) { image in
                    DispatchQueue.main.async {
                        self.categoryPageView.categoryImageView.image = image
                    }
                }

            }
            
        }
    }
    
    @objc func newsButtonTapped() {
        // Handle news button tap
        print("News URL:", newsURL) //디버깅 용도
        if let url = URL(string: newsURL) {
            UIApplication.shared.open(url)
        }
    }

    @objc func youtubeButtonTapped() {
        // Handle YouTube button tap
        print("YouTube URL:", youtubeURL) //디버깅 용도
        if let url = URL(string: youtubeURL) {
            UIApplication.shared.open(url)
        }
    }
}

