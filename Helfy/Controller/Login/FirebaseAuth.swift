//
//  FirebaseAuth.swift
//  Helfy
//
//  Created by 김하은 on 2023/10/16.
//

import FirebaseAuth
import UIKit

extension LoginViewController {
    
    private func showMainViewController() {
        let mainViewController = MainViewController()
        mainViewController.modalPresentationStyle = .fullScreen
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.rootViewController?.show(mainViewController, sender: nil)
            }
        }
    }
    
    // firebase
    func firebaseLogin(_ credential: AuthCredential) {
        // Firebase Auth
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Failed to login with Firebase: ", error)
                return
            }
            
            self.showMainViewController()
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
    
    // sendIDTokenToServer
    func sendIDTokenToServer(_ idToken: String) {
        guard let url = URL(string: "https://helfy-server.duckdns.org/api/v1/categories") else { return }
        
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
