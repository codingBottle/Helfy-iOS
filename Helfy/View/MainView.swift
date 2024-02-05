//
//  MainVIew.swift
//  Helfy
//
//  Created by 윤성은 on 2/5/24.
//

import UIKit

class MainView: UIView {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "person.crop.square.fill")?.withTintColor(UIColor(hexColor: "#F9DF56"), renderingMode: .alwaysOriginal)
//        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "닉네임닉네임닉네임닉네임닉네닉"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = false
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.minimumScaleFactor = 0.1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    lazy var userStackView: UIStackView = {
//        let sv = UIStackView(arrangedSubviews: [profileImageView, nicknameLabel])
//        sv.axis = .horizontal
//        sv.spacing = 5
//        sv.distribution = .fillEqually
//        sv.translatesAutoresizingMaskIntoConstraints = false
//        return sv
//    }()
    
    let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "camera.circle.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
//        label.text = "날씨 온도 습도"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = false
        label.isUserInteractionEnabled = true
        label.numberOfLines = 0

        label.minimumScaleFactor = 0.1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    lazy var weatherStackView: UIStackView = {
//        let sv = UIStackView(arrangedSubviews: [weatherImageView, weatherLabel])
//        sv.axis = .horizontal
//        sv.spacing = 5
//        sv.distribution = .fillEqually
//        sv.translatesAutoresizingMaskIntoConstraints = false
//        return sv
//    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(nicknameLabel)
        addSubview(weatherImageView)
        addSubview(weatherLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 50),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nicknameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            nicknameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
//            nicknameLabel.widthAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 1.5),
            
//            weatherImageView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            weatherImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            weatherImageView.leadingAnchor.constraint(equalTo: nicknameLabel.trailingAnchor, constant: 30),
            weatherImageView.widthAnchor.constraint(equalToConstant: 50),
            weatherImageView.heightAnchor.constraint(equalToConstant: 50),
            
            weatherLabel.centerYAnchor.constraint(equalTo: weatherImageView.centerYAnchor),
            weatherLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 5),
            weatherLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            weatherLabel.widthAnchor.constraint(equalTo: weatherImageView.widthAnchor, multiplier: 1.3),
        ])
    }

}

extension UIColor {
    convenience init(hexColor: String) {
        let hex = hexColor.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
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

