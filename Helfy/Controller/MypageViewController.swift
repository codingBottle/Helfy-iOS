//
//  MypageViewController.swift
//  Helfy
//
//  Created by 윤성은 on 11/8/23.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class MypageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let myPageView = MypageView()
    let imagePicker = UIImagePickerController()
    let editModalViewController = EditModalViewController()
    
    // 수정 버튼
    let editButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold)
        button.setImage(UIImage(systemName: "pencil", withConfiguration: configuration)?.withTintColor(UIColor(hex: "#F9A456"), renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // 로그아웃 버튼
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그아웃", for: .normal)
        button.setTitleColor(UIColor(hex: "#F9A456"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(tapLogoutButton), for: .touchUpInside)
        return button
    }()
    
    var myPageApiHandler : MyPageAPIHandler = MyPageAPIHandler()
    var myPageModelData: MypageModel? {
        didSet {
            print("hi")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()

        // 프로필 이미지 변경 버튼에 대한 액션 설정
        myPageView.profileImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        myPageView.profileImageView.addGestureRecognizer(tapGesture)

        // 프로필 이미지에 대한 액션 설정
        let tapGestureImage = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        myPageView.profileImageView.addGestureRecognizer(tapGestureImage)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(myPageView)

        DispatchQueue.global(qos: .userInteractive).async {
            // API 통해 데이터 불러오기
            self.myPageApiHandler.getMyPageData() { [weak self] data in
                guard let self = self else { return }
                // 정의해둔 모델 객체에 할당
                self.myPageModelData = data

                // 데이터를 제대로 잘 받아왔다면
                guard let data = self.myPageModelData else {
                    return print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
                }

                DispatchQueue.main.async {
                    self.myPageView.nicknameLabel.text = data.userInfo.nickname
                    let regionInKorean = self.editModalViewController.regionDictionary[data.userInfo.region] ?? data.userInfo.region
                    self.myPageView.regionLabel.text = regionInKorean
                    self.myPageView.rankLabel.text = String(data.rankInfo.rank)
                    self.myPageView.scoreLabel.text = String(data.rankInfo.score)
                }
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(myPageView)
        view.addSubview(editButton)
        view.addSubview(logoutButton)
        
        myPageView.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            editButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            myPageView.topAnchor.constraint(equalTo: view.topAnchor),
            myPageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            myPageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myPageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.topAnchor.constraint(equalTo: myPageView.containerStackView.bottomAnchor, constant: 100),
        ])

        view.backgroundColor = .white
    }
    
    // 이미지를 누르면 변경할 수 있는 버튼
    @objc private func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    // 프로필 이미지 업데이트
    func updateProfileImage(_ image: UIImage) {
        myPageView.profileImageView.image = image
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.updateProfileImage(selectedImage)
        } else if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.updateProfileImage(selectedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 이미지 닫기
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func editButtonTapped() {
        editModalViewController.modalPresentationStyle = .fullScreen
        editModalViewController.modalPresentationStyle = .overCurrentContext
        editModalViewController.modalTransitionStyle = .crossDissolve
        editModalViewController.nickname = myPageModelData?.userInfo.nickname
        editModalViewController.region = myPageModelData?.userInfo.region

        editModalViewController.onConfirm = { [weak self] nickname, region in
            // 서버에서 최신 데이터를 받아옵니다.
            self?.myPageApiHandler.getMyPageData() { data in
                self?.myPageModelData = data
                DispatchQueue.main.async {
                    self?.myPageView.nicknameLabel.text = data.userInfo.nickname
                    let regionInKorean = self?.editModalViewController.regionDictionary[region ?? ""] ?? region
                    self?.myPageView.regionLabel.text = regionInKorean
                }
            }
        }

        present(editModalViewController, animated: true, completion: nil)
    }

    
    @objc func tapLogoutButton() {
        let firebaseAuth = Auth.auth()
        do {
            // google logout
            GIDSignIn.sharedInstance.signOut()
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
            print("popToRootViewController")
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if let window = windowScene.windows.first {
                    let navigationController = UINavigationController(rootViewController: LoginViewController())
                    UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: {
                        window.rootViewController = navigationController
                    }, completion: nil)
                }
            }
        } catch let signOutError as NSError {
            print("ERROR: signOutError \(signOutError.localizedDescription)")
        }
    }
}
