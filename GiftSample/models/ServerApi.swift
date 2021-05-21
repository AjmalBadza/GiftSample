//
//  ServerApi.swift
//  GiftSample
//
//  Created by Ceino on 20/05/21.
//

import Foundation
struct ServerApi{
    private let api_key = "2vq1M9ye4eV6H1Mr"
    private let api_secret = "wnRY14QoA99B4Ae6wn2CU2y8"
    func getHomeFeeds(_ completionHandler: @escaping (Result<ApiHome, Error>) -> Void){
        let string="https://emapi-sandbox.yougotagift.com/uae/api/v3/brands/featured/?api_key=\(api_key)&api_secret=\(api_secret)&category=32&page=2".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        
        guard let url = URL(string: string!) else {return}
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completionHandler(.failure(error!))
                return
            }
            
            do {
                let Data = try JSONDecoder().decode(ApiHome.self, from: data)
                
                completionHandler(.success(Data))
            } catch let error as NSError {
                completionHandler(.failure(error))
            }
            
        }
        task.resume()
    }
    
    func getBrands(categoryId:Int,Page:Int=1,_ completionHandler: @escaping (Result<ApiBrands, Error>) -> Void){
        let string="https://emapi-sandbox.yougotagift.com/uae/api/v3/brands/featured/?api_key=\(api_key)&api_secret=\(api_secret)&category=\(categoryId)&page=\(Page)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        guard let url = URL(string: string!) else {return}
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completionHandler(.failure(error!))
                return
            }
            
            do {
                let Data = try JSONDecoder().decode(ApiBrands.self, from: data)
                
                completionHandler(.success(Data))
            } catch let error as NSError {
                completionHandler(.failure(error))
            }
            
        }
        task.resume()
    }
    func sample(categoryId:Int,Page:Int=1,_ completionHandler: @escaping (Result<[String:Any], Error>) -> Void){
        let string="https://emapi-sandbox.yougotagift.com/uae/api/v3/brands/featured/?api_key=\(api_key)&api_secret=\(api_secret)&category=\(categoryId)&page=\(Page)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        guard let url = URL(string: string!) else {return}
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completionHandler(.failure(error!))
                return
            }
            
            do {
                let Data =  try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                
                completionHandler(.success(Data!))
            } catch let error as NSError {
                completionHandler(.failure(error))
            }
            
        }
        task.resume()
    }

}
