//
//  CategoryView.swift
//  Helfy
//
//  Created by 윤성은 on 10/11/23.
//
//

import UIKit

class CategoryButtonCollectionViewCell: UICollectionViewCell {
    let myImageView = UIImageView()
    let myTitleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        myImageView.contentMode = .scaleAspectFit
        contentView.addSubview(myImageView)
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myImageView.widthAnchor.constraint(equalToConstant: 90),
            myImageView.heightAnchor.constraint(equalToConstant: 60),
            myImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            myImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])

        myTitleLabel.font = UIFont.systemFont(ofSize: 12)
        myTitleLabel.textAlignment = .center
        contentView.addSubview(myTitleLabel)
        myTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myTitleLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 5),
            myTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            myTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            myTitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CategoryView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let collectionView: UICollectionView
    let buttonTitles = ["침수", "태풍", "호우","낙뢰",
                        "강풍", "풍랑", "대설", "한파",
                        "폭염", "황사", "지진", "해일",
                        "지진해일", "화산폭발", "가뭄","홍수",
                        "해수면상승", "산사태","자연우주물체추락", "우주전파재난",
                        "녹조", "적조"]
    let buttonImages = [UIImage(named:"침수"), UIImage(named:"태풍"), UIImage(named: "호우"),
                        UIImage(named:"낙뢰"), UIImage(named:"강풍"), UIImage(named: "풍랑"),
                        UIImage(named:"대설"), UIImage(named:"한파"), UIImage(named:"폭염"),
                        UIImage(named:"황사"), UIImage(named:"지진"), UIImage(named:"해일"),
                        UIImage(named:"지진해일"), UIImage(named:"화산폭발"), UIImage(named:"가뭄"),
                        UIImage(named:"홍수"), UIImage(named:"해수면상승"), UIImage(named:"산사태"),
                        UIImage(named:"자연우주물체추락"), UIImage(named:"우주전파재난"), UIImage(named:"녹조"), UIImage(named:"적조") ]

    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        super.init(frame: frame)

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryButtonCollectionViewCell.self, forCellWithReuseIdentifier: "CategoryButtonCollectionViewCell")
        collectionView.backgroundColor = .clear

        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryButtonCollectionViewCell", for: indexPath) as! CategoryButtonCollectionViewCell
        let buttonTitle = buttonTitles[indexPath.item]
        let buttonImage = buttonImages[indexPath.item]
        cell.myImageView.image = buttonImage
        cell.myTitleLabel.text = buttonTitle
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 15) / 4
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Button was tapped!")
    }
}

