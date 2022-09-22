//
//  ApiClient.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 20/09/22.
//

import RxSwift
import RxAlamofire
import Alamofire

enum FileUploadExtension: String {
    case jpg
    case png
    case pdf
}

enum ApiResult<Value, Error> {
    
    case success(Value)
    case failure(Error)
    
    init(value: Value) {
        self = .success(value)
    }
    
    init(error: Error) {
        self = .failure(error)
    }
}

class APIClient {
    
    static let shared = { APIClient() }()
    
    // MARK: - SET HEADERS
    var headers: HTTPHeaders {
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        return headers
    }
    
    
    /// Network Call Request
    /// - Parameter endPoint: endpoint your module / API / content
    /// - Returns: return success and mapping to your model or return error mapped to ErrorModel
    func requests<T: Codable> (endPoint: APIConfiguration) -> Single<ApiResult<T, ErrorModel>> {
        
        return Single<ApiResult<T, ErrorModel>>.create { single in
            
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: endPoint.urlRequest) { (data, response, error ) in
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    single(.failure(APIClientError.noInternetConnection))
                    return
                }
                
                Logger.debug("STATUSCODE => \(httpResponse.statusCode)")
                
                if 200..<300 ~= httpResponse.statusCode {
                    guard let data = data else {
                        Logger.error("ERROR => " + APIClientError.cannotMapToObject.localizedDescription + " MODEL : \(T.self)")
                        single(.failure(APIClientError.cannotMapToObject))
                        return
                    }
                    
                    do {
                        
                        let model = try JSONDecoder().decode(
                            T.self, from: data
                        )
                        single(.success(.success(model)))
                        
                    } catch let error {
                        Logger.error("ERROR => " + error.localizedDescription + " MODEL : \(T.self)")
                        single(.failure(error))
                        return
                    }
                } else if httpResponse.statusCode == 404 {
                    single(.failure(APIClientError.notFound))
                } else {
                    guard let data = data else {
                        single(.failure(APIClientError.cannotMapToObject))
                        return
                    }
                    
                    do {
                        
                        let model = try JSONDecoder().decode(
                            ErrorModel.self, from: data
                        )
                        
                        single(.success(.failure(model)))
                        
                    } catch let error {
                        single(.failure(error))
                        return
                    }
                }
            }
            
            dataTask.resume()
            
            return Disposables.create {
                dataTask.cancel()
            }
            
        }
        
    }
    
    
    /// UPLOAD FILES (pdf/img/*)
    /// - Parameter endPoint: endpoint API
    /// - Returns: return success or error and already mapping to Model
    static func upload<T: Codable>(endPoint: APIConfiguration, file: Data?, parameters: [String: String]?, fileType: FileUploadExtension) -> Observable<ApiResult<T, ErrorModel>> {
        
        return Observable<ApiResult<T, ErrorModel>>.create({ observer in
            
            Logger.info("UPLOADING TO URL \(endPoint.components.url!)")
            
            AF.upload(multipartFormData: { multiPartData in
                
                if let params = parameters {
                    params.forEach { key, value in
                        multiPartData.append(value.data(using: .utf8)!, withName: key)
                    }
                }
                
                if let fileData = file {
                    if fileType == .pdf {
                        multiPartData.append(fileData, withName: "file" , fileName: "file", mimeType: "application/pdf")
                    } else {
                        multiPartData.append(fileData, withName: "file" , fileName: "file", mimeType: "image/jpeg")
                    }
                }
                
            },
            to: "\(endPoint.components.url!)",
            method: .post,
            headers: shared.headers)
            .validate(statusCode: 200..<400)
            .responseData { response in
                
                guard let httpResponseStatusCode = response.response?.statusCode else {
                    observer.onError(APIClientError.internalServerError)
                    return
                }
                
                Logger.info("STATUS CODE \(httpResponseStatusCode)")
                
                guard let responseData = response.data else { return }
                
                if 200..<300 ~= httpResponseStatusCode {
                    do {
                        let model = try JSONDecoder().decode(T.self, from: responseData)
                        observer.onNext(.success(model))
                    } catch {
                        observer.onError(APIClientError.cannotMapToObject)
                    }
                } else {
                    
                    do {
                        let model = try JSONDecoder().decode(ErrorModel.self, from: responseData)
                        observer.onNext(.failure(model))
                    } catch {
                        observer.onError(APIClientError.cannotMapToObject)
                    }
                    
                }
                
            }
            return Disposables.create();
        })
        
    }
    
}
