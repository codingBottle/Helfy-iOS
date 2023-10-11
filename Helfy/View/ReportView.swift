//
//  ReportView.swift
//  Helfy
//
//  Created by YEOMI on 2023/10/07.
//
// ReportView.swift
import Foundation
import UIKit

class TextView: UIView {
    // 제보하기 라벨 생성
    let label: UILabel = {
        let label = UILabel()
        label.text = "제보하기"
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    // 설명 라벨
        let subText: UILabel = {
            let label = UILabel()
            label.text = "버튼을 누르면 해당 방송국의 제보 사이트로 이동합니다."
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: 15)
            return label
        }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        // UIView에 제보하기 라벨 추가
        addSubview(label)
        
        // 제보하기 라벨의 위치 및 크기 설정 (상단 중앙에 배치)
        /*
            - centerXAnchor를 사용하여 가로 중앙 정렬 설정.
            - topAnchor와 constant를 사용하여 상단에서 일정한 간격(70 포인트)으로 배치.
        */
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 70).isActive = true
        
        // UIView에 설명 라벨 추가 및 위치 설정 (제보하기 라벨 아래에 배치)
        /*
            - centerXAnchor를 사용하여 가로 중앙 정렬 설정.
            - topAnchor와 constant를 사용하여 제보하기 라벨 아래에서 일정한 간격(20 포인트)으로 배치.
        */
        addSubview(subText)
        subText.translatesAutoresizingMaskIntoConstraints=false
        subText.centerXAnchor.constraint(equalTo:self.centerXAnchor).isActive=true
        subText.topAnchor.constraint(equalTo:label.bottomAnchor, constant:20).isActive=true

        

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


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


    
