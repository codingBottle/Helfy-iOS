//
//  WriteViewController.swift
//  Helfy
//
//  Created by YEOMI on 10/13/23.
//
import UIKit
//데이터 모델 객체
var postData: CreatePost?{
    didSet {
        print("data fetch completed")
    }
}
var CreateResponseData: CreatePostResponse?{
    didSet {
        print("data fetch completed")
    }
}
var ImageData: Image?{
    didSet {
        print("data fetch completed")
    }
}
var getData: GetPost?{
    didSet {
        print("data fetch completed")
    }
}
var postResponseData: GetPostResponse?{
    didSet {
        print("data fetch completed")
    }
}
var postContentData: PostContent?{
    didSet {
        print("data fetch completed")
    }
}
var postImageData: PostImage?{
    didSet {
        print("data fetch completed")
    }
}
var postPageableData: PostPageable?{
    didSet {
        print("data fetch completed")
    }
}
var postSortData: PostSort?{
    didSet {
        print("data fetch completed")
    }
}

// 게시물에 대한 정보를 저장하는 클래스
class Post {
    var title: String = "" // 게시물의 제목
    var image: UIImage? = nil // 게시물의 이미지를 저장. 이미지가 없을 수도 있으므로 옵셔널로 선언
    var hashtags: [String] = [] // 게시물의 해시태그들을 저장
}

// 게시물을 작성하는 뷰 컨트롤러 클래스
class WriteViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate,UITextViewDelegate {
    
    let post = Post() // 게시물 객체 생성
    
    // 제목을 입력받는 텍스트 필드 생성
    private let titleField: UITextField = {
        let field = UITextField()
        field.placeholder = "제목"
        field.borderStyle = .roundedRect
        return field
    }()
    // 게시물 내용을 입력받는 텍스트 뷰 생성
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.text = "내용" // 기본 텍스트 설정
        textView.textColor = UIColor.lightGray // 기본 텍스트의 색상 설정
        textView.font = UIFont.systemFont(ofSize: 14.0) // 기본 텍스트의 글꼴 설정
        textView.layer.cornerRadius = 8.0 // 모서리 둥글게 설정
        textView.clipsToBounds = true // 모서리를 둥글게 설정할 때, 텍스트 뷰가 넘치는 것을 방지합니다.
        
