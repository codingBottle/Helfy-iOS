//
//  SearchView.swift
//  Helfy
//
//  Created by YEOMI on 11/21/23.
//
import UIKit

class SearchViewController: UIViewController {
    
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
        textField.placeholder = "검색어를 입력하세요"
        textField.textColor = .black
        textField.borderStyle = .none
        return textField
    }()
    
    let searchButtonContainer: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor(red: 249/255, green: 164/255, blue: 86/255, alpha: 1.0)
        container.layer.cornerRadius = 22.5 // 반지름을 버튼 높이의 절반으로 설정
        return container
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        button.addTarget(SearchViewController.self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupUI()
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
            print("검색어: \(searchTerm)")
            // 여기에 실제 검색 동작을 수행하는 코드를 추가할 수 있습니다.
        } else {
            print("검색어를 입력하세요.")
        }
    }
}
