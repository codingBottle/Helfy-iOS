//
//  CategoryView.swift
//  Helfy
//
//  Created by 윤성은 on 10/11/23.
//
//

import UIKit

enum Category: String, CaseIterable {
    case category1 = "침수"
    case category2 = "태풍"
    case category3 = "호우"
    case category4 = "낙뢰"
    case category5 = "강풍"
    case category6 = "풍랑"
    case category7 = "대설"
    case category8 = "한파"
    case category9 = "폭염"
    case category10 = "황사"
    case category11 = "지진"
    case category12 = "해일"
    case category13 = "지진해일"
    case category14 = "화산폭발"
    case category15 = "가뭄"
    case category16 = "홍수"
    case category17 = "해수면상승"
    case category18 = "산사태"
    case category19 = "자연우주물체추락"
    case category20 = "우주전파재난"
    case category21 = "녹조"
    case category22 = "적조"
}

// Custom UICollectionViewCell
class CategoryCell: UICollectionViewCell {
    static let identifier = "CategoryCell"

    private let myImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let myTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(myImageView)
        contentView.addSubview(myTitleLabel)
        
        myImageView.isUserInteractionEnabled = false
        myTitleLabel.isUserInteractionEnabled = false


        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            myImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            myImageView.widthAnchor.constraint(equalToConstant: 90),
            myImageView.heightAnchor.constraint(equalToConstant: 60),

            myTitleLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 5),
            myTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            myTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            myTitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
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
class CategoryView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    private var buttonTitles = ["침수", "태풍", "호우","낙뢰", "강풍", "풍랑", "대설", "한파", "폭염", "황사", "지진", "해일", "지진해일", "화산폭발", "가뭄","홍수", "해수면상승", "산사태","자연우주물체추락", "우주전파재난", "녹조", "적조"]
    private var buttonImages = [UIImage(named:"침수"), UIImage(named:"태풍"), UIImage(named: "호우"), UIImage(named:"낙뢰"), UIImage(named:"강풍"), UIImage(named: "풍랑"), UIImage(named:"대설"), UIImage(named:"한파"), UIImage(named:"폭염"), UIImage(named:"황사"), UIImage(named:"지진"), UIImage(named:"해일"), UIImage(named:"지진해일"), UIImage(named:"화산폭발"), UIImage(named:"가뭄"), UIImage(named:"홍수"), UIImage(named:"해수면상승"), UIImage(named:"산사태"), UIImage(named:"자연우주물체추락"), UIImage(named:"우주전파재난"), UIImage(named:"녹조"), UIImage(named:"적조")]


    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        if let flowLayout = layout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }

        self.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        self.dataSource = self
        self.delegate = self
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

    // MARK: UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 15 * 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = Category.allCases[indexPath.item]
        print("\(selectedCategory.rawValue) was tapped!")
        
    }
}
