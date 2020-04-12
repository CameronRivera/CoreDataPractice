//
//  UIImageView+Extensions.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/11/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import UIKit
import AVFoundation

// Fetch Images From a restful API
extension UIImageView {
    
    func getPicture(_ urlString: String, completion: @escaping (Result<UIImage,NetworkError>) -> ()){
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL(urlString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(request) { result in
            switch result {
            case .failure(let netError):
                completion(.failure(.networkClientError(netError)))
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                }
            }
        }
    }
    
}

// Resize an image
extension UIImageView {
    static func resizeImage(originalImage: UIImage, rect: CGRect) -> UIImage {
      let rect = AVMakeRect(aspectRatio: originalImage.size, insideRect: rect)
      let size = CGSize(width: rect.width, height: rect.height)
      let renderer = UIGraphicsImageRenderer(size: size)
      return renderer.image { (context) in
        originalImage.draw(in: CGRect(origin: .zero, size: size))
      }
    }
}
