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
    private func setupNavigationBar() {

        // 첫 번째 버튼 생성 (WriteView로 이동)
        let firstButton = createCustomBarButton(imageName: "highlighter", text: " 글쓰기", action: #selector(firstButtonTapped))


        // 두 번째 버튼 생성 (ReportView로 이동)
        let secondButton = createCustomBarButton(imageName: "lightbulb.min.badge.exclamationmark", text: "제보하기", action: #selector(secondButtonTapped))

         // 오른쪽 아이템으로 추가
         navigationItem.rightBarButtonItems = [secondButton ,firstButton]

        //네비게이션바 community
        let titleLabel = UILabel()
                 titleLabel.text = "Community"

                 titleLabel.font = UIFont.systemFont(ofSize: 30, weight:.semibold)  // 폰트 크기와 굵기 조정
                 
                 titleLabel.textAlignment = .left  // 왼쪽 정렬
                  navigationItem.leftBarButtonItem=UIBarButtonItem(customView:titleLabel)

    }

    private func createCustomBarButton(imageName: String, text:String, action: Selector) -> UIBarButtonItem {
                let button = UIButton(type:.system)
                button.setImage(UIImage(systemName:imageName), for:.normal)
                button.addTarget(self, action:action, for:.touchUpInside)
                button.tintColor = .black
                button.imageView?.contentMode = .scaleAspectFit

            button.widthAnchor.constraint(equalToConstant: 30).isActive = true
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true



                let label = UILabel()
                label.text=text
        label.font=UIFont(name:"Helvetica-Bold", size :8.5)


                let stackView=UIStackView(arrangedSubviews:[button,label])
                stackView.spacing = 5
                stackView.axis = .vertical

                return UIBarButtonItem(customView:stackView)
         }


    @objc private func firstButtonTapped() {
       let writeViewController = WriteViewController()
       navigationController?.pushViewController(writeViewController, animated: true)
    }

    @objc private func secondButtonTapped() {
        let reportViewController = ReportViewController()
        navigationController?.pushViewController(reportViewController, animated: true)
    }

}
