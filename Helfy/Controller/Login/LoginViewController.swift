//
//  LoginViewController.swift
//  Helfy
//
//  Created by 김하은 on 2023/10/10.
//

import UIKit
import GoogleSignIn
import AuthenticationServices
import FirebaseCore
import FirebaseAuth
import CryptoKit

class LoginViewController : UIViewController {
    // Google Sign In Flow -> GoogleSignIn
    private let googleSigninButton : GIDSignInButton = {
        let button = GIDSignInButton()
        button.colorScheme = .light
        button.style = .iconOnly
        button.addTarget(self, action: #selector(startSignInWithGoogleFlow), for: .touchUpInside)
        return button
    }()
    
    // Apple Sign In Flow -> AppleSignIn
    private let appleSigninButton: ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton()
        button.addTarget(self, action: #selector(startSignInWithAppleFlow), for: .touchUpInside)
        return button
    }()
    
    private var currentNonce: String?
    
    // View가 보이기 직전
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비게이션 바 숨기기
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(googleSigninButton)
        googleSigninButton.translatesAutoresizingMaskIntoConstraints = false
        googleSigninButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        googleSigninButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        googleSigninButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        view.addSubview(appleSigninButton)
        appleSigninButton.translatesAutoresizingMaskIntoConstraints = false
        appleSigninButton.topAnchor.constraint(equalTo: googleSigninButton.bottomAnchor, constant: 20).isActive = true
        appleSigninButton.leadingAnchor.constraint(equalTo: googleSigninButton.leadingAnchor, constant: 20).isActive = true
        appleSigninButton.trailingAnchor.constraint(equalTo: googleSigninButton.trailingAnchor, constant: -20).isActive = true
    }
    
    @objc func startSignInWithGoogleFlow() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let signInConfig = GIDConfiguration.init(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { user, error in
            guard error == nil else { return }
            
            guard let user = user?.user,
                  let idToken = user.idToken?.tokenString else { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            self.firebaseLogin(credential)
        }
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    
    // controller로 인증 정보 값을 받게 되면은, idToken 값을 받음
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            // token들로 credential을 구성해서 auth signin 구성 (google과 동일)
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            self.firebaseLogin(credential)
        }
    }
}

extension LoginViewController {
    @objc func startSignInWithAppleFlow() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            return String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
    
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
}

extension LoginViewController : ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
