//
//  MypageModel.swift
//  Helfy
//
//  Created by 윤성은 on 11/8/23.
//

import UIKit

// MARK: - MypageModel
struct MypageModel: Codable {
    let region, nickname: String
}


// User 모델 클래스
//class User {
//    var nickname: String
//    var location: String
//    
//    init(nickname: String, location: String) {
//        self.nickname = nickname
//        self.location = location
//    }
//}
//
//class MypageModel {
//    var user: User
//    
//    init(user: User) {
//        self.user = user
//    }
//    
//    // myPageView를 사용하여 UI를 업데이트하는 메서드
//    func updateUI() {
//        let myPageView = MypageView()
//        myPageView.nicknameLabel.text = user.nickname
//        myPageView.locationLabel.text = user.location
//    }
//}
