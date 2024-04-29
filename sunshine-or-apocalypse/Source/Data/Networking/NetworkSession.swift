//
//  NetworkSession.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/29/24.
//

import Alamofire
import Combine
import Foundation

protocol NetworkSessionProtocol {
    func request<ResultObject: Decodable>(_ apiRequest: ApiRequest, completionHandler: @escaping (ApiSuccess<ResultObject>?, ApiError?) -> Void)
}

class NetworkSession: NetworkSessionProtocol {
    func request<ResultObject: Decodable>(_ request: ApiRequest, completionHandler: @escaping (ApiSuccess<ResultObject>?, ApiError?) -> Void) {
        let overwrittenBaseUrl = request.overwrittenBaseUrl ?? ""
        let baseUrl = !overwrittenBaseUrl.isEmpty ? overwrittenBaseUrl : "https://api.openweathermap.org/data/2.5/weather"
        let fullUrl = URL(stringLiteral: baseUrl + request.path)
        let method = getMethod(method: request.method)
        let parameters = request.parameters
        let headers = getHeaders(headers: request.headers ?? [:])
        
        AF.request(
                fullUrl,
                method: method,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: headers
            )
            .responseData { response in
                self.processResponse(response: response, fullUrl: fullUrl, completionHandler: completionHandler)
            }
    }

    private func processResponse<ResultObject>(response: AFDataResponse<Data>, fullUrl: URL, completionHandler: @escaping (ApiSuccess<ResultObject>?, ApiError?) -> Void) {
        let statusCode = response.response?.statusCode ?? 500
        
        switch response.result {
        case .success(let data):
            switch statusCode {
            case 204:
                let apiSuccess = ApiSuccess<ResultObject>(statusCode: statusCode, data: nil)
                completionHandler(apiSuccess, nil)
                return
            case 400, 403, 404, 500:
                let errorDescription = "API Error: \(fullUrl)"
                let apiError = ApiError(statusCode: statusCode, description: errorDescription)
                completionHandler(nil, apiError)
                debugPrint(errorDescription)
                return
            default:
                do {
                    let decodedData = try JSONDecoder().decode(ResultObject.self, from: data)
                    let apiSuccess = ApiSuccess<ResultObject>(statusCode: statusCode, data: decodedData)
                    completionHandler(apiSuccess, nil)
                } catch {
                    let stringData = String(decoding: data, as: UTF8.self)
                    let errorDescription = "Error: Trying to convert JSON data to \(ResultObject.self)"
                    debugPrint(errorDescription)
                    debugPrint(stringData)
                    let apiError = ApiError(statusCode: statusCode, description: errorDescription)
                    completionHandler(nil, apiError)
                    return
                }
            }
        case .failure(let error):
            let errorDescription = "API failure: \(fullUrl)"
            let apiError = ApiError(statusCode: statusCode, description: errorDescription)
            completionHandler(nil, apiError)
            
            debugPrint(error)
            debugPrint(errorDescription)
        }
    }
    
    private func getMethod(method: HttpMethod) -> HTTPMethod {
        switch method {
        case .get:
            return HTTPMethod.get
        case .post:
            return HTTPMethod.post
        case .put:
            return HTTPMethod.put
        case .patch:
            return HTTPMethod.patch
        case .delete:
            return HTTPMethod.delete
        }
    }
    
    private func getHeaders(headers: [String: String] = [:]) -> HTTPHeaders? {
        var httpHeaders: HTTPHeaders? = []
        
        headers.forEach { (key: String, value: String) in
            httpHeaders?.add(name: key, value: value)
        }
        
        return httpHeaders
    }
}
