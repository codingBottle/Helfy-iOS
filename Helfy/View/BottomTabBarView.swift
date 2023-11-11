//
//  BottomTabBarView.swift
//  Helfy
//
//  Created by 윤성은 on 10/28/23.
//

import UIKit

// 각 탭바 항목
enum TabItem: Int {
    case quiz
    case home
    case community
    
    var normalImage: UIImage? {
        switch self {
        case .quiz:
            return UIImage(systemName: "gamecontroller")
        case .home:
            return UIImage(systemName: "house")
        case .community:
            return UIImage(systemName: "bubble.left.and.text.bubble.right")
        }
    }
    
    var selectedImage: UIImage? {
        switch self {
        case .quiz:
            return UIImage(systemName: "gamecontroller.fill")
        case .home:
            return UIImage(systemName: "house.fill")
        case .community:
            return UIImage(systemName: "bubble.left.and.text.bubble.right.fill")
        }
    }
}

// 탭바 구성
final class BottomTabBarView: UIView {
    var onTabSelected: ((Int) -> Void)?

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    private let tabItems: [TabItem]
    private var tabButtons = [UIButton]()
    private var selectedIndex = 1 {
        didSet { updateUI() }
    }
    
    init(tabItems: [TabItem]) {
        self.tabItems = tabItems
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // 버튼 눌렀을 때
    private func setUp() {
        defer { updateUI() }
        
        tabItems
            .enumerated()
            .forEach { i, item in
                let button = UIButton()
                button.setImage(item.normalImage, for: .normal)
                button.setImage(item.normalImage?.alpha(0.5), for: .highlighted)
                button.tintColor = .black
                
                button.addAction { [weak self] in
                    self?.selectedIndex = i
                    self?.onTabSelected?(i)

                }
                tabButtons.append(button)
                stackView.addArrangedSubview(button)
            }
        
        // 탭바 레이아웃
        backgroundColor = UIColor(hexString: "#F9DF56")
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
    
    // 현재 선택된 탭바 업데이트
    private func updateUI() {
        tabItems
            .enumerated()
            .forEach { i, item in
                let isButtonSelected = selectedIndex == i
                let image = isButtonSelected ? item.selectedImage : item.normalImage
                let selectedButton = tabButtons[i]
                
                selectedButton.setImage(image, for: .normal)
                selectedButton.setImage(image?.alpha(0.5), for: .highlighted)
        }
    }
}

// 액션
public extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping () -> ()) {
        @objc class ClosureSleeve: NSObject {
            let closure: () -> ()
            
            init(_ closure: @escaping () -> ()) {
                self.closure = closure
            }
            
            @objc func invoke() {
                closure()
            }
        }
        
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}


extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
