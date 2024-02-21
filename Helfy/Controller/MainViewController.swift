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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // MainView가 보일 때 네비게이션 바를 숨깁니다.
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // MainView가 사라질 때 네비게이션 바를 다시 보이도록 설정합니다.
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        setUI()
        
        mainView.profileButton.addTarget(self, action: #selector(openMyPage), for: .touchUpInside)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(handleProfileUpdate), name: Notification.Name("profileUpdated"), object: nil)
//        mainView.profileImageView.isUserInteractionEnabled = true
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openMyPage))
//        mainView.profileImageView.addGestureRecognizer(tapGesture)
        
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
                    self.updateWeatherImageView(with: data.weatherInfo.weatherCode)
                    self.mainView.weatherLabel.text = "\(data.weatherInfo.temp)℃ \n\(data.weatherInfo.humidity)%"
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

        // 메인 뷰 레이아웃 설정
        mainView.translatesAutoresizingMaskIntoConstraints = false
        searchViewController.view.translatesAutoresizingMaskIntoConstraints = false
        bannerViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            searchViewController.view.topAnchor.constraint(equalTo: mainView.nameLabel.bottomAnchor, constant: 20),
            searchViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchViewController.view.heightAnchor.constraint(equalToConstant: 60),

            bannerViewController.view.topAnchor.constraint(equalTo: searchViewController.view.bottomAnchor, constant: 50),
            bannerViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bannerViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bannerViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            mainView.bottomAnchor.constraint(equalTo: bannerViewController.view.bottomAnchor)
        ])

    }

    @objc func openMyPage() {
        print("😀😀😀😀😀😀😀😀😀")
        let myPageViewController = MypageViewController()
        myPageViewController.hidesBottomBarWhenPushed = true
        
        // MainViewController가 내장된 네비게이션 컨트롤러의 pushViewController(_:animated:) 메서드를 호출하여 myPageViewController를 푸시합니다.
        self.navigationController?.pushViewController(myPageViewController, animated: true)
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
        
        mainView.weatherImageView.image = UIImage(systemName: systemName)?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
    }
}
