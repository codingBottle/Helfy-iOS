//
//  CategoryPageViewController.swift
//  Helfy
//
//  Created by YEOMI on 11/29/23.
//
import UIKit

class CategoryPageViewController: UIViewController {
    
    let categoryPageViewInstance = CategoryPageView()

    lazy var newsURL = categoryPageViewInstance.newsURL
    lazy var youtubeURL = categoryPageViewInstance.youtubeURL
    
    private var categoryPageView: CategoryPageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        categoryPageView = CategoryPageView()
        categoryPageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryPageView)
        
        NSLayoutConstraint.activate([
            categoryPageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryPageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryPageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryPageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        categoryPageView.setNewsButtonTarget(self, action: #selector(newsButtonTapped))
        categoryPageView.setYouTubeButtonTarget(self, action: #selector(youtubeButtonTapped))
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

