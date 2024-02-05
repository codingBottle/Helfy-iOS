//
//  MypageView.swift
//  Helfy
//
//  Created by 윤성은 on 11/8/23.
//

import UIKit

class MypageView: UIView {
    
    // 프로필 이미지
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "person.crop.square.fill")?.withTintColor(UIColor(hex: "#F9DF56"), renderingMode: .alwaysOriginal)
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let smallIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "camera.circle.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.minimumScaleFactor = 0.1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let regionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = false
        label.isUserInteractionEnabled = true
        label.minimumScaleFactor = 0.1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var idStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nicknameLabel, regionLabel])
        sv.axis = .vertical
        sv.spacing = 15
        sv.distribution = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rankTextLabel: UILabel = {
        let label = UILabel()
        label.text = "순위"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 22)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true // 사용자 상호작용 활성화
        label.minimumScaleFactor = 0.1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rankStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [rankTextLabel, rankLabel])
        sv.axis = .vertical
        sv.spacing = 10
        sv.distribution = .fillEqually
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    let scoreTextLabel: UILabel = {
        let label = UILabel()
        label.text = "점수"
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 22)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true // 사용자 상호작용 활성화
        label.minimumScaleFactor = 0.1
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true // 사용자 상호작용 활성화
        label.minimumScaleFactor = 0.1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var scoreStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [scoreTextLabel, scoreLabel])
        sv.axis = .vertical
        sv.spacing = 10
        sv.distribution = .fillEqually
        return sv
    }()
    
    lazy var containerStackView: UIStackView = {
        let container = UIStackView(arrangedSubviews: [rankStackView, scoreStackView])
        container.axis = .horizontal
        container.distribution = .fillEqually
        container.spacing = 15
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(profileImageView)
        addSubview(smallIconImageView)
        addSubview(idStackView)
        addSubview(separatorView)
        addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 110),
            profileImageView.widthAnchor.constraint(equalToConstant: 180),
            profileImageView.heightAnchor.constraint(equalToConstant: 180),
            profileImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            smallIconImageView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 5),  // 수정된 부분
            smallIconImageView.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),  // 수정된 부분
            smallIconImageView.widthAnchor.constraint(equalToConstant: 50),
            smallIconImageView.heightAnchor.constraint(equalToConstant: 50),
            
            idStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            idStackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 50),
            idStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            separatorView.topAnchor.constraint(equalTo: idStackView.bottomAnchor, constant: 40),
            separatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            separatorView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            containerStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 40),
            containerStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
        ])
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
