//
//  CategoryPageView.swift
//  Helfy
//
//  Created by YEOMI on 11/29/23.
//
import UIKit

class CategoryPageView: UIView {
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        label.textAlignment = .center
        return label
    }()
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // 이미지 설정
        guard let categoryImage = UIImage(named: "호우") else {
            // 이미지를 찾을 수 없는 경우 처리
            return imageView
        }
        
        imageView.image = categoryImage
        return imageView
    }()
    
    private let catextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red: 249/255, green: 223/255, blue: 86/255, alpha: 1.0)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.layer.cornerRadius = 10
        return textView
    }()
    
    private let newsButton: UIButton = {
        let button = UIButton()
        button.setTitle("뉴스", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(red: 249/255, green: 164/255, blue: 86/255, alpha: 1.0)
        return button
    }()
    
    private let youtubeButton: UIButton = {
        let button = UIButton()
        button.setTitle("유튜브", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(red: 249/255, green: 164/255, blue: 86/255, alpha: 1.0)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(categoryLabel)
        addSubview(categoryImageView)
        addSubview(catextView)
        addSubview(newsButton)
        addSubview(youtubeButton)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        catextView.translatesAutoresizingMaskIntoConstraints = false
        newsButton.translatesAutoresizingMaskIntoConstraints = false
        youtubeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Category Label
            categoryLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            categoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            // Category Image View
            categoryImageView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20),
            categoryImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryImageView.widthAnchor.constraint(equalToConstant: 480),
            categoryImageView.heightAnchor.constraint(equalToConstant: 200),
            
            // catextView View
            catextView.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 20),
            catextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            catextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            catextView.widthAnchor.constraint(equalToConstant: 480),
            catextView.heightAnchor.constraint(equalToConstant: 380),
            
            // News Button
            newsButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -80),
            newsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            newsButton.widthAnchor.constraint(equalToConstant: 150),
            newsButton.heightAnchor.constraint(equalToConstant: 50),
            
            // YouTube Button
            youtubeButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 80),
            youtubeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            youtubeButton.widthAnchor.constraint(equalToConstant: 150),
            youtubeButton.heightAnchor.constraint(equalToConstant: 50)
            
            
            
        ])
    }
    
    func setNewsButtonTarget(_ target: Any?, action: Selector) {
        newsButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func setYouTubeButtonTarget(_ target: Any?, action: Selector) {
        youtubeButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func setTextViewText(_ text: String) {
        catextView.text = text
    }
    
    func getTextViewText() -> String {
        return catextView.text
    }
}
