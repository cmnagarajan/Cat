//
//  CatService.swift
//  Cat
//
//  Created by Nags on 12/17/22.
//

import Foundation

// This will also be used to "mock" the service.
// sourcery: AutoMockable
protocol CatServiceProtocol {
    func fetchCatFact(completion: @escaping (Result<String, Error>) -> Void)
}

// A concrete implementation of the Cat service.
final class CatService: CatServiceProtocol {

    private let baseUrlString = "https://meowfacts.herokuapp.com/"
    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    struct CatFactResult : Decodable {
        let data : [String]
    }
    
    func fetchCatFact(completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: baseUrlString) else { return }
    
        urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            do {
                let catFunFact = try JSONDecoder().decode(CatFactResult.self, from: data!)
                if catFunFact.data.count > 0 {
                    completion(.success(catFunFact.data[0]))
                }
            } catch let err {
                completion(.failure(err))
            }
        }.resume()
    }
}


class CatServiceProtocolMock: CatServiceProtocol {

    //MARK: - fetchCatFact

    var fetchCatFactCompletionCallsCount = 0
    var fetchCatFactCompletionCalled: Bool {
        return fetchCatFactCompletionCallsCount > 0
    }
    var fetchCatFactCompletionReceivedCompletion: ((Result<String, Error>) -> Void)?
    var fetchCatFactCompletionReceivedInvocations: [((Result<String, Error>) -> Void)] = []
    var fetchCatFactCompletionClosure: ((@escaping (Result<String, Error>) -> Void) -> Void)?

    func fetchCatFact(completion: @escaping (Result<String, Error>) -> Void) {
        fetchCatFactCompletionCallsCount += 1
        fetchCatFactCompletionReceivedCompletion = completion
        fetchCatFactCompletionReceivedInvocations.append(completion)
        fetchCatFactCompletionClosure?(completion)
    }

}
