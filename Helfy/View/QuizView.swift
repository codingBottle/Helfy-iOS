//
//  QuizView.swift
//  Helfy
//
//  Created by 김하은 on 2023/10/11.
//
import UIKit

class QuizView: UIView {
    let categoryView: CategoryView

    override init(frame: CGRect) {
        // Initialize the category view
        self.categoryView = CategoryView()

        super.init(frame:frame)
        
        self.backgroundColor = .white
        
        // Add the category view to the Quiz View.
        self.addSubview(categoryView)
        
         // Set up constraints for the category view.
         categoryView.translatesAutoresizingMaskIntoConstraints = false

         let padding: CGFloat = 20  // Adjust this value as needed.

         NSLayoutConstraint.activate([
             categoryView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: padding),
             categoryView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
             categoryView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
             categoryView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
          ])
     }

     required init?(coder aDecoder:NSCoder) {
       fatalError("init(coder:) has not been implemented")
     }
}
