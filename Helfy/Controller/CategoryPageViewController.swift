//
//  CategoryPageViewController.swift
//  Helfy
//
//  Created by YEOMI on 11/29/23.
//
import UIKit

class CategoryPageViewController: UIViewController {
    
    private var categoryPageView: CategoryPageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        categoryPageView = CategoryPageView()
        categoryPageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(categoryPageView)
        
        NSLayoutConstraint.activate([
            categoryPageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoryPageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoryPageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoryPageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        categoryPageView.setNewsButtonTarget(self, action: #selector(newsButtonTapped))
        categoryPageView.setYouTubeButtonTarget(self, action: #selector(youtubeButtonTapped))
        
        // 텍스트 설정 예시
        categoryPageView.setTextViewText("장소별 학교 안전사고 예방수칙\n\n1. 운동장 안전수칙 학교 내에서 안전사고가 가장 자주 발생하는 장소인 운동장! 체육시간이나 쉬는시간이 되면 뛰어다니면서 노는 친구들이 많기 때문에 위험요소가 많은 장소인데요. 운동장에는 날카로운 쇳조각이나 유리조각이 있을 수 있으므로 맨발로 노는 것은 매우 위험합니다. 또한 운동기구를 친구들끼리만 옮기다 보면 넘어져서 다칠 수 있기 때문에 반드시 선생님의 도움을 받아 옮기도록 해주세요.\n\n2. 복도·계단 안전수칙 쉬는 시간에 복도나 계단에서 장난을 치는 친구들을 많이 볼 수 있는데요. 복도나 계단에서는 이동하는 학생들이 많기 때문에 부딪히지 않도록 주의해야 합니다. 그러기 위해서 반드시 우측통행을 하고, 앞사람과 간격을 두고 움직여 주세요. 또한 계단을 한꺼번에 두 칸씩 올라가다가 헛디뎌서 다치는 경우가 많은데요. 계단을 오르내릴 때는 뛰지 말고 한 칸씩 난간을 잡고 이동하세요.\n\n3. 교실 안전수칙 교실에서 칼이나 가위, 연필 등 뾰족한 물건을 들고 장난을 치다가 다치기 쉬운데요. 이런 물건들은 반드시 필통이나 책상 안에 두는 것이 좋습니다. 또한 쉬는 시간에 교실에서 뛰다가 친구들이나 책상 모서리에 부딪히면 크게 다칠 수 있기 때문에 주의해주세요. 그리고 창틀에 올라가거나 기대어 앉는 행동은 떨어질 위험이 있으므로 절대 해서는 안 되는 행동입니다.\n\n학교 안전사고의 대부분은 아이들의 부주의로 일어납니다. 언제 일어날지 모르는 학교 안전사고를 막기 위해서 학생들에게 사전 안전교육을 시키는 것이 중요한데요. 운동장에서, 복도나 계단에서, 교실에서 조심해야 할 행동에 대해 알려주고, 안전한 학교 생활을 할 수 있도록 도와주세요! ")
    }
    
    
    
    @objc func newsButtonTapped() {
        // Handle news button tap
        if let url = URL(string:"https://news.sbs.co.kr/news/inform.do") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func youtubeButtonTapped() {
        // Handle YouTube button tap
        if let url = URL(string:"https://news.sbs.co.kr/news/inform.do") {
            UIApplication.shared.open(url)
        }
    }
}
