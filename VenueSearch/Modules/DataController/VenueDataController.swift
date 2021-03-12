//
//  VenueDataController.swift
//  VenueSearch
//
//  Created by Ajay Sharma on 11/03/21.
//  Copyright © 2021 TTN. All rights reserved.
//

import Foundation

enum APIError: Error {
    case internalError
    case serverError
    case parsingError
}

protocol VenueProvider {
    func venues(parameters: KeyValuePairs<String, String>, completion: @escaping((Result<VenueSearch, APIError>) -> Void))
}

struct VenueDataController: VenueProvider {
    
    func venues(parameters: KeyValuePairs<String, String>, completion: @escaping((Result<VenueSearch, APIError>) -> Void)) {
        
        callVenueAPI(with: parameters, completion: completion)
    }

    private func callVenueAPI<T: Codable>(with parameters: KeyValuePairs<String, String>, completion: @escaping((Result<T, APIError>) -> Void)) {
        
        guard var urlComponents = URLComponents(string: venueURL) else {
            completion(.failure(.internalError))
            return
        }
        var queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(.internalError))
            return
        }
        debugPrint(url)
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.serverError))
                return
            }
            do {
                guard let data = data else {
                    completion(.failure(.serverError))
                    return
                }
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(.parsingError))
            }
        }
        dataTask.resume()
    }
}
