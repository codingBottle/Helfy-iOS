//
//  MainAPIHandler.swift
//  Helfy
//
//  Created by 윤성은 on 2/5/24.
//

import Foundation

class MainAPIHandler {
    
    let token = UserDefaults.standard.string(forKey: "GoogleToken") ?? ""
    
    func getMainData(completion: @escaping (MainModel) -> ()) {
        guard let url = URL(string: "https://helfy-server.duckdns.org/api/v1/weather") else {
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
                    let mainParsedData = try JSONDecoder().decode(MainModel.self, from: data)
                    completion(mainParsedData)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                if let response = response as? HTTPURLResponse { print("Status code: \(response.statusCode)") }
            }
        }.resume()
    }
}
