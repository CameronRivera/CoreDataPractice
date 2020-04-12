//
//  PixAPI.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/8/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit

struct PixAPI {
    static func getPhotos(_ query: String, _ completion: @escaping (Result<[PixPic],NetworkError>) -> ()){
        
        let endpointURL = "https://pixabay.com/api/?key=\(APIKey.pixKey)&q=\(query)"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(request) { result in
            switch result{
            case .failure(let netError):
                completion(.failure(.networkClientError(netError)))
            case .success(let data):
                do {
                    let pics = try JSONDecoder().decode(PixWrapper.self, from: data)
                    completion(.success(pics.hits))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
