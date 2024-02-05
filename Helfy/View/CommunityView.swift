//
//  CommunityView.swift
//  Helfy
//
//  Created by YEOMI on 11/13/23.
//
// CommunityView.swift
// Helfy
// Created by YEOMI on 11/13/23.

import UIKit


class CommunityView: UIView {
    let apiHandler = APIHandler()
    
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
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var communityPosts: [CreatePost] = [
        // 커뮤니티 게시물을 여기에 추가
        CreatePost(title: "안전사고", content: "게시글 내용", hashTag: "#ㅇㅇ동 #안전사고 #조심", imageName: "img2"),
        CreatePost(title: "안전사고", content: "게시글 내용", hashTag: "#ㅇㅇ동 #안전사고 #조심", imageName: "img2"),
    ]
    /*
     CommunityModel(title: "안전사고", content: "게시글 내용", hashTag: "#ㅇㅇ동 #안전사고 #조심", imageName: "img2"),
     CommunityModel(title: "안전사고", content: "게시글 내용", hashTag: "#ㅇㅇ동 #안전사고 #조심", imageName: "imageName"),
     CommunityModel(title: "안전사고", content: "게시글 내용", hashTag: "#ㅇㅇ동 #안전사고 #조심", imageName: "imageName"),
     CommunityModel(title: "안전사고 발생했으니 조심하세요", content: "게시글 내용", hashTag: "#ㅇㅇ동 #안전사고 #조심", imageName: "imageName")
     ]
     */
    // 게시글별로 버튼이 눌렸는지 여부를 저장하는 배열
    var isButtonPressed: [Bool] = []
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        isButtonPressed = Array(repeating: false, count: communityPosts.count)
        // UIScrollView 추가
        self.addSubview(scrollView)
        
