//
//  AppDelegate.swift
//  Helfy
//
//  Created by 김하은 on 2023/10/04.
//

import UIKit
import GoogleSignIn
import FirebaseCore
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var currentUser: User?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
          if error != nil || user == nil {
            // Show the app's signed-out state.
          } else {
              // Show the app's signed-in state.
              guard let firebaseUser = Auth.auth().currentUser else {
                  // firebaseUser is nil, handle this case as appropriate.
                  return
              }
              let user = User(uid: firebaseUser.uid,
                              email: firebaseUser.email,
                              photoURL: firebaseUser.photoURL)
              // Store the user information somewhere accessible in the app, for example in a property of AppDelegate
              self.currentUser = user
          }
        }
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
          var handled: Bool
        
          handled = GIDSignIn.sharedInstance.handle(url)
          if handled {
            return true
      }
      return false
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        
    }
    


}

