//
//  Networking.swift
//  FoodmanduSwiftUI
//
//  Created by manjil on 02/01/2023.
//

import Foundation

protocol NetworkConformable {
    static func initialize(with config: NetworkingConfiguration)
    func dataRequest<O>(router: NetworkingRouter ,type: O.Type) async throws -> O where O: Decodable
    func multipartRequest<O>(router: NetworkingRouter, multipart: [File], type: O.Type) async throws -> O where O: Decodable
}

class Networking: NetworkConformable {
    /// make the instance shared
    public static let `default` = Networking()
    private init() {}
    
    /// The networking configuration
    private var config: NetworkingConfiguration?
    
    var apiKey: String? {
        config?.apiKey
    }
    
    /// Method to set the configuration from client side
    /// - Parameter config: The networking configuration
    static func initialize(with config: NetworkingConfiguration) {
        Networking.default.config = config
    }
    
    /// Method to create a response publisher for data
    func dataRequest<O>(router: NetworkingRouter, type: O.Type)  async throws -> O  where O: Decodable {
        try  await createAndPerformRequest(router, config: Networking.default.config, multipart: [])
    }
    
    /// Method to create a response publisher for data
    func multipartRequest<O>(router: NetworkingRouter, multipart: [File], type: O.Type) async throws -> O  where O: Decodable{
        try await createAndPerformRequest(router, config: Networking.default.config, multipart: multipart)
    }
    
    private func createAndPerformRequest<O>(_ router: NetworkingRouter, config: NetworkingConfiguration?, multipart: [File]) async throws -> O where O: Decodable {
        guard let config = config else {
            throw NetworkingError(.networkingNotInitialized)
        }
        
        guard Connectivity.default.status == .connected else {
            throw NetworkingError(.noConnectivity)
        }
        let requestMaker = RequestMaker(router: router, config: config)
        
        let result: RequestMaker.NetworkResult<O> = await (multipart.isEmpty ?   requestMaker.makeDataRequest() :  requestMaker.makeMultiRequest(multipart: multipart))
        switch result {
        case .success(let data):
            if let model = data.object  {
//                var  response = Response(data: model, statusCode: data.statusCode)
//                response.meta = data.object?.meta
                return model
            }
//            if let error = data.object?.errors?.first {
//                throw NetworkingError(error.detail ?? "NO_DETAIL_ERROR", code: error.code ?? 0)
//            }
        case .failure(let error):
            throw error
        }
        
        throw NetworkingError("SOMETHING_WENT_WRONG")
    }
}
