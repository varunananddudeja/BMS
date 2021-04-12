//
//  LiveClassesNetworkProvider.swift
//  Zenius
//
//  Created by Varun Dudeja on 15/07/20.
//  Copyright © 2020 App Street Software. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseResponse: Codable {
    var statusCode:Int? {set get}
    var message: String? {set get}
}

struct BaseResponseModel: BaseResponse {
    var statusCode:Int?
    var message: String?
}

enum completion<T: BaseResponse> {
    case success(T)
    case failure(BaseResponseModel)
}

public class NetworkProvider {
    
    static let shared = NetworkProvider()
    let reachabilityManager = NetworkReachabilityManager()!
    
    private init() {
        
    }
    
    func get<T: BaseResponse>(_ urlString: String, params: [String: Any]? = [:], bodyParams: [String: Any]? = nil, completionHandler: @escaping ((completion<T>) -> Void)) {
        requestWithMethod(.get, urlString: urlString, params: params, bodyParams: bodyParams, completionHandler: completionHandler)
    }

    func post<T>(_ urlString: String, params: [String: Any]? = [:], bodyParams: [String: Any]? = nil,_ headers: [String: Any]? = nil, completionHandler: @escaping ((completion<T>) -> Void)) {
        requestWithMethod(.post, urlString: urlString, params: params, bodyParams: bodyParams, headers, completionHandler: completionHandler)
    }

    func put<T>(_ urlString: String, params: [String: Any]? = [:], bodyParams: [String: Any]? = nil, completionHandler: @escaping ((completion<T>) -> Void)) {
         requestWithMethod(.put, urlString: urlString, params: params, bodyParams: bodyParams, completionHandler: completionHandler)
     }
    
    func delete<T>(_ urlString: String, params: [String: Any]? = [:], bodyParams: [String: Any]? = nil, completionHandler: @escaping ((completion<T>) -> Void)) {
        requestWithMethod(.delete, urlString: urlString, params: params, bodyParams: bodyParams, completionHandler: completionHandler)
    }

    private func requestWithMethod<T>(_ method: HTTPMethod, urlString: String, params: [String: Any]?, bodyParams: [String: Any]? = nil,_ headers: [String: Any]? = nil, completionHandler: @escaping ((completion<T>) -> Void))  {

        guard reachabilityManager.isReachable else {
            completionHandler(.failure(BaseResponseModel(statusCode: 0, message: "")))
            return
        }
        
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(BaseResponseModel(statusCode: 0, message: "")))
            return
        }
        
        var urlEncodedRequest: URLRequest?
        do {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = method.rawValue
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            urlEncodedRequest = try URLEncoding.default.encode(urlRequest, with: params)
            if let bodyParams = bodyParams {
                let bodyData = try JSONSerialization.data(withJSONObject: bodyParams, options: [])
                urlEncodedRequest?.httpBody = bodyData
            }
        } catch _ {
            
        }
        
        if let urlRequest = urlEncodedRequest {
            let request = Alamofire.request(urlRequest)
            request.responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    let decoder = JSONDecoder()
                    do {
                        if let dta = response.data {
                            let model = try decoder.decode(T.self, from: dta)
                            completionHandler(.success(model))
                        } else {
                            completionHandler(.failure(BaseResponseModel(statusCode: 0, message: Constants.somethingWentWrong)))
                        }
                    } catch {
                        completionHandler(.failure(BaseResponseModel(statusCode: 0, message: Constants.somethingWentWrong)))
                    }
                    
                    // success
                case .failure(let error as NSError):
                    let model = BaseResponseModel(statusCode: response.response?.statusCode ?? error.code, message: Constants.somethingWentWrong)
                    completionHandler(.failure(model))
                }
            })
        } else {
            let model = BaseResponseModel(statusCode: 0, message: Constants.somethingWentWrong)
            completionHandler(.failure(model))
        }
    }

}
