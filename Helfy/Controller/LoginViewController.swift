//
//  LoginViewController.swift
//  Helfy
//
//  Created by 김하은 on 2023/10/10.
//

import UIKit
import GoogleSignIn

class LoginViewController : UIViewController {
    private let googleSigninButton : GIDSignInButton = {
        let button = GIDSignInButton()
        button.colorScheme = .light
        button.style = .iconOnly
        button.addTarget(self, action: #selector(didTapGoogleSigninButton), for: .touchUpInside)
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
    @objc func didTapGoogleSigninButton(_ sender: Any) {
        print("Google Sign in button tapped")
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//        let signInConfig = GIDConfiguration.init(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            self.textLabel.text = "Welcome To GoogleSignIn!"
            
            guard error == nil else { return }
            
            // If sign in succeeded, display the app's main content View.
            guard let signInResult = signInResult else { return }
            let user = signInResult.user
            
//            let emailAddress = user.profile?.email
            let fullName = user.profile?.name
//            let familyName = user.profile?.familyName
//            let profilePicUrl = user.profile?.imageURL(withDimension: 320)
            
            self.textLabel.text = "Hi \(fullName ?? "")"
            
        }
    }
}

