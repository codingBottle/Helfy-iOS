//
//  CommunityApiHandler.swift
//  Helfy
//
//  Created by YEOMI on 1/23/24.
//


import Foundation
/*
let token = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjY5NjI5NzU5NmJiNWQ4N2NjOTc2Y2E2YmY0Mzc3NGE3YWE5OTMxMjkiLCJ0eXAiOiJKV1QifQ.eyJuYW1lIjoi7KCE7ZmN7JiBIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hL0FDZzhvY0tEZVRjNVNWR1JsdlRPbjRkdFVHb0N4Qzk3Y01KSmR3UlhoUUV6Skpkej1zOTYtYyIsImlzcyI6Imh0dHBzOi8vc2VjdXJldG9rZW4uZ29vZ2xlLmNvbS9oZWxmeS1mYmUwNSIsImF1ZCI6ImhlbGZ5LWZiZTA1IiwiYXV0aF90aW1lIjoxNzA2NjA0ODE0LCJ1c2VyX2lkIjoiQUZ1OEhGemlPMFJMQnRsbXhmSjRDZlViS0VIMyIsInN1YiI6IkFGdThIRnppTzBSTEJ0bG14Zko0Q2ZVYktFSDMiLCJpYXQiOjE3MDY2MDQ4MTQsImV4cCI6MTcwNjYwODQxNCwiZW1haWwiOiJqdW5ob25neW91bmc5OTA5MTZAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZ29vZ2xlLmNvbSI6WyIxMTA0OTU0NDYyNzUxNjA0MzY5MjAiXSwiZW1haWwiOlsianVuaG9uZ3lvdW5nOTkwOTE2QGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6Imdvb2dsZS5jb20ifX0.aPe-ypSrnEmajYms2TllUPqxOoE1uwGFwMURjrG9w4FI_HnXhGJDAVkBYRWiir2C3JpytAE0tnfE9PdqBu-7INHrDljaA-wun3SNCm1rIfts6eLzbCB4DiJpfrQ0SoDyDmTaEiqALM2dT1VisFHXlQUoG2WpZA6M0E0cm1a60nl0cIuUnC__ItPOb—27-_y6BTemoXLKa_MwIlLEOz3pOt05DFEs1NCwUATlYAdRK0fVL5XWdELUa5kau68yIsQHCwHm4F88UxWeS-qsPhwgWGwFfXgWvvvGQ1kPCbSSrVv49moZErJKeeyDRiUypfNtxArMmT2NEnBdsHqBd4bjA"
*/

class APIHandler {
    let token = UserDefaults.standard.string(forKey: "GoogleToken") ?? ""
    func getPost(page: Int, size: Int, sort: [String], completion: @escaping (Result<GetPostResponse, Error>) -> Void) {
       
        print("getpost")
        // API 요청을 보내고 응답을 처리하는 코드
        guard let url = URL(string: "https://helfy-server.duckdns.org/api/v1/posts") else {
            print("유효하지 않은 URL입니다.")
            return
        }
        print("token 값 1: \(self.token)")
        
        
        var requestURL = URLRequest(url: url)
        requestURL.httpMethod = "GET"
        requestURL.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard error == nil else {
                print("네트워크 오류: \(error!.localizedDescription)")
                completion(.failure(error!))
                return
            }
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("데이터를 받아오는 데 문제가 발생했습니다.")
                completion(.failure(NSError(domain: "Network Error", code: 0, userInfo: nil)))
                return
            }
            
            // 데이터 출력
                    if let responseDataString = String(data: data, encoding: .utf8) {
                        print("Response Data: \(responseDataString)")
                    }
            
            do {
                let decodedData = try JSONDecoder().decode(GetPostResponse.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("데이터 디코딩 오류: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    func createPost(postData: CreatePost, completion: @escaping (Result<CreatePostResponse, Error>) -> Void) {
        print("createpost")
        guard let url = URL(string: "https://helfy-server.duckdns.org/api/v1/posts") else {
            print("Invalid URL")
            return
        }
        print("token 값 2: \(self.token)")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(postData)
        } catch {
            print("Error encoding post data: \(error.localizedDescription)")
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(.failure(error ?? NSError(domain: "Unknown error", code: 0, userInfo: nil)))
                return
            }
            
            guard response.statusCode == 200 else {
                print("HTTP Status Code: \(response.statusCode)")
                completion(.failure(NSError(domain: "Server Error", code: response.statusCode, userInfo: nil)))
                return
            }
            
            // 데이터 출력
                    if let responseDataString = String(data: data, encoding: .utf8) {
                        print("Response Data: \(responseDataString)")
                    }
            
            do {
                let decoder = JSONDecoder()
                let createdPost = try decoder.decode(CreatePostResponse.self, from: data)
                completion(.success(createdPost))
            } catch {
                print("Error decoding response data: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    func updatePost(postID: Int, updatedData: [String: Any]) {
        guard let url = URL(string: "https://yourapi.com/posts/\(postID)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: updatedData, options: [])
        } catch {
            print("Error encoding updated data: \(error.localizedDescription)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response from the server
        }.resume()
    }
    
    func deletePost(postID: Int) {
        guard let url = URL(string: "https://yourapi.com/posts/\(postID)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response from the server
        }.resume()
    }
    func ImageUploadFunction(_ imageData: Data, completion: @escaping (Result<String, Error>) -> Void) {
        print("imageupload")
        guard let url = URL(string: "https://yourapi.com/uploadImage") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        // 이미지 데이터를 HTTP body에 추가
        request.httpBody = imageData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown Error", code: 0, userInfo: nil)))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Server Error", code: httpResponse.statusCode, userInfo: nil)))
                return
            }
            
            if let imageURL = String(data: data, encoding: .utf8) {
                completion(.success(imageURL))
            } else {
                completion(.failure(NSError(domain: "Image URL Error", code: 0, userInfo: nil)))
            }
        }.resume()
    }

}
