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
                    self.mainView.weatherImageView.image = UIImage(named: data.weatherCode)
                    self.mainView.weatherLabel.text = "\(data.temp)℃ \(data.humidity)%"
                }
            }
        }
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        view.addSubview(mainView)

        mainView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
