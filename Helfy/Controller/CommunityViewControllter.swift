//
//  CommunityViewControllter.swift
//  Helfy
//
//  Created by YEOMI on 11/13/23.
//

import UIKit

class CommunityViewController: UIViewController  {
    var communityView: CommunityView! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 뷰 생성 및 추가
        let communityView = CommunityView(frame: self.view.bounds)
        self.view.addSubview(communityView)
        
        // 네비게이션 바 설정
        setupNavigationBar()
    }
}
