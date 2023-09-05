//
//  ApiManager.swift
//  BoringApp
//
//  Created by Adarsh Singh on 06/09/23.
//

import Foundation

enum DataError:Error{
    
    case invalidResponse
    case invalidUrl
    case invalidDecoding
    
    case network(Error?)
}

class ApiManager{
    
    static let shared = ApiManager()
    init(){}
    
    func fetchData(completion: @escaping(Result<Boring, DataError>)->Void){
        
        guard let url = URL(string: Constant.Api.apiUrl) else{
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data, error == nil else{
                completion(.failure(.invalidResponse))
                
                return
                
            }
            
            guard let response = response as? HTTPURLResponse,
                  200...299 ~= response.statusCode else{
                completion(.failure(.invalidResponse))
                return
            }
            
            
            do{
                let bored = try JSONDecoder().decode(Boring.self, from: data)
                completion(.success(bored))
            }catch{
                
                completion(.failure(.invalidUrl))
            }
        }.resume()
    }
}
