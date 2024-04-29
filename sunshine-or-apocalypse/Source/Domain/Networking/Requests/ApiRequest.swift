//
//  ApiRequest.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import Foundation

protocol ApiRequest {
    var overwrittenBaseUrl: String? { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

struct EmptyResponse: Decodable {
    
}

struct ApiSuccess<T: Decodable> {
    let statusCode: Int
    let data: T?
}

struct ApiError {
    let statusCode: Int
    let description: String
}

