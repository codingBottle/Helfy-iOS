//
//  WriteViewController.swift
//  Helfy
//
//  Created by YEOMI on 10/13/23.
//
import UIKit
class WriteViewController: UIViewController {
    
    private var model = MyModel(text: "WriteView")
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        
            
            
            
            
            
            
        ])
        
        updateViewFromModel()
    }
    private func updateViewFromModel() {
          // Update the View using the data from the Model.
          label.text = model.text
      }
   }
