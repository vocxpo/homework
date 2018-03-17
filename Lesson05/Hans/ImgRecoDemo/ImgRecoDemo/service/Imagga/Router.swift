//
//  Router.swift
//  Imagga
//
//  Created by oopx on 2018/03/12.
//  Copyright © 2018年 oopx. All rights reserved.
//

import Foundation
import Alamofire

public enum ImaggaRouter: URLRequestConvertible {
    // add Allow Arbitrary Loads: YES to allow http transport
    static let baseURL = "http://api.imagga.com/v1"
    static let authenticationToken = "Basic YWNjX2QyZWVhNjYxYzZlOTA4MDplMjk5NDhkYTExOTQwMTE0OTc5MzAxODJjMjZlYTRhZg=="
    
    case content
    case tags(String)
    case colors(String)
    
    // method is defaulted to post
    var method: HTTPMethod {
        switch self {
        case .content:
            return .post
        case .tags, .colors:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .content:
            return "/content"
        case .tags:
            return "/tagging"
        case .colors:
            return "/colors"
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let parameters: [String: Any] = {
            switch self {
            case .tags(let contentID):
                return ["content": contentID]
            case .colors(let contentID):
                return ["content": contentID, "extract_object_colors": 0]
            default:
                return [:]
            }
        }()
        
        let url = try ImaggaRouter.baseURL.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        request.setValue(ImaggaRouter.authenticationToken, forHTTPHeaderField: "Authorization")
        request.timeoutInterval = TimeInterval(10 * 1000)
        
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
