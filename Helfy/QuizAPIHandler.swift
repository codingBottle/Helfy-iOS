//
//  APIHandler.swift
//  Helfy
//
//  Created by 윤성은 on 1/3/24.
//

import Foundation

class QuizAPIHandler {
    
    var token = UserDefaults.standard.string(forKey: "GoogleToken") ?? ""
        
    func getQuizHomeData(completion: @escaping (QuizHomeModel) -> ()) {
        guard let url = URL(string: "https://helfy-server.duckdns.org/api/v1/quiz/users") else {
            return
        }
        
        print("token 값 : \(self.token)")
        
        var requestURL = URLRequest(url: url)
        requestURL.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        print(requestURL,"requestURL")
        
        // 2. 데이터를 받아오기 위한 URLSession의 dataTask를 생성
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            // 3. 에러 처리, 데이터 및 리스폰스 확인, 디코딩 등등 출동
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let quizHomeParsedData = try JSONDecoder().decode(QuizHomeModel.self, from: data)
                    completion(quizHomeParsedData)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                if let response = response as? HTTPURLResponse { print("Status code: \(response.statusCode)") }
            }
        }.resume()
    }
    
    func getQuizData(type: String, completion: @escaping (Quiz) -> ()) {
        var apiUrl: String
        switch type {
        case "TODAY":
            apiUrl = "https://helfy-server.duckdns.org/api/v1/quiz?type=TODAY"
        case "NORMAL":
            apiUrl = "https://helfy-server.duckdns.org/api/v1/quiz?type=NORMAL"
        case "WRONG":
            apiUrl = "https://helfy-server.duckdns.org/api/v1/quiz/users/wrong"
        default:
            print("Invalid quiz category")
            return
        }
        
        guard let url = URL(string: apiUrl) else {
            print("Invalid URL")
            return
        }
        
        print("token 값 : \(self.token)")
        
        var requestURL = URLRequest(url: url)
        requestURL.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        print(requestURL,"requestURL")
        
        
        // 2. 데이터를 받아오기 위한 URLSession의 dataTask를 생성
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            // 3. 에러 처리, 데이터 및 리스폰스 확인, 디코딩 등등 출동
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let quizParsedData = try JSONDecoder().decode(Quiz.self, from: data)
                    completion(quizParsedData)
                    print("quizParsedData: \(quizParsedData)")
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                if let response = response as? HTTPURLResponse {
                    print("Status code: \(response.statusCode)")
                }
                
            }
        }.resume()
    }
    
    func sendWrongAnswerStatus(id: String, answerType: AnswerType, completion: @escaping (Quiz) -> ()) {
        if answerType == .wrong {
            // URL 준비
            guard let url = URL(string: "https://helfy-server.duckdns.org/api/v1/quiz/users/\(id)/result") else { return }
            print("🔴🔴🔴ID : \(id)")
            
            // PUT 요청 생성
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "accept")
            request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
            
            // 필요한 경우 httpBody를 설정하여 요청에 데이터를 포함시킬 수 있습니다.
            let parameters: [String: Any] = ["quizStatus": "WRONG"]
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
            
            // 요청 발행
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                } else if let data = data {
                    // 응답 데이터 처리
                    let str = String(data: data, encoding: .utf8)
                    print("Received data:\n\(str ?? "")")
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("Response status code: \(httpResponse.statusCode)")
                }
            }
            
            task.resume()
        }
    }
}
