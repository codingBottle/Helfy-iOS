//
//  TextView.swift
//  Helfy
//
//  Created by 김하은 on 2023/10/11.
//

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
