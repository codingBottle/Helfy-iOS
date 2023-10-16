//
//  LoginViewController.swift
//  Helfy
//
//  Created by 김하은 on 2023/10/10.
//

import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth
import FirebaseAppCheck


class LoginViewController : UIViewController {
    
    private let googleSigninButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.style = .standard
        button.colorScheme = .light
        button.addTarget(self, action: #selector(startSignInWithGoogleFlow), for: .touchUpInside)
        return button
    }()
    
    private var textLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
    }
    
    func configureUI() {
        view.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        view.addSubview(googleSigninButton)
        googleSigninButton.translatesAutoresizingMaskIntoConstraints = false
        googleSigninButton.topAnchor.constraint(equalTo: textLabel.topAnchor, constant: 50).isActive = true
        googleSigninButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        googleSigninButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
}

extension LoginViewController {
    @objc func startSignInWithGoogleFlow() {
        print("Google Sign in button tapped")
        self.textLabel.text = "Welcome To GoogleSignIn!"
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Sign in Flow
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let user = signInResult?.user,
                  let idToken = user.idToken?.tokenString else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            // firebase
            self.firebaseLogin(credential)
        }
        
    }
    
    func firebaseLogin(_ credential: AuthCredential) {
        // Firebase Auth
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Failed to login with Firebase: ", error)
                return
            }
            
            guard let user = authResult?.user else { return }
            let emailAddress = user.email ?? ""
            let fullName = user.displayName ?? ""
            let idToken = user.refreshToken ?? ""
            self.textLabel.text = "Hi \(fullName)"
        }
        
        // idToken Refresh
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true, completion: { [self] (idToken, error) in
            if let error = error {
                print("Error getting ID token:", error)
                return
            }
            
            guard let idToken = idToken else {
                print("ID token is nil")
                return
            }
            
            sendIDTokenToServer(idToken)
        })
    }
    
    func sendIDTokenToServer(_ idToken: String) {
        guard let url = URL(string: "https://helfy-server.duckdns.org/categories") else { return }
        
        var request = URLRequest(url: url)
        
        request.addValue("Bearer \(idToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error sending ID token to server:", error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Server returned an error")
                return
            }
            
            if let mimeType = httpResponse.mimeType,
               mimeType == "application/json",
               let data = data {
                
                do {
                    // 일단 Json 형식으로 출력 되게끔 작성
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options: [])
                    print(jsonDict)
                } catch {
                    print("Error parsing JSON:", error)
                }
            }
        }
        
        task.resume()
    }
}

