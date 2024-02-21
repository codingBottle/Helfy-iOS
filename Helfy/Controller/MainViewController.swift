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
    let bannerViewController = BannerViewController()
    let mainView = MainView()
    
    let profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "person.fill"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.contentMode = .center
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.clipsToBounds = true
        button.isEnabled = true
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var mainApiHandler : MainAPIHandler = MainAPIHandler()
    var mainModelData: MainModel? {
        didSet {
            print("hi")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        setUI()
        
        self.profileButton.addTarget(self, action: #selector(openMyPage), for: .touchUpInside)
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

        view.addSubview(mainView)
        view.addSubview(profileButton)

        addChild(bannerViewController)
        view.insertSubview(bannerViewController.view, aboveSubview: mainView)
        bannerViewController.didMove(toParent: self)

        addChild(searchViewController)
        view.insertSubview(searchViewController.view, aboveSubview: mainView)
        searchViewController.didMove(toParent: self)

        searchViewController.view.translatesAutoresizingMaskIntoConstraints = false
        bannerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            profileButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            profileButton.widthAnchor.constraint(equalToConstant: 50),
            profileButton.heightAnchor.constraint(equalToConstant: 50),

            searchViewController.view.topAnchor.constraint(equalTo: mainView.nameLabel.bottomAnchor, constant: 20),
            searchViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchViewController.view.heightAnchor.constraint(equalToConstant: 60),

            bannerViewController.view.topAnchor.constraint(equalTo: searchViewController.view.bottomAnchor, constant: 50),
            bannerViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bannerViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bannerViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }


    @objc func openMyPage() {
        print("😀😀😀😀😀😀😀😀😀")
        let myPageViewController = MypageViewController()
        myPageViewController.hidesBottomBarWhenPushed = true
        
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
