//
//  CategoryPageView.swift
//  Helfy
//
//  Created by YEOMI on 11/29/23.
//
import UIKit

class CategoryPageView: UIView {
    
    var newsURL = ""
    var youtubeURL = ""
    var isImageViewZoomed = false

    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    let categoryImageView: UIImageView = {
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
    
    let contentView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red: 249/255, green: 223/255, blue: 86/255, alpha: 1.0)
        textView.isEditable = false
        textView.isScrollEnabled = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.layer.cornerRadius = 10
        return textView
    }()
    
    let newsButton: UIButton = {
        let button = UIButton()
        button.setTitle("뉴스", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(red: 249/255, green: 164/255, blue: 86/255, alpha: 1.0)
        return button
    }()
    
    let youtubeButton: UIButton = {
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
        addSubview(contentView)
        addSubview(newsButton)
        addSubview(youtubeButton)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
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
            contentView.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 20),
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            contentView.widthAnchor.constraint(equalToConstant: 180),
            contentView.heightAnchor.constraint(equalToConstant: 350),
            
            // News Button
            newsButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -80),
            newsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            newsButton.widthAnchor.constraint(equalToConstant: 150),
            newsButton.heightAnchor.constraint(equalToConstant: 50),
            
            // YouTube Button
            youtubeButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 80),
            youtubeButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            youtubeButton.widthAnchor.constraint(equalToConstant: 150),
            youtubeButton.heightAnchor.constraint(equalToConstant: 50),
        ])
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
            categoryImageView.addGestureRecognizer(tapGestureRecognizer)
            categoryImageView.isUserInteractionEnabled = true
 
    }
    
    func setNewsButtonTarget(_ target: Any?, action: Selector) {
        newsButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func setYouTubeButtonTarget(_ target: Any?, action: Selector) {
        youtubeButton.addTarget(target, action: action, for: .touchUpInside)
    }
    
    func setTextViewText(_ text: String) {
        contentView.text = text
    }
    
    func getTextViewText() -> String {
        return contentView.text
    }
    @objc private func imageViewTapped() {
        isImageViewZoomed = !isImageViewZoomed
        UIView.animate(withDuration: 0.3) {
            if self.isImageViewZoomed {
                // 이미지 뷰를 확대
                self.categoryImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
                self.bringSubviewToFront(self.categoryImageView) // 이미지 뷰를 가장 앞으로 가져옴
            } else {
                // 이미지 뷰를 원래 크기로 복구
                self.categoryImageView.transform = CGAffineTransform.identity
            }
        }
    }

}