        return textView
    }()
    
    //기본 텍스트 삭제
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           picker.dismiss(animated: true, completion: nil)
           
           // 이미지 피커에서 선택한 이미지를 가져옵니다.
           guard let selectedImage = info[.originalImage] as? UIImage else {
               print("Error: No image found")
               return
           }
           
           // 선택한 이미지를 이미지뷰에 설정합니다.
           imageView.image = selectedImage
       }
   
    // 해시태그를 입력받는 텍스트 필드 생성
    private let hashtagField: UITextField = {
        let field = UITextField()
        field.placeholder = "#해시태그"
        field.borderStyle = .roundedRect
        return field
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 249/255, green: 223/255, blue: 86/255, alpha: 1.0)

        // 위에서 생성한 각 요소들을 테이블 뷰에 추가
        tableView.addSubview(titleField)
        tableView.addSubview(contentTextView)
        tableView.addSubview(imageView)
        tableView.addSubview(imagePickerButton)
        tableView.addSubview(hashtagField)
        
        setupUIConstraints() // UI 요소들의 위치와 크기를 설정하는 메서드를 호출
        
        titleField.delegate = self
        hashtagField.delegate = self
        contentTextView.delegate = self
        
        // 이미지 선택 버튼이 클릭되었을 때의 동작을 설정
        imagePickerButton.addTarget(self, action: #selector(selectImageButtonTapped), for: .touchUpInside)
        // 저장 버튼을 추가하고 레이아웃을 설정
           let saveButton = UIButton(type: .system)
           saveButton.setTitle("저장", for: .normal)
           saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
           
           // 뷰에 저장 버튼을 추가
           view.addSubview(saveButton)
           
           // 저장 버튼의 레이아웃을 설정
           saveButton.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               saveButton.topAnchor.constraint(equalTo: hashtagField.bottomAnchor, constant: 20),
               saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               saveButton.widthAnchor.constraint(equalToConstant: 100),
               saveButton.heightAnchor.constraint(equalToConstant: 40)
           ])
    }
    
    // UI 요소들의 위치와 크기를 설정하는 메서드
    private func setupUIConstraints() {
        titleField.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        hashtagField.translatesAutoresizingMaskIntoConstraints = false
        contentTextView.translatesAutoresizingMaskIntoConstraints = false
        
        // 각 UI 요소들의 위치와 크기를 제약 조건을 통해 정의
        NSLayoutConstraint.activate([
            titleField.topAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            titleField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            titleField.heightAnchor.constraint(equalToConstant: 50),
            
            contentTextView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20),
                        contentTextView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                        contentTextView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                        contentTextView.heightAnchor.constraint(equalToConstant: 75),
            
            imageView.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: 20),
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
        tableView.contentSize = CGSize(width: view.frame.width, height: contentTextView.frame.maxY + 20)
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
    // 글을 저장하는 함수
    func savePost() {
        // 제목과 내용을 가져옵니다.
        guard let title = titleField.text,
              let content = contentTextView.text else {
            print("Error: 제목 또는 내용을 입력해주세요.")
            return
        }
        
        // 이미지를 업로드하고, 성공하면 이미지 URL을 받아옵니다.
        if let imageData = imageView.image?.jpegData(compressionQuality: 0.5) {
            // 이미지가 선택된 경우
            APIHandler().ImageUploadFunction(imageData) { result in
                switch result {
                case .success(let imageURL):
                    // 이미지 업로드 성공한 경우, 게시글 정보를 서버에 전송합니다.
                    let postData = CreatePost(title: title, content: content, hashTag: "", imageName: imageURL)
                    self.callCreatePostAPI(with: postData)
                case .failure(let error):
                    // 이미지 업로드 실패
                    print("이미지 업로드에 실패했습니다: \(error.localizedDescription)")
                    // 이미지 업로드가 실패해도 createPost를 호출할 수 있도록 원하는 동작을 수행합니다.
                    let postData = CreatePost(title: title, content: content, hashTag: "", imageName: "")
                    self.callCreatePostAPI(with: postData)
                }
            }
        } else {
            // 이미지를 선택하지 않은 경우
            let postData = CreatePost(title: title, content: content, hashTag: "", imageName: "")
            self.callCreatePostAPI(with: postData)
        }
    }

        // createPost 호출하는 함수
        func callCreatePostAPI(with postData: CreatePost) {
            APIHandler().createPost(postData: postData) { result in
                switch result {
                case .success(_):
                    // 게시글 작성 성공
                    print("게시글이 성공적으로 작성되었습니다.")
                    // 여기에 필요한 추가 작업 수행
                case .failure(let error):
                    // 게시글 작성 실패
                    print("게시글 작성에 실패했습니다: \(error.localizedDescription)")
                }
            
        }

    }


    // 서버에 이미지를 업로드하는 함수
    func yourImageUploadFunction(_ imageData: Data, completion: @escaping (Result<String, Error>) -> Void) {
        // 이미지를 서버에 업로드하고, 업로드된 이미지의 URL을 반환합니다.
        // 네트워크 요청 등의 비동기 작업을 수행합니다.
        // 성공 시 imageURL을 반환하고, 실패 시 에러를 반환합니다.
    }

    // 서버에 게시글을 생성하는 함수
    func yourPostCreateFunction(_ post: CreatePost, completion: @escaping (Result<Void, Error>) -> Void) {
        // 게시글 정보를 서버에 전송하여 데이터베이스에 저장합니다.
        // 네트워크 요청 등의 비동기 작업을 수행합니다.
        // 성공 시에는 success를 반환하고, 실패 시에는 에러를 반환합니다.
    }

    
    // 글 저장 버튼이 클릭되었을 때의 동작을 정의하는 메서드
    @objc func saveButtonTapped() {
        savePost() // 글을 저장하는 함수 호출
        print("Save button tapped")
        
        // 저장 완료 후 필요한 후속 동작을 수행할 수 있습니다.
        // 예를 들어, 저장 완료 알림을 표시하거나 이전 화면으로 돌아가는 등의 동작을 구현할 수 있습니다.
    }
    
    

}

