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
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let user = signInResult?.user,
                  let idToken = user.idToken?.tokenString else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            self.firebaseLogin(credential)
        }
        
    }
    
    func firebaseLogin(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Failed to login with Firebase: ", error)
                return
            }
            
            guard let user = authResult?.user else { return }
            let emailAddress = user.email ?? ""
            let fullName = user.displayName ?? ""
            self.textLabel.text = "Hi \(fullName)"
        }
    }
}

