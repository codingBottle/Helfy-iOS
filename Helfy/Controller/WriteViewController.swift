//
//  WriteViewController.swift
//  Helfy
//
//  Created by YEOMI on 10/13/23.
//
import UIKit
// 게시물에 대한 정보를 저장하는 클래스
class Post {
    var title: String = "" // 게시물의 제목
    var image: UIImage? = nil // 게시물의 이미지를 저장. 이미지가 없을 수도 있으므로 옵셔널로 선언
    var hashtags: [String] = [] // 게시물의 해시태그들을 저장
}

// 게시물을 작성하는 뷰 컨트롤러 클래스
class WriteViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let post = Post() // 게시물 객체 생성
    
    // 제목을 입력받는 텍스트 필드 생성
    private let titleField: UITextField = {
        let field = UITextField()
        field.placeholder = "제목"
        field.borderStyle = .roundedRect
        return field
    }()
    
    // 이미지를 보여주는 이미지 뷰 생성
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    // 이미지를 선택하는 버튼 생성
    private let imagePickerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("사진 선택", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // 해시태그를 입력받는 텍스트 필드 생성
    private let hashtagField: UITextField = {
        let field = UITextField()
        field.placeholder = "#해시태그"
        field.borderStyle = .roundedRect
        return field
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        // 위에서 생성한 각 요소들을 테이블 뷰에 추가
        tableView.addSubview(titleField)
        tableView.addSubview(imageView)
        tableView.addSubview(imagePickerButton)
        tableView.addSubview(hashtagField)
        
        setupUIConstraints() // UI 요소들의 위치와 크기를 설정하는 메서드를 호출
        
        titleField.delegate = self
        hashtagField.delegate = self
        
        // 이미지 선택 버튼이 클릭되었을 때의 동작을 설정
        imagePickerButton.addTarget(self, action: #selector(selectImageButtonTapped), for: .touchUpInside)
    }
    
    // UI 요소들의 위치와 크기를 설정하는 메서드
    private func setupUIConstraints() {
        titleField.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        hashtagField.translatesAutoresizingMaskIntoConstraints = false
        
        // 각 UI 요소들의 위치와 크기를 제약 조건을 통해 정의
        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            titleField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            titleField.heightAnchor.constraint(equalToConstant: 50),
            
            imageView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor), // 이미지 높이와 너비 동일
            
            imagePickerButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            imagePickerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            hashtagField.topAnchor.constraint(equalTo: imagePickerButton.bottomAnchor, constant: 10),
            hashtagField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            hashtagField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            hashtagField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // 이미지 선택 버튼이 클릭되었을 때의 동작을 정의하는 메서드
    @objc func selectImageButtonTapped() {
        let picker = UIImagePickerController() // 이미지를 선택할 수 있는 이미지 피커
        picker.sourceType = .photoLibrary // 이미지 피커의 소스 타입을 포토 라이브러리로 설정
        picker.delegate = self // 이미지 피커의 델리게이트를 self로 설정
        present(picker, animated: true) // 이미지 피커를 화면에 표시 
    }
    
    // 텍스트 필드에 문자를 입력할 때마다 호출되는 메서드
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == hashtagField, string == " " {
            textField.text = (textField.text ?? "") + " #" // 해시태그 필드에 공백 문자가 입력되면 자동으로 '#' 문자를 추가
            return false
        }
        return true
    }
    
    // 텍스트 필드의 편집이 끝났을 때 호출되는 메서드
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == hashtagField {
            post.hashtags.removeAll() // 해시태그 배열 초기화
            if let text = textField.text {
                var uniqueHashtags = Set<String>() // 중복된 해시태그를 제거하기 위해 Set을 사용
                let hashtags = text.split(separator: " ") // 텍스트를 공백 문자를 기준으로 분리
                for hashtag in hashtags where !hashtag.isEmpty {
                    // 해시태그가 '#' 문자로 시작하면 Set에 추가합니다.
                    if hashtag.hasPrefix("#") {
                        uniqueHashtags.insert(String(hashtag))
                    }
                }
                post.hashtags.append(contentsOf: uniqueHashtags) // 해시태그 배열에 추가
                print("Current Hashtags (final): \(post.hashtags)") // 해시태그 배열을 출력
                textField.text = uniqueHashtags.joined(separator: " ") // 중복이 제거된 해시태그들을 다시 텍스트 필드에 표시
            }
        }
    }
}
