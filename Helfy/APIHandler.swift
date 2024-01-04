//
//  APIHandler.swift
//  Helfy
//
//  Created by 윤성은 on 1/3/24.
//

import Foundation

func getQuizData(type: String, completion: @escaping (QuizModel) -> ()) {
        guard let url = URL(string: "https://helfy-server.duckdns.org/api/v1/quiz?type=\(type)") else {
            return
        }
        
        let requestURL = URLRequest(url: url)
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
                    let quizparsedData = try JSONDecoder().decode(QuizModel.self, from: data)
                    completion(quizparsedData)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                if let response = response as? HTTPURLResponse { print("Status code: \(response.statusCode)") }
            }
        }.resume()
    }
