//
//  Network.swift
//  NetworkPlatform
//
//  Created by VARVAR on 11.04.2019.
//  Copyright © 2019 GoodGame. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class Network<T: Decodable> {
    private let endPoint: String
    private let scheduler: ConcurrentDispatchQueueScheduler
    
    init(_ endPoint: String) {
        self.endPoint = endPoint
        self.scheduler = ConcurrentDispatchQueueScheduler(qos: DispatchQoS(qosClass: DispatchQoS.QoSClass.background, relativePriority: 1))
    }
    
    func getItem(_ path: String, parameters: Parameters? = nil) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)/"
        let request = RequestBuilder.shared.build(url: absolutePath, method: .get, parameters: parameters)
        return URLSession.shared.rx
            .data(request: request)
            .observeOn(scheduler)
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
    
    func getItem(_ path: String, itemId: String, parameters: Parameters? = nil) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)/\(itemId)"
        let request = RequestBuilder.shared.build(url: absolutePath, method: .get, parameters: parameters)
        return URLSession.shared.rx
            .data(request: request)
            .observeOn(scheduler)
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
    
    func getItems(_ path: String, parameters: Parameters? = nil) -> Observable<[T]> {
        let absolutePath = "\(endPoint)/\(path)/"
        let request = RequestBuilder.shared.build(url: absolutePath, method: .get, parameters: parameters)
        return URLSession.shared.rx
            .data(request: request)
            .observeOn(scheduler)
            .map { data -> [T] in
                return try JSONDecoder().decode([T].self, from: data)
            }
    }
    
    func postItem(_ path: String, parameters: Parameters? = nil, data: [String:Any]? = nil) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)/"
        let request = RequestBuilder.shared.build(url: absolutePath, method: .post, parameters: parameters, data: data)
        return URLSession.shared.rx
            .data(request: request)
            .observeOn(scheduler)
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
    
    func updateItem(_ path: String, itemId: String, parameters: Parameters? = nil) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)/\(itemId)/"
        let request = RequestBuilder.shared.build(url: absolutePath, method: .put, parameters: parameters)
        return URLSession.shared.rx
            .data(request: request)
            .observeOn(scheduler)
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
    
    func deleteItem(_ path: String, itemId: String, parameters: Parameters? = nil) -> Observable<T> {
        let absolutePath = "\(endPoint)/\(path)/\(itemId)/"
        let request = RequestBuilder.shared.build(url: absolutePath, method: .delete, parameters: parameters)
        return URLSession.shared.rx
            .data(request: request)
            .observeOn(scheduler)
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
    
}

public typealias Parameters = [String:String]

class RequestBuilder {
    static var shared = RequestBuilder()
    private init(){}
    
    enum HTTPMethod : String {
        case get     = "GET"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
    }
    
    enum HTTPHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    enum ContentType: String {
        case json = "application/json"
    }
    
    func build(url: String, method: HTTPMethod, parameters: Parameters? = nil, data: [String:Any]? = nil) -> URLRequest {
        let baseURL = URL(string: url)!
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components")
        }
        
        if let params = parameters {
            components.queryItems = params.map {URLQueryItem(name: $0.key, value: $0.value)}
        }
        
        guard let reqUrl = components.url else {
            fatalError("Could not get url")
        }
        
        var request = URLRequest(url: reqUrl)
        request.httpMethod = method.rawValue
        
//        if let _data = data {
//            if let jsonData = try? JSONEncoder().encode(_data) {
//                request.httpBody = jsonData
//            }
//        }
        
        if let _data = data {
            if let jsonData = try? JSONSerialization.data(withJSONObject: _data) {
                request.httpBody = jsonData
            }
        }
        
        request.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        request.addValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        return request
    }
}
