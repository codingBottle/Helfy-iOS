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
        communityView = CommunityView(frame: self.view.bounds)
        self.view.addSubview(communityView)
        
        // 네비게이션 바 설정
        setupNavigationBar()
        
        // 모든 버튼에 대해 이벤트 핸들러 설정
        for i in 0..<communityView.communityPosts.count {
            if let button = communityView.viewWithTag(i) as? UIButton {
                button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            }
        }            }
    
    @objc func buttonPressed(_ sender: UIButton) {
        // 버튼의 상위 뷰 탐색
        if let containerView = sender.superview {
            // 컨테이너 뷰에서 countLabel 찾기
            if let countLabel = containerView.viewWithTag(sender.tag + 1000) as? UILabel {
                if communityView.isButtonPressed[sender.tag] {
                    print("Button Tag: \(sender.tag), Count Label Tag: \(countLabel.tag)")
                    communityView.isButtonPressed[sender.tag] = false
                    let count = Int(countLabel.text!)! - 1
                    countLabel.text = "\(count)"
                } else {
                    communityView.isButtonPressed[sender.tag] = true
                    let count = Int(countLabel.text!)! + 1
                    countLabel.text = "\(count)"
                }
            }
        }
    }
    
}
