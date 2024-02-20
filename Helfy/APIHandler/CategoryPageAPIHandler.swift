//
//  CategoryPageAPIHandler.swift
//  Helfy
//
//  Created by YEOMI on 2/12/24.
//

import Foundation

class CategoryPageAPIHandler {
    
    let token = UserDefaults.standard.string(forKey: "GoogleToken") ?? ""
    
    func getCategoryPageData(category: String, completion: @escaping (CategoryPageModel?) -> Void) {

        guard let url = URL(string: "https://helfy-server.duckdns.org/api/v1/information?category=\(category)") else {
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
                    let categoryPageParsedData = try JSONDecoder().decode(CategoryPageModel.self, from: data)
                    completion(categoryPageParsedData)
                } catch {
                    print(error.localizedDescription)
                }
            } else {
                if let response = response as? HTTPURLResponse { print("Status code: \(response.statusCode)") }
            }
        }.resume()
    }
}

