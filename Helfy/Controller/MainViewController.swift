//
//  MainViewController.swift
//  Helfy
//
//  Created by 김하은 on 2023/11/29.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class MainViewController: UIViewController {
    let searchViewController = SearchViewController()
    let bannerViewController = BannerViewController() // 배너 뷰 컨트롤러 추가
    let mainView = MainView()
    
    var mainApiHandler : MainAPIHandler = MainAPIHandler()
    var mainModelData: MainModel? {
        didSet {
            print("hi")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
        setData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleProfileUpdate), name: Notification.Name("profileUpdated"), object: nil)
                
        mainView.profileImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openMyPage))
        mainView.profileImageView.addGestureRecognizer(tapGesture)
        
    }
    
    func setData() {
        DispatchQueue.global(qos: .userInteractive).async {
            // API 통해 데이터 불러오기
            self.mainApiHandler.getMainData() { [weak self] data in
                guard let self = self else { return }
                // 정의해둔 모델 객체에 할당
                self.mainModelData = data
                
                // 데이터를 제대로 잘 받아왔다면
                guard let data = self.mainModelData else {
                    return print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
                }
                
                DispatchQueue.main.async {
                    self.mainView.nicknameLabel.text = data.userInfo.nickname
                    self.updateWeatherImageView(with: data.weatherInfo.weatherCode)  // 이미지 뷰의 이미지를 갱신합니다.
                }
            }
        }
    }
    
    func setUI() {
        view.backgroundColor = .white
        // 배너 뷰 컨트롤러를 현재 뷰 컨트롤러에 추가
        addChild(bannerViewController)
        view.addSubview(bannerViewController.view)
        bannerViewController.didMove(toParent: self)

        addChild(searchViewController)
        view.addSubview(searchViewController.view)
        searchViewController.didMove(toParent: self)

        view.addSubview(mainView)

        // 프로필 이미지 뷰 레이아웃 설정
        mainView.profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            mainView.profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainView.profileImageView.widthAnchor.constraint(equalToConstant: 60), // 프로필 이미지의 너비 설정
            mainView.profileImageView.heightAnchor.constraint(equalToConstant: 60) // 프로필 이미지의 높이 설정
        ])

        // 검색 뷰 컨트롤러 레이아웃 설정
        searchViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchViewController.view.leadingAnchor.constraint(equalTo: mainView.profileImageView.trailingAnchor, constant: -10),
            searchViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            searchViewController.view.heightAnchor.constraint(equalToConstant: 60) // 검색 바의 높이 설정
        ])

        // 메인 뷰 레이아웃 설정
        mainView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: searchViewController.view.topAnchor), // 검색 바 아래에 위치하도록 설정
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bannerViewController.view.topAnchor)
        ])
    }



    @objc func openMyPage() {
        print("😀😀😀😀😀😀😀😀😀")
        let myPageViewController = MypageViewController()
        let mainViewController = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        navigationController.pushViewController(myPageViewController, animated: true)
    }
    
    @objc func handleProfileUpdate(notification: NSNotification) {
        DispatchQueue.main.async { [weak self] in
            if let userInfo = notification.userInfo, let nickname = userInfo["nickname"] as? String {
                self?.mainView.nicknameLabel.text = nickname
            }
        }
    }

    func updateWeatherImageView(with weatherCode: String) {
        let systemName: String
        switch weatherCode {
        case "THUNDERSTORM":
            systemName = "cloud.bolt.rain.fill"  // 번개 이미지
        case "DRIZZLE":
            systemName = "cloud.drizzle.fill"  // 이슬비 이미지
        case "RAIN":
            systemName = "cloud.rain.fill"  // 비 이미지
        case "SNOW":
            systemName = "cloud.snow.fill"  // 눈 이미지
        case "ATMOSPHERE":
            systemName = "cloud.fog.fill"  // 대기 이미지
        case "CLEAR":
            systemName = "sun.max.fill"  // 맑음 이미지
        case "CLOUDS":
            systemName = "cloud.fill"  // 구름 이미지
        default:
            systemName = "questionmark.diamond.fill"  // 기본 이미지
        }
        
       
    }
}
