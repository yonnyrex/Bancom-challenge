//
//  NetworkManager.swift
//  Bancom
//
//  Created by Yonny on 7/11/23.
//

import Foundation
import Combine

class ApiPath {
    static let URL = "https://jsonplaceholder.typicode.com/"
}

class NetworkManager {
    
    private var cancellables = Set<AnyCancellable>()
    
    static let shared = NetworkManager()
    
    func genericRequestCustomer<T: Decodable, U: Encodable>(
        method: HttpMethod = .get,
        baseUrl: String,
        extraPath: String = "",
        headers: [String: String] = [:],
        body: U? = EmptyBodyEncodable(),
        typeResponse: T.Type
    ) -> Future<T, Error>{
    
        guard let url = URL(string: baseUrl + extraPath) else {
            return Future { promise in
                promise(.failure(NetworkError.invalidURL))
            }
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        
        if let body = body {
            let emptyBodyCast = body as? EmptyBodyEncodable
            if emptyBodyCast == nil && method != .get {
                do {
                    
                    let jsonData = try JSONEncoder().encode(body)
                    
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.httpBody = jsonData

                } catch {
                    return Future { promise in
                        promise(.failure(NetworkError.errorEncodingRequestBody))
                    }
                }
            }
        }
        
        if !headers.isEmpty {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        
        let session = URLSession(configuration: configuration)
        
        return Future<T, Error> { [weak self] promise in
            
            guard let self = self else {
                return promise(.failure(NetworkError.unknown))
            }
            
            session.dataTaskPublisher(for: request)
                .tryMap { (data, response) in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw NetworkError.responseError
                    }
                    if 200..<300 ~= httpResponse.statusCode {
                        return data
                    } else {
                        throw NetworkError.responseError
                    }
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(
                    receiveCompletion: { (completion) in
                        if case let .failure(error) = completion {
                            switch error {
                            case let urlError as URLError:
                                promise(.failure(urlError))
                            case let decodingError as DecodingError:
                                promise(.failure(decodingError))
                            case let apiError as NetworkError:
                                promise(.failure(apiError))
                            default:
                                promise(.failure(NetworkError.unknown))
                            }
                        }
                    },
                    receiveValue: { promise(.success($0)) }
                )
                .store(in: &self.cancellables)
        }
    }
}

enum HttpMethod: String {
    case post = "POST"
    case get = "GET"
}

struct EmptyBodyEncodable: Codable {}

enum NetworkError: Error {
    case invalidURL
    case decodingError
    case errorEncodingRequestBody
    case responseError
    case unknown
}

extension NetworkError: LocalizedError {
    var errorMessage: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .decodingError:
            return NSLocalizedString("Decoding error from server", comment: "DecodingError")
        case .errorEncodingRequestBody:
            return NSLocalizedString("Invalid response", comment: "Invalid response")
        case .responseError:
            return NSLocalizedString("Error encoding body request", comment: "Error encoding body request")
        case .unknown:
            return NSLocalizedString("Unknow error", comment: "Unknown error")
        }
    }
}
