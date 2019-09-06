//
//  APIConfiguration.swift
//  Musicly
//
//  Created by Egzon Pllana on 8/10/19.
//  Copyright © 2019 Native Coders. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Platform URL
/* construct the base url with the api */

public struct PlatformURL {
    private init() {}

    private static let baseURL = "http://ws.audioscrobbler.com/"
    static let auth: String = "\(baseURL)/auth"
    static let api: String = baseURL
    static let path: String = "/2.0/"
}

// MARK: - Header Keys

struct HTTPHeaderField {
    static let authentication = "Authorization"
    static let contentType = "Content-Type"
    static let acceptType = "Accept"
    static let acceptEncoding = "Accept-Encoding"
}

// MARK: - Content type

struct ContentType {
    static let json = "application/json"
    static let multipartFormData = "multipart/form-data"
}

// MARK: - API configuration Protocol

protocol APIConfiguration: URLRequestConvertible {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get }
    var query: String { get } /* only for "/?" requests */
    var requiresAuth: Bool { get }
    var multipartFormData: ((MultipartFormData) -> Void)? { get }
}

extension APIConfiguration {
    var method: HTTPMethod { return .get }
    var parameters: Parameters? { return nil }
    var requiresAuth: Bool { return false }
    var query: String { return query } /* only for "/?" requests */
    var multipartFormData: ((MultipartFormData) -> Void)? { return nil }
}

extension APIConfiguration {
    func asURLRequest() throws -> URLRequest {
        /*
         // construct URL
         let url = try PlatformURL.api.asURL().appendingPathComponent(path)
         // construct URLRequest
         var urlRequest = URLRequest(url: url)
         */

        // [Start of: last.fm urlComponents modification]
        // API functions of last.fm api is using "/?" mark for endpoints, there comes a conflict with URL request for ios.
        // We hade to construct new way with urlComponents and add new parameter query in APIConfigurations.

        var urlComponents = URLComponents(string: PlatformURL.api)!
        urlComponents.path = PlatformURL.path
        urlComponents.query = query

        // construct URLRequest
        var urlRequest = URLRequest(url: urlComponents.url!)
        // [End of: last.fm urlComponents modification]

        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        //nultipart form data
        if multipartFormData != nil {
            urlRequest.setValue(ContentType.multipartFormData, forHTTPHeaderField: HTTPHeaderField.contentType)
        } else {
            urlRequest.setValue(ContentType.json, forHTTPHeaderField: HTTPHeaderField.contentType)
        }

        /*
         if requiresAuth, let sessionToken = "generatedToken" {
         urlRequest.addValue(sessionToken, forHTTPHeaderField: HTTPHeaderField.authentication)
         }
         */

        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }

        return urlRequest
    }

}
