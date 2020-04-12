//
//  NetworkError.swift
//  CoreDataLab
//
//  Created by Cameron Rivera on 4/8/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL(String)
    case noData
    case noResponse
    case badStatusCode(Int)
    case decodingError(Error)
    case encodingError(Error)
    case networkClientError(Error)
}
