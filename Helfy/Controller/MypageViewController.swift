//
//  MypageViewController.swift
//  Helfy
//
//  Created by 윤성은 on 11/8/23.
//

import UIKit
import MessageUI

class MypageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let myPageView = MypageView()
    let imagePicker = UIImagePickerController()
    var myPageApiHandler : MyPageAPIHandler = MyPageAPIHandler()
    var myPageModelData: MypageModel? {
        didSet {
            print("Hi")
        }
    }
    
//    private let myPageModel: MypageModel
//    private let user: User
    
//    init(user: User) {
//        self.user = user
//        self.myPageModel = MypageModel(user: user)
//        super.init(nibName: nil, bundle: nil)
//        
//        myPageView.tableView.delegate = self
//        myPageView.tableView.dataSource = self
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        setupUI()
//        myPageView.updateUserUI(user: user)
    }
    
    func setData() {
        DispatchQueue.global(qos: .userInteractive).async {
            
            // API 통해 데이터 불러오기
            self.myPageApiHandler.getMyPageData() { [self] data in
                // 정의해둔 모델 객체에 할당
                self.myPageModelData = data
                
                // 데이터를 제대로 잘 받아왔다면
                guard let data = self.myPageModelData else {
                    
                    return print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
                }
                
                DispatchQueue.main.async {
                    self.myPageView.nicknameTextField.text = data.nickname
                    self.myPageView.regionTextField.text = String(data.region)
                }
            }
        }
    }
    
    private func setupUI() {
        view.addSubview(myPageView)
        
        myPageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myPageView.topAnchor.constraint(equalTo: view.topAnchor),
            myPageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            myPageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myPageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        view.backgroundColor = .white
        
        // 프로필 이미지 변경 버튼에 대한 액션 설정
        myPageView.profileImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        myPageView.profileImageView.addGestureRecognizer(tapGesture)

        // 프로필 이미지에 대한 액션 설정
        let tapGestureImage = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        myPageView.profileImageView.addGestureRecognizer(tapGestureImage)
        
        // 버튼(닉네임 변경, 지역 변경, 로그아웃)에 대한 액션 설정
        myPageView.changeNicknameButton.addTarget(self, action:#selector(didTapChangeNicknameButton), for:.touchUpInside)
        myPageView.changeLocationButton.addTarget(self, action:#selector(didTapChangeLocationButton), for:.touchUpInside)
        myPageView.logoutButton.addTarget(self, action:#selector(didTapLogoutButton), for:.touchUpInside)
    }
    
    // 이미지를 누르면 변경할 수 있는 버튼
    @objc private func openImagePicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            myPageView.updateProfileImage(selectedImage)
        } else if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            myPageView.updateProfileImage(selectedImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 이미지 닫기
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapChangeNicknameButton() {
        print("닉네임 변경 버튼이 눌렸습니다.")
    }
    
    @objc private func didTapChangeLocationButton() {
        print("지역 변경 버튼이 눌렸습니다.")
    }
    
    @objc private func didTapLogoutButton() {
        print("로그아웃 버튼이 눌렸습니다.")
    }
}
