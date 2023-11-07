//
//  GoogleSignIn.swift
//  Helfy
//
//  Created by 김하은 on 2023/10/16.
//

import UIKit
import FirebaseCore
import GoogleSignIn
import FirebaseAuth

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
}
