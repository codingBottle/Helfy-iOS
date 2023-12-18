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
    case category18 = "Yellow dust"
    case category19 = "Heavy rain"
    case category20 = "Volcanic eruption"
    case category21 = "Space radio disaster"
    case category22 = "Natural space object crash"
    
    static func from(string: String) -> Category? {
        return Category.allCases.first { $0.rawValue == string }
    }
}

// Custom UICollectionViewCell
class CategoryCell: UICollectionViewCell {
    static let identifier = "CategoryCell"
    let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let myTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(myImageView)
        contentView.addSubview(myTitleLabel)

        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            myImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            myImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            myImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),

            myTitleLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 10),
            myTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            myTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with image: UIImage?, title: String) {
        myImageView.image = image
        myTitleLabel.text = title
    }
}


// Collection View
class CategoryView: UICollectionView, UICollectionViewDataSource {
    var buttonTitles = ["가뭄", "강풍", "낙뢰", "녹조", "대설", "산사태", "적조", "지진", "지진해일", "침수", "태풍", "폭염", "풍랑", "한파", "해수면상승", "해일", "홍수", "황사", "호우", "화산폭발", "우주전파재난", "자연우주물체추락"]
   
    var buttonImages = [UIImage(named: "Drought"), UIImage(named: "Strong wind"), UIImage(named:"Lightning"), UIImage(named:"Green tide"), UIImage(named:"Heavy snow"), UIImage(named:"Landslide"), UIImage(named:"Red tide"), UIImage(named:"Earthquake"), UIImage(named:"Earthquake and tsunami"), UIImage(named:"Flooding"), UIImage(named:"Typhoon"), UIImage(named:"Heat wave"), UIImage(named:"Rough sea"), UIImage(named:"Cold wave"), UIImage(named:"Sea level rise"), UIImage(named:"Tsunami"), UIImage(named:"Flood"), UIImage(named:"Yellow dust"), UIImage(named:"Heavy rain"), UIImage(named:"Volcanic eruption"), UIImage(named:"Space radio disaster"), UIImage(named:"Natural space object crash")]

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)

        self.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        self.dataSource = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        let title = buttonTitles[indexPath.row]
        let image = buttonImages[indexPath.row]
        cell.configure(with: image, title: title)
        return cell
    }
}
