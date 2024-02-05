//
//  MyPageAPIHandler.swift
//  Helfy
//
//  Created by 윤성은 on 1/29/24.
//

import Foundation

class MyPageAPIHandler {
    
    let token = UserDefaults.standard.string(forKey: "GoogleToken") ?? ""
    
    func getMyPageData(completion: @escaping (MypageModel) -> ()) {
        guard let url = URL(string: "https://helfy-server.duckdns.org/api/v1/user") else {
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
                    let myPageParsedData = try JSONDecoder().decode(MypageModel.self, from: data)
                    completion(myPageParsedData)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                if let response = response as? HTTPURLResponse { print("Status code: \(response.statusCode)") }
            }
        }.resume()
    }
    
    func updateMyPageData(nickname: String?, region: String?, completion: @escaping (Bool) -> Void) {
        let url = URL(string: "https://helfy-server.duckdns.org/api/v1/user")!
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json;charset=UTF-8", forHTTPHeaderField: "accept")
        request.setValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
        
        var body: [String: Any] = [:]
        if let nickname = nickname {
            body["nickname"] = nickname
        }
        if let region = region {
            body["region"] = region
        }
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(false) // 콜백 추가
            } else if let httpResponse = response as? HTTPURLResponse {
                print("Status Code: \(httpResponse.statusCode)")

                if httpResponse.statusCode == 200 {
                    completion(true) // 콜백 추가
                } else {
                    completion(false) // 콜백 추가
                }

                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        let nickname = json?["nickname"] as? String
                        let region = json?["region"] as? String
                    } catch {
                        print("Error: \(error)")
                    }
                }
            }
        }
        task.resume()

    }
}
