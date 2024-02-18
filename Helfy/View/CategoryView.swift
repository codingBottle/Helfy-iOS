//
//  CategoryView.swift
//  Helfy
//
//  Created by 윤성은 on 10/11/23.
//
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    let categoryView: CategoryView = {
        let cv = CategoryView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    override func prepareForReuse() {
            super.prepareForReuse()

            categoryView.buttonLabel.text = nil
            categoryView.buttonImageView.image = nil
        }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(categoryView)
        
        NSLayoutConstraint.activate([
            categoryView.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CategoryView: UIView {
    
    var buttonAction: (() -> Void)?
    
    @objc func handleButtonPressed() {
        buttonAction?()
        print("Button was pressed!")
        
    }
    
    let buttonImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let buttonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(buttonImageView)
        addSubview(buttonLabel)
        
        let tapGestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(handleButtonPressed))
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(handleButtonPressed))
        buttonImageView.addGestureRecognizer(tapGestureRecognizer1)
        buttonLabel.addGestureRecognizer(tapGestureRecognizer2)
        buttonImageView.isUserInteractionEnabled = true
        buttonLabel.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            buttonImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            buttonImageView.widthAnchor.constraint(equalTo: widthAnchor),
            buttonImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            buttonLabel.topAnchor.constraint(equalTo: buttonImageView.bottomAnchor, constant: 10),
            buttonLabel.widthAnchor.constraint(equalTo: widthAnchor),
            buttonLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
