//
//  CategoryView.swift
//  Helfy
//
//  Created by 윤성은 on 10/11/23.
//





//
//  CategoryView.swift
//  Helfy
//
//  Created by 윤성은 on 10/11/23.
//

import UIKit

//class CategoryButton: UIButton {
//    let title = UILabel()
//    let image = UIImage()
//
//    init(image: UIImage?, title: String) {
//        super.init(frame: .zero)
//
//        self.setImage(image, for: .normal)
//        self.setTitle(title, for: .normal)
//   }
//
//    func setUIforCategoryButton() {
////        image =
//    }
//
//
//    @objc func buttonTapped() {
//         print("Button was tapped!")
//     }
//
//     required init?(coder aDecoder:NSCoder) {
//         fatalError("init(coder:) has not been implemented")
//     }
//}

class testButton: UIButton {
    let myImageView = UIImageView()
    let myTitleLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        self.addTarget(self, action:#selector(buttonTapped), for:.touchUpInside)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 60),
            self.heightAnchor.constraint(equalToConstant: 80) // Increase the button height to accommodate image and label
        ])
        
        setLayout()
    }
    
    func setUIforCategoryButton(image: UIImage?, title: String) {
        myImageView.image = image
        myTitleLabel.text = title
        
//        myImageView.contentMode
        
        // Add subviews and set up layout constraints as needed...
        
        self.addSubview(myImageView)
        self.addSubview(myTitleLabel)
        
        
        myTitleLabel.font = UIFont.systemFont(ofSize: 12)
   }
    
    func setLayout() {
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myImageView.widthAnchor.constraint(equalToConstant: 60),
            myImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        myTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            myTitleLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor),
//            myTitleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
        
    }
    

    @objc func buttonTapped() {
         print("Button was tapped!")
     }
     
     required init?(coder aDecoder:NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
}


class testView : UIView {
    
    let buttonTitles = ["침수", "태풍", "호우","낙뢰",
                        "강풍", "풍랑", "대설", "한파",
                        "폭염", "황사", "지진", "해일",
                        "지진해일", "화산폭발", "가뭄","홍수",
                        "해수면상승", "산사태","자연우주물체추락", "우주전파재난",
                        "녹조", "적조"]
    let buttonImages = [UIImage(named:"침수"), UIImage(named:"태풍"), UIImage(named: "호우"),
                        UIImage(named:"낙뢰"), UIImage(named:"강풍"), UIImage(named: "풍랑"),
                        UIImage(named:"대설"), UIImage(named:"한파"), UIImage(named:"폭염"),
                        UIImage(named:"황사"), UIImage(named:"지진"), UIImage(named:"해일"),
                        UIImage(named:"지진해일"), UIImage(named:"화산폭발"), UIImage(named:"가뭄"),
                        UIImage(named:"홍수"), UIImage(named:"해수면상승"), UIImage(named:"산사태"),
                        UIImage(named:"자연우주물체추락"), UIImage(named:"우주전파재난"), UIImage(named:"녹조"), UIImage(named:"적조")]
    
    let stackView = UIStackView()
    let hStack = UIStackView()
    let categoryBtn = UIButton()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        setUI()
        setLayout()
       

        
   }
    
   required init?(coder aDecoder:NSCoder) {
     fatalError("init(coder:) has not been implemented")
   }
    
    func setUI() {
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        hStack.axis = .horizontal
        hStack.distribution = .fillEqually
        hStack.spacing = 10
    }

    func setLayout() {
        self.addSubview(stackView)
        
        //stackView layout
        stackView.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo:self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo:self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo:self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo:self.trailingAnchor)
       ])
        
//        for i in stride(from:0, to:buttonTitles.count, by:4) {
//            for j in i..<min(i + 4, buttonTitles.count) {
//                let buttonTitle = buttonTitles[j]
//                let buttonImage = buttonImages[j]
//                let categoryBtn = CategoryButton(image: buttonImage ,title: buttonTitle)
//
//                hStack.addArrangedSubview(categoryBtn)
//            }
//            stackView.addArrangedSubview(hStack)
//       }
        for i in stride(from:0, to:buttonTitles.count, by:4) {
               for j in i..<min(i + 4, buttonTitles.count) {
                   let buttonTitle = buttonTitles[j]
                   let buttonImage = buttonImages[j]
                   let categoryBtn = testButton()
                   categoryBtn.setUIforCategoryButton(image: buttonImage ,title: buttonTitle)

                   hStack.addArrangedSubview(categoryBtn)
               }
               stackView.addArrangedSubview(hStack)
          }
        
        
    }
}

