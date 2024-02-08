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
    let categoryViewController = CategoryViewController()

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

        // CategoryViewController를 메인뷰에 추가합니다.
       addChild(categoryViewController)
//       view.addSubview(categoryViewController.view)
       categoryViewController.didMove(toParent: self)
       
       // CategoryViewController.view의 위치와 크기를 설정합니다.
//        categoryViewController.view.frame = view.frame // 원하는 위치와 크기로 설정
                
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
                    self.mainView.weatherLabel.text = "\(data.weatherInfo.temp)℃ \(data.weatherInfo.humidity)%"
                }
            }
        }
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(mainView)
        view.addSubview(categoryViewController.view)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        categoryViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // mainView의 제약 설정
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: categoryViewController.view.topAnchor, constant: -100),

            categoryViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            categoryViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            categoryViewController.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            categoryViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        
        mainView.weatherImageView.image = UIImage(systemName: systemName)?.withTintColor(.darkGray, renderingMode: .alwaysOriginal)
    }
}


//    @objc private func openMyPage() {
//                print("😀😀😀😀😀😀😀😀😀")
//
//        let myPageViewController = MypageViewController()
//        myPageViewController.modalPresentationStyle = .fullScreen
//        self.present(myPageViewController, animated: true, completion: nil)
//    }
    
//    @objc private func openMyPage() {
//        print("😀😀😀😀😀😀😀😀😀")
//        let myPageViewController = MypageViewController()
//        self.navigationController?.pushViewController(myPageViewController, animated: true)
//    }

//class MainViewController: UIViewController {
//    
//    let welcomeLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.textAlignment = .center
//        return label
//    }()
//    
//    let logoutButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("로그아웃", for: .normal)
//        button.addTarget(self, action: #selector(tapLogoutButton), for: .touchUpInside)
//        return button
//    }()
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isHidden = true
//        
//        let email = Auth.auth().currentUser?.email ?? "고객"
//        
//        welcomeLabel.text = """
//        환영합니다.
//        \(email)님
//        """
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//        // pop 불가
//
//        view.addSubview(welcomeLabel)
//        view.addSubview(logoutButton)
//
//        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
//        logoutButton.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            logoutButton.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 20)
//        ])
//    }
//    
//    @objc func tapLogoutButton() {
//        
//        let firebaseAuth = Auth.auth()
//        do {
//            // google logout
//            GIDSignIn.sharedInstance.signOut()
//            try firebaseAuth.signOut()
//            self.navigationController?.popToRootViewController(animated: true)
//            print("popToRootViewController")
//            
//            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//                if let window = windowScene.windows.first {
//                    let navigationController = UINavigationController(rootViewController: LoginViewController())
//                    UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: {
//                        window.rootViewController = navigationController
//                    }, completion: nil)
//                }
//            }
//        } catch let signOutError as NSError {
//            print("ERROR: signOutError \(signOutError.localizedDescription)")
//        }
//    }
//}
//
