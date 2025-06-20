# 📱 Helfy - 안전 정보 제공 앱

> **일상 속 안전을 퀴즈와 정보로 함께 배우는 iOS 애플리케이션**


## 📌 프로젝트 소개
<img width="982" alt="1" src="https://github.com/user-attachments/assets/7f6e5485-79b0-464c-aadb-a892c9f842b2" />

**Helfy**는 사용자에게 재난, 사고, 건강 등 다양한 상황에 대한 **안전 정보를 제공하고**,  
퀴즈를 통해 자연스럽게 학습할 수 있도록 돕는 **iOS 기반 안전 교육 앱**입니다.

- 안전 정보 + 퀴즈 + 랭킹 시스템으로 구성
- 사용자 친화적인 UI/UX 및 가독성 높은 콘텐츠
- Swift 및 UIKit 기반의 네이티브 iOS 앱 개발
- Firebase를 통한 인증 및 데이터 관리
- 서버 연동 및 비동기 네트워크 처리 구현

---

## 🖼️ 주요 화면

| 홈 화면 | 퀴즈 시작 화면 | 퀴즈 문제 | 카테고리 화면 |
|---------|----------------|------------|----------------|
| ![main](https://github.com/user-attachments/assets/7650dc01-d669-4a8c-b615-5dbf28ade977) | ![start_quiz](https://github.com/user-attachments/assets/d5fa445e-1c7d-434a-ba6f-2ffab2385943) | ![quiz1](https://github.com/user-attachments/assets/141cadba-37f7-454b-aa17-77ab7bd24a8d) | ![category](https://github.com/user-attachments/assets/3376092c-b727-40c7-9f6c-c1cacbcdab01) |

---

## 🧰 사용 기술 (Tech Stack)

### iOS (Client)
- **Language:** Swift
- **Framework:** UIKit
- **UI Layout:** Auto Layout
- **Authentication:** Firebase Auth
- **Networking:** URLSession (비동기 처리)
- **Architecture:** MVC (Model-View-Controller)

### Server (Backend)
- **Language:** Java 17
- **Framework:** Spring 3.1.4
- **Database:** MySQL
- **ORM:** Spring Data JPA + QueryDSL
- **Cache:** Redis
- **Test:** JUnit5, Mockito, Jacoco

---

## ⚙️ 개발 방식

### 🔹 iOS 클라이언트

- MVC 아키텍처를 통해 **View와 Model 분리**, 가독성과 유지보수성 향상  
- URLSession을 활용한 **비동기 네트워크 처리**로 앱 반응성 개선  
- Firebase를 이용한 사용자 로그인 및 인증 구현  
- 퀴즈, 카테고리 검색, 랭킹 시스템 등 **구체적 사용자 흐름 설계**  
- Figma로 와이어프레임 및 UI/UX 디자인 전반 기획 및 설계  

### 🔹 백엔드 서버

- **Redis 캐시 전략 적용**으로 평균 응답 속도 96ms → 24ms로 약 70% 단축  
- **멀티 모듈 아키텍처** 도입으로 도메인 분리 및 유지보수성 확보  
- 테스트 자동화 도입 (JUnit, Mockito, Jacoco), API 문서화 포함  

---

## ✨ 주요 기능

- 📚 **안전 정보 제공** – 재난, 사고, 건강 등 상황별 실용적 정보 제공  
- 🧠 **퀴즈 학습** – 객관식 퀴즈로 안전 상식 자연스러운 학습 유도  
- 🏆 **랭킹 시스템** – 사용자 점수 기반의 리더보드 표시  
- 🔍 **카테고리 검색** – 관심 주제만 골라서 학습 가능  
- 🔐 **회원 로그인/인증** – Firebase 기반 사용자 인증  

---

## 🔗 참고 자료

- [📘 Helfy 프로젝트 요약 자료 보기 (PDF)](https://github.com/user-attachments/files/20833592/HelfyU-Jam_.pdf)


