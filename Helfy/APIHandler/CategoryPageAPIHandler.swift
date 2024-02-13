//
//  CategoryPageAPIHandler.swift
//  Helfy
//
//  Created by YEOMI on 2/12/24.
//

import Foundation

class APIHandler {
    func getCategoryPageData(category: String,completion: @escaping (CategoryPageModel) -> ()) {
        //let key = "발급받은 API키"

        // 1. 사전준비 단계에서 발급받은 key를 활용하여 requestURL 생성
        guard let url = URL(string: "https://helfy-server.duckdns.org/api/v1/information?category=\(category)") else {
            print("유효하지 않은 url입니다.")
            return
        }
        var requestURL = URLRequest(url: url)
            requestURL.httpMethod = "GET"
        
        // 2. 데이터를 받아오기 위한 URLSession의 dataTask를 생성
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
          // 3. 에러 처리, 데이터 및 리스폰스 확인, 디코딩 등등 출
          guard error == nil else {
              print(error?.localizedDescription)
              return
            }
            
          if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
            do {
                //가공
               let parsedData = try JSONDecoder().decode(CategoryPageModel.self, from: data)
             completion(parsedData)
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
              }
                
          }
       }.resume()
    }
}
