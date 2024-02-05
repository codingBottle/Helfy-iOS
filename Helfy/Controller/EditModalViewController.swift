//
//  EditModalViewController.swift
//  Helfy
//
//  Created by 윤성은 on 1/31/24.
//

import UIKit

class EditModalViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    var myPageApiHandler : MyPageAPIHandler = MyPageAPIHandler()
    var onConfirm: ((String?, String?) -> Void)?
    var textViewTag: Int = 0
    
    let regionDictionary: [String: String] = [
        "SEOUL" : "서울",
        "GYEONGGI" : "경기",
        "INCHEON" : "인천",
        "BUSAN" : "부산",
        "JEJU" : "제주",
        "ULSAN" : "울산",
        "GYEONGSANGNAM" : "경남",
        "DAEGU" : "대구",
        "GYEONGSANGBUK" : "경북",
        "GANGWON" : "강원",
        "DAEJEON" : "대전",
        "CHUNGCHEONGNAM" : "충남",
        "CHUNGCHEONGBUK" : "충북",
        "SEJONG" : "세종",
        "GWANGJU" : "광주",
        "JEOLANAM" : "전남",
        "JEOLABUK" : "전북"
    ]
    
    var nickname: String?
    var region: String? 

    let textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.textColor = UIColor.white
        textField.backgroundColor = UIColor.clear
        textField.textAlignment = .center
        textField.clearButtonMode = .always
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let textCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var regionButton: UIButton = {
        let button = UIButton()
        button.setTitle(regionDictionary[region ?? ""], for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.addTarget(self, action: #selector(regionButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        textField.delegate = self
        textField.text = nickname
        textCountLabel.text = "\(textField.text?.count ?? 0) / 15"
    }
    
    private func setupUI() {
        view.addSubview(textField)
        view.addSubview(separatorView)
        view.addSubview(textCountLabel)
        view.addSubview(regionButton)
        view.addSubview(cancelButton)
        view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            separatorView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10),
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            // textCountLabel의 제약 조건
            textCountLabel.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 10),
            textCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // regionButton의 제약 조건
            regionButton.topAnchor.constraint(equalTo: textCountLabel.bottomAnchor, constant: 50),
            regionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            regionButton.widthAnchor.constraint(equalToConstant: 200),
            regionButton.heightAnchor.constraint(equalToConstant: 100),
            
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            confirmButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        self.view.backgroundColor = UIColor(white: 0.2, alpha: 0.9)

    }
    
    @objc func regionButtonTapped() {
        let alert = UIAlertController(title: "지역 선택", message: "지역을 선택해주세요.", preferredStyle: .actionSheet)
        
        for (key, value) in regionDictionary {
            alert.addAction(UIAlertAction(title: value, style: .default, handler: { [weak self] _ in
                // regionDictionary를 사용하여 영어 지역명을 한글로 변환하여 title로 설정합니다.
                self?.regionButton.setTitle(value, for: .normal)
                // 지역이 변경되었으므로 확인 버튼을 활성화합니다.
                self?.confirmButton.isEnabled = true
                self?.confirmButton.setTitleColor(.white, for: .normal)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func confirmButtonTapped() {
        let nickname = textField.text ?? ""
        let regionTitle = regionButton.title(for: .normal) ?? ""
        let region = regionDictionary.first { $1 == regionTitle }?.key ?? ""
        
        myPageApiHandler.updateMyPageData(nickname: nickname, region: region) { [weak self] success in

            if success {
                self?.onConfirm?(nickname, region)
            } else {
                print("Failed to update data.")
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        textCountLabel.text = "\(updatedText.count) / 15"

        // 확인 버튼의 상태를 업데이트
//        confirmButton.isEnabled = !updatedText.isEmpty
//        confirmButton.setTitleColor(updatedText.isEmpty ? .gray : .white, for: .normal)

        return updatedText.count < 15
    }

    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        textCountLabel.text = "0 / 15"

        // 확인 버튼의 상태를 업데이트
        confirmButton.isEnabled = false
        confirmButton.setTitleColor(.gray, for: .normal)

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Before end editing: \(textField.text)")
        textField.endEditing(true)
        print("After end editing: \(textField.text)")
        
        return false
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            print("사용자가 입력한 텍스트: \(text)")
            nickname = text
        }
    }
    
    func setUpKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                
                confirmButton.isEnabled = false
                
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        confirmButton.isEnabled = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
