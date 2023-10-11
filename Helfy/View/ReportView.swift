//
//  ReportView.swift
//  Helfy
//
//  Created by 김하은 on 2023/10/11.
//

import UIKit

class ReportView: UIView {
    // SBS, KBS, MBC 버튼 생성 및 초기화
    let sbsButton: UIButton = createButton(withTitle: "SBS")
    let kbsButton: UIButton = createButton(withTitle: "KBS")
    let mbcButton: UIButton = createButton(withTitle: "MBC")

    static func createButton(withTitle title: String) -> UIButton {
        // 버튼 생성 메소드
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)

            // 버튼의 스타일을 설정
            button.backgroundColor = UIColor(hexString:"#F9DF56")
            button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.black, for:.normal)


            //Auto Layout을 사용하여 버튼의 너비와 높이를 설정. 스택뷰 내에서 적용
            button.heightAnchor.constraint(equalToConstant: 50).isActive = true
            button.widthAnchor.constraint(equalToConstant: 300).isActive = true

        return button

    }

    override init(frame:CGRect) {
        super.init(frame:frame)

        // UIStackView를 생성
        let stackView = UIStackView()
        stackView.axis = .vertical // 수직 스택뷰로 설정 (버튼들이 위 아래로 쌓이게 됨)
        stackView.alignment = .center // 중앙 정렬
        stackView.spacing = 40 // 버튼 사이의 간격 설정
        
        self.backgroundColor = UIColor.white

        // 버튼들을 UIStackView에 추가
        stackView.addArrangedSubview(sbsButton)
        stackView.addArrangedSubview(kbsButton)
        stackView.addArrangedSubview(mbcButton)

        // UIStackView를 view에 추가
        addSubview(stackView)

        // UIStackView의 Auto Layout 제약 조건 설정 (가운데 정렬)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 300).isActive = true // 원하는 너비로 설정
        stackView.heightAnchor.constraint(equalToConstant: 230).isActive = true // 원하는 높이로 설정
        

    }

    required init?(coder aDecoder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// HEX 문자열을 UIColor로 변환하는 extension
extension UIColor {
    convenience init(hexString: String) {
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.removeFirst()
        }

        if ((cString.count) != 6) {
            self.init(white: 1.0, alpha: 1.0)
            return
        }

        var rgbValue: UInt64 = 0
        let scanner = Scanner(string: cString)

        scanner.scanHexInt64(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
       )
    }
}
