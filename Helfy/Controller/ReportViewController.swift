//
//  ReportViewController.swift
//  Helfy
//
//  Created by YEOMI on 2023/10/07.
//
import Foundation
import UIKit

class ReportViewController: UIViewController {

    lazy var reportView = ReportView()
    let textView = TextView()


    override func viewDidLoad() {
        super.viewDidLoad()
        

        // reportView를 화면에 추가하고 크기를 설정
        view.addSubview(reportView)
        reportView.translatesAutoresizingMaskIntoConstraints = false
        reportView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        reportView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        reportView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        reportView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
 
        // textView를 화면에 추가하고 크기를 설정
        view.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        
       // 각각의 버튼에 액션을 연결
        reportView.sbsButton.addTarget(self, action:#selector(openSBS), for:.touchUpInside)
        reportView.kbsButton.addTarget(self, action:#selector(openKBS), for:.touchUpInside)
        reportView.mbcButton.addTarget(self, action:#selector(openMBC), for:.touchUpInside)

      // ...
       
   }

    
   // 버튼 링크 연결
   @objc func openSBS() {
      if let url = URL(string:"https://news.sbs.co.kr/news/inform.do") {
         UIApplication.shared.open(url)
      }
   }

  @objc func openKBS() {
     if let url = URL(string:"https://news.kbs.co.kr/report/reportWrite.do") {
        UIApplication.shared.open(url)
     }
  }

  @objc func openMBC() {
     if let url = URL(string:"https://imnews.imbc.com/more/report/") {
        UIApplication.shared.open(url)
     }
  }
}
