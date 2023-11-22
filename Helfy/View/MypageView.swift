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
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 27)
        return label
    }()
    
    // 지역
    let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 23)
        return label
    }()
    
    // 닉네임, 지역 변경 버튼
    let changeNicknameButton: UIButton = createButton(withTitle: "닉네임 변경")
    let changeLocationButton: UIButton = createButton(withTitle: "지역 변경")
    
    static func createButton(withTitle title: String) -> UIButton {
        let button = UIButton(type: .system)
        
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.black, for:.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.backgroundColor = UIColor(hexString:"#F9DF56")
        button.layer.cornerRadius = 20
        
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        return button
    }
    
    lazy var stackView: UIStackView = {
        let stackButton = UIStackView()
        stackButton.axis = .horizontal
        stackButton.alignment = .center
        stackButton.distribution = .fillEqually
        stackButton.spacing = 20
        
        return stackButton
    }()
    
    // 나중에 채울 버튼들
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ButtonCell")
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.black

        return tableView
    }()
    
    let buttons: [String] = ["뭐1", "뭐2", "뭐3", "뭐4", "문의"]
    
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
        addSubview(nicknameLabel)
        addSubview(locationLabel)
        addSubview(stackView)
        addSubview(tableView)
        addSubview(logoutButton)
        
        stackView.addArrangedSubview(changeNicknameButton)
        stackView.addArrangedSubview(changeLocationButton)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        
        let cellHeight: CGFloat = 44
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 110),
            profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            profileImageView.widthAnchor.constraint(equalToConstant: 200),
            profileImageView.heightAnchor.constraint(equalToConstant: 200),
            
            nicknameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 50),
            nicknameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 15),
            locationLabel.centerXAnchor.constraint(equalTo: nicknameLabel.centerXAnchor),

            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 30),

            tableView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tableView.heightAnchor.constraint(equalToConstant: (cellHeight + 8) * CGFloat(buttons.count)),
            
            logoutButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoutButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 35)
        ])
    }
    
    // User 정보를 기반으로 UI 업데이트
    func updateUserUI(user: User) {
        nicknameLabel.text = user.nickname
        locationLabel.text = user.location
    }
    
    // 프로필 이미지 업데이트
    func updateProfileImage(_ image: UIImage) {
        profileImageView.image = image
    }
}
