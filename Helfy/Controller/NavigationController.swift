
//
//  NavigationController.swift
//  Helfy
//
//  Created by YEOMI on 10/13/23.
//
import UIKit

class NavigationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // View의 배경색 설정
        view.backgroundColor = .white

        // Navigation Bar 설정
        setupNavigationBar()
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