        // UIStackView 추가
        scrollView.addSubview(stackView)
        
        
        // UIScrollView의 제약조건 설정
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        // UIStackView의 제약조건 설정
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20 ),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20 ),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40 )
        ])
        
        // 게시글 뷰
        for (index, post) in communityPosts.enumerated() {
            let postView = UIView()
            
            postView.layer.cornerRadius = 20 // 모서리 둥글게 설정
            postView.translatesAutoresizingMaskIntoConstraints = false
            postView.heightAnchor.constraint(equalToConstant: 100).isActive = true
            postView.backgroundColor = UIColor(red: 249/255, green: 223/255, blue: 86/255, alpha: 1.0) // F9DF56으로 색 설정
            
            let button = UIButton(type: .system) // 버튼 생성
            button.setImage(UIImage(systemName: "megaphone"), for: .normal) // 아이콘 설정
            button.tintColor = .black // 아이콘 색상 설정. 원하는 색상으로 변경 가능
            button.translatesAutoresizingMaskIntoConstraints = false
            button.tag = index
            postView.addSubview(button)
            
            NSLayoutConstraint.activate([
                button.bottomAnchor.constraint(equalTo: postView.bottomAnchor, constant: -10), // postView 아래쪽에 10포인트 여백을 두고 배치
                button.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 20), // postView 왼쪽에 10포인트 여백을 두고 배치
                button.widthAnchor.constraint(equalToConstant: 23), // 버튼의 너비 설정
                button.heightAnchor.constraint(equalToConstant: 23) // 버튼의 높이 설정
            ])
            
            // 게시글 뷰 내부의 스택뷰 생성
            let postStackView = UIStackView()
            postStackView.axis = .horizontal
            postStackView.spacing = 0
            postStackView.alignment = .center
            postStackView.translatesAutoresizingMaskIntoConstraints = false
            postView.addSubview(postStackView)
            
            // 게시글 뷰 내부의 스택뷰 제약조건 설정
            NSLayoutConstraint.activate([
                postStackView.topAnchor.constraint(equalTo: postView.topAnchor),
                postStackView.bottomAnchor.constraint(equalTo: postView.bottomAnchor),
                postStackView.leadingAnchor.constraint(equalTo: postView.leadingAnchor,constant: 20),
                postStackView.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -20)
            ])
            
            let imageView = UIImageView() // 이미지 뷰 생성
            imageView.image = UIImage(named: post.imageName)
            imageView.backgroundColor = .clear // 배경색 설정
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: 70).isActive = true // 이미지 뷰 너비 설정
            imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true // 이미지 뷰 높이 설정
            
            imageView.isUserInteractionEnabled = true // 이미지 뷰를 터치 가능하도록
            // 터치 제스처 추가
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            imageView.addGestureRecognizer(tapGesture)
            
            
            
            
            let titleLabel = UILabel() // 타이틀 라벨 생성
            titleLabel.text = post.content // 텍스트 설정
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.numberOfLines = 0 // 줄 수를 자동으로 조절하도록 설정
            titleLabel.lineBreakMode = .byWordWrapping // 단어 단위로 줄 바꿈 처리
            
            let hashtagLabel = UILabel() // 해시태그 라벨 생성
            hashtagLabel.text = post.hashTag // 텍스트 설정
            hashtagLabel.translatesAutoresizingMaskIntoConstraints = false
            hashtagLabel.textAlignment = .right // 오른쪽 정렬
            
            // 타이틀 라벨과 해시태그 라벨을 위아래로 배치하는 또 다른 스택뷰 생성
            let labelStackView = UIStackView()
            labelStackView.axis = .vertical // 위 아래로 배치
            labelStackView.spacing = 15
            labelStackView.translatesAutoresizingMaskIntoConstraints = false
            labelStackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10) // 오른쪽에 마진 추가
            labelStackView.isLayoutMarginsRelativeArrangement = true // 마진 설정 적용
            labelStackView.addArrangedSubview(titleLabel)
            labelStackView.addArrangedSubview(hashtagLabel)
            postStackView.addArrangedSubview(labelStackView)
            postStackView.addArrangedSubview(imageView)
            stackView.addArrangedSubview(postView)
            
            
            // 버튼과 레이블을 함께 담을 수 있는 스택뷰 생성
            let buttonAndLabelStackView = UIStackView()
            buttonAndLabelStackView.axis = .horizontal // 가로 방향으로 요소 배치
            buttonAndLabelStackView.spacing = 10 // 요소 사이 간격 설정
            buttonAndLabelStackView.translatesAutoresizingMaskIntoConstraints = false
            
            let countLabel = UILabel()
            countLabel.text = "0"
            countLabel.tag = index + 1000
            countLabel.translatesAutoresizingMaskIntoConstraints = false
            
            // 버튼과 레이블을 스택뷰에 추가
            buttonAndLabelStackView.addArrangedSubview(button)
            buttonAndLabelStackView.addArrangedSubview(countLabel)
            
            // 스택뷰를 postView에 추가
            postView.addSubview(buttonAndLabelStackView)
            
            // 스택뷰에 대한 레이아웃 제약조건 추가
            NSLayoutConstraint.activate([
                buttonAndLabelStackView.bottomAnchor.constraint(equalTo: postView.bottomAnchor, constant: -10), // postView 아래쪽에 10포인트 여백을 두고 배치
                buttonAndLabelStackView.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 20) // postView 왼쪽에 20포인트 여백을 두고 배치
            ])
            
            // 스택뷰를 postView에 추가
            postView.addSubview(buttonAndLabelStackView)
            
            // 스택뷰에 대한 레이아웃 제약조건 추가
            NSLayoutConstraint.activate([
                buttonAndLabelStackView.bottomAnchor.constraint(equalTo: postView.bottomAnchor, constant: -10), // postView 아래쪽에 10포인트 여백을 두고 배치
                buttonAndLabelStackView.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 20) // postView 왼쪽에 20포인트 여백을 두고 배치
            ])
            
            stackView.addArrangedSubview(postView)
        }
        
    }
    var tappedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedImageView = sender.view as? UIImageView else { return }
        
        // 이미지가 터치되었을 때의 동작을 정의
        
        // 확대된 이미지를 담을 이미지 뷰 생성
        let zoomedImageView = UIImageView(image: tappedImageView.image)
        zoomedImageView.contentMode = .scaleAspectFit
        zoomedImageView.frame = UIScreen.main.bounds
        
        // 확대된 이미지를 담을 뷰 생성
        let zoomedView = UIView(frame: UIScreen.main.bounds)
        zoomedView.backgroundColor = .black
        zoomedView.addSubview(zoomedImageView)
        
        // 확대된 이미지 뷰를 탭했을 때 원래 크기로 돌아가는 동작을 위한 탭 제스처 생성
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissZoomedView(_:)))
        zoomedView.addGestureRecognizer(tapGesture)
        
        // 현재 윈도우에 확대된 이미지 뷰를 추가
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.addSubview(zoomedView)
        }
    }
    
    @objc func dismissZoomedView(_ sender: UITapGestureRecognizer) {
        // 확대된 이미지 뷰를 탭했을 때 해당 뷰를 제거
        sender.view?.removeFromSuperview()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setData() {
        DispatchQueue.global(qos: .userInteractive).async {
            // API를 통해 데이터 불러오기
            self.apiHandler.getPost(page: 1, size: 10, sort: ["createdAt"]) { result in
                switch result {
                case .success(let responseData):
                    // 정의해둔 모델 객체에 할당
                    self.postResponseData = responseData
                    
                    // 데이터를 제대로 잘 받아왔다면
                    guard let responseData = self.postResponseData else {
                        return
                    }
                    
                    // 이미지 URL을 가져오고 처리하는 로직
                    for postContent in responseData.content {
                        guard let url = URL(string: postContent.image.imageURL) else {
                            print("Invalid URL")
                            continue
                        }
                        
                        // 이미지를 로드하고 UI를 업데이트
                        ImageLoader.loadImage(url: url.absoluteString) { [weak self] image in
                            DispatchQueue.main.async {
                                self?.tappedImageView.image = image
                            }
                        }
                    }
                    
                case .failure(let error):
                    // 데이터를 제대로 받지 못한 경우 에러 처리
                    print("Failed to fetch data: \(error.localizedDescription)")
                }
            }
        }
    }
}
