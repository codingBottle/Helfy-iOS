//
//  SearchViewController.swift
//  Helfy
//
//  Created by YEOMI on 2/11/24.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {
    let categoryPageApiHandler = CategoryPageAPIHandler()
    let categoryPageView = CategoryPageView()
    let categoryPageViewController = CategoryPageViewController()
    
    let searchContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 15.0
        view.layer.backgroundColor = CGColor(red: 249/255, green: 223/255, blue: 86/255, alpha: 1.0)
        view.clipsToBounds = true
        return view
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "카테고리를 입력하세요"
        textField.textColor = .black
        textField.borderStyle = .none
        return textField
    }()
    
    let searchButtonContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(red: 249/255, green: 164/255, blue: 86/255, alpha: 1.0)
        container.layer.cornerRadius = 22.5
        return container
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
        searchTextField.delegate = self
    }
    
    func setupUI() {
        view.addSubview(searchContainerView)
        searchContainerView.addSubview(searchTextField)
        view.addSubview(searchButtonContainer)
        searchButtonContainer.addSubview(searchButton)
        
        searchContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            searchContainerView.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: searchContainerView.topAnchor),
            searchTextField.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: searchContainerView.trailingAnchor, constant: -10),
            searchTextField.bottomAnchor.constraint(equalTo: searchContainerView.bottomAnchor)
        ])
        
        searchButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButtonContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchButtonContainer.leadingAnchor.constraint(equalTo: searchContainerView.trailingAnchor, constant: 10),
            searchButtonContainer.widthAnchor.constraint(equalToConstant: 45),
            searchButtonContainer.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.centerXAnchor.constraint(equalTo: searchButtonContainer.centerXAnchor),
            searchButton.centerYAnchor.constraint(equalTo: searchButtonContainer.centerYAnchor),
            searchButton.widthAnchor.constraint(equalTo: searchButtonContainer.widthAnchor),
            searchButton.heightAnchor.constraint(equalTo: searchButtonContainer.heightAnchor)
        ])
    }
    
    @objc func searchButtonTapped() {
        if let searchTerm = searchTextField.text, !searchTerm.isEmpty {
            let uppercasedSearchTerm = searchTerm.uppercased()
            print("검색어: \(uppercasedSearchTerm)")
            
            // API 호출을 통해 카테고리 페이지 데이터 가져오기
            self.categoryPageApiHandler.getCategoryPageData(category: uppercasedSearchTerm) { [weak self] data in
                guard let self = self else { return }
                // 정의해둔 모델 객체에 할당
                self.categoryPageViewController.categoryPageData = data
                
                // 데이터를 제대로 잘 받아왔다면
                guard let data = self.categoryPageViewController.categoryPageData else {
                    return print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
                }
                
                // 카테고리 페이지 데이터를 가져왔을 때
                DispatchQueue.main.async {
                    self.categoryPageViewController.presentCategory = uppercasedSearchTerm
                    self.categoryPageViewController.hidesBottomBarWhenPushed = true
                    
                    self.navigationController?.pushViewController(self.categoryPageViewController, animated: true)
                    self.searchTextField.text = ""
                }
            }
        } else {
            print("카테고리를 입력하세요.")
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setUpKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
