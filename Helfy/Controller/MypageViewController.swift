//
//  MypageViewController.swift
//  Helfy
//
//  Created by 윤성은 on 11/8/23.
//

import UIKit
import MessageUI

class MypageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    let myPageView = MypageView()
    let imagePicker = UIImagePickerController()
    
    private let myPageModel: MypageModel
    private let user: User2
    
    init(user: User2) {
        self.user = user
        self.myPageModel = MypageModel(user: user)
        super.init(nibName: nil, bundle: nil)
        
        myPageView.tableView.delegate = self
        myPageView.tableView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        myPageView.updateUserUI(user: user)
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
    
    @objc private func didTableButton() {
        print("테이블 버튼이 눌렸습니다.")
    }
    
    // tableView 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPageView.buttons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell", for: indexPath)
        cell.textLabel?.text = myPageView.buttons[indexPath.row]
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        cell.textLabel?.textColor = UIColor.black
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedButton = myPageView.buttons[indexPath.row]
        switch selectedButton {
        case "뭐1":
            didTableButton()
        case "뭐2":
            didTableButton()
        case "뭐3":
            didTableButton()
        case "뭐4":
            didTableButton()
        case "문의":
            // "문의" 셀을 선택했을 때
            if MFMailComposeViewController.canSendMail() {
                let mailComposeViewController = MFMailComposeViewController()
                mailComposeViewController.mailComposeDelegate = self
                mailComposeViewController.setToRecipients(["Helfy@gmail.com"])
                mailComposeViewController.setSubject("문의") // 여기에 메일 제목을 설정하세요.
                
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                print("이 장치에서는 메일을 보낼 수 없습니다.")
            }
        
        default:
            break
        }
    }
    
    // 메일 작성을 완료하거나 취소했을 때 호출되는 메소드
    @objc(mailComposeController:didFinishWithResult:error:) func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
