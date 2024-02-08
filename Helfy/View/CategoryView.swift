//
//  CategoryView.swift
//  Helfy
//
//  Created by 윤성은 on 10/11/23.
//
//

import UIKit

enum Category: String, CaseIterable {
    case category1 = "Drought"
    case category2 = "Strong wind"
    case category3 = "Lightning"
    case category4 = "Green tide"
    case category5 = "Heavy snow"
    case category6 = "Landslide"
    case category7 = "Red tide"
    case category8 = "Earthquake"
    case category9 = "Earthquake and tsunami"
    case category10 = "Flooding"
    case category11 = "Typhoon"
    case category12 = "Heat wave"
    case category13 = "Rough sea"
    case category14 = "Cold wave"
    case category15 = "Sea level rise"
    case category16 = "Tsunami"
    case category17 = "Flood"
    case category18 = "Dust storm"
    case category19 = "Heavy rain"
    case category20 = "Volcanic eruption"
    case category21 = "Space radio disaster"
    case category22 = "Natural space object crash"
    
    static func from(string: String) -> Category? {
        return Category.allCases.first { $0.rawValue == string }
    }
}

var buttonTitles = ["가뭄", "강풍", "낙뢰", "녹조", "대설", "산사태", "적조", "지진", "지진해일", "침수", "태풍", "폭염", "풍랑", "한파", "해수면상승", "해일", "홍수", "황사", "호우", "화산폭발", "우주전파재난", "우주물체추락"]

var buttonImages = [UIImage(named: "Drought"), UIImage(named: "Strong wind"), UIImage(named:"Lightning"), UIImage(named:"Green tide"), UIImage(named:"Heavy snow"), UIImage(named:"Landslide"), UIImage(named:"Red tide"), UIImage(named:"Earthquake"), UIImage(named:"Earthquake and tsunami"), UIImage(named:"Flooding"), UIImage(named:"Typhoon"), UIImage(named:"Heat wave"), UIImage(named:"Rough sea"), UIImage(named:"Cold wave"), UIImage(named:"Sea level rise"), UIImage(named:"Tsunami"), UIImage(named:"Flood"), UIImage(named:"Dust storm"), UIImage(named:"Heavy rain"), UIImage(named:"Volcanic eruption"), UIImage(named:"Space radio disaster"), UIImage(named:"Natural space object crash")]

// Custom UICollectionViewCell
class CategoryCell: UICollectionViewCell {
    
    let categoryView: CategoryView = {
        let cv = CategoryView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
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
