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
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "person.circle.fill")
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 100
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // 닉네임
//    let nicknameLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.font = UIFont.boldSystemFont(ofSize: 27)
//        return label
//    }()
    
    // 지역
//    let regionLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.font = UIFont.boldSystemFont(ofSize: 23)
//        return label
//    }()
    
    // 닉네임
    let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.boldSystemFont(ofSize: 27)
        return textField
    }()

    // 지역
    let regionTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .black
        textField.font = UIFont.boldSystemFont(ofSize: 23)
        return textField
    }()

    
    // 닉네임, 지역 변경 버튼
//    let changeNicknameButton: UIButton = createButton(withTitle: "닉네임 변경")
//    let changeLocationButton: UIButton = createButton(withTitle: "지역 변경")
    
//    static func createButton(withTitle title: String) -> UIButton {
//        let button = UIButton(type: .system)
//        
//        button.setTitle(title, for: .normal)
//        button.setTitleColor(UIColor.black, for:.normal)
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
//        button.backgroundColor = UIColor(hexString:"#F9DF56")
//        button.layer.cornerRadius = 20
//        
//        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
//        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
//        
//        return button
//    }
    
    lazy var stackView: UIStackView = {
        let stackButton = UIStackView()
        stackButton.axis = .vertical
        stackButton.alignment = .center
        stackButton.distribution = .fillEqually
        stackButton.spacing = 20
        
        return stackButton
    }()
    
    // 로그아웃 버튼
    let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
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
        addSubview(nicknameTextField)
        addSubview(regionTextField)
        addSubview(stackView)
        addSubview(logoutButton)
        
        stackView.addArrangedSubview(nicknameTextField)
        stackView.addArrangedSubview(regionTextField)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nicknameTextField.translatesAutoresizingMaskIntoConstraints = false
        regionTextField.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        let cellHeight: CGFloat = 44
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 110),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            profileImageView.widthAnchor.constraint(equalToConstant: 200),
            profileImageView.heightAnchor.constraint(equalToConstant: 200),
            
            nicknameTextField.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 50),
            nicknameTextField.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            
            regionTextField.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 15),
            regionTextField.centerXAnchor.constraint(equalTo: nicknameTextField.centerXAnchor),

            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30),

            logoutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoutButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 35)
        ])
    }
    
    // User 정보를 기반으로 UI 업데이트
//    func updateUserUI(user: User) {
//        nicknameLabel.text = user.nickname
//        locationLabel.text = user.location
//    }
    
    // 프로필 이미지 업데이트
    func updateProfileImage(_ image: UIImage) {
        profileImageView.image = image
    }
}
