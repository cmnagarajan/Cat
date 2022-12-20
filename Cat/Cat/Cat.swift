//
//  Cat.swift
//  Cat
//
//  Created Nags on 12/17/22.
//

/// Cat Model
struct  Cat {
    typealias didFetchSuccess = (Cat)->()
    typealias didFailWithError = (Error?) -> ()
    
    var imageURL : String = "http://placekitten.com/200/300"
    var fact : String?
    var catService : CatServiceProtocol!
    
    init(catService: CatServiceProtocol!) {
        self.catService = catService
    }
    
    init(imageURL: String, fact: String? = nil) {
        self.imageURL = imageURL
        self.fact = fact
    }
    
    func didFetch(withSuccess: @escaping didFetchSuccess, withError: @escaping didFailWithError) {
        catService.fetchCatFact() { result in
            switch result {
            case .success(let fact):
                withSuccess(Cat(imageURL: imageURL, fact: fact))
            case .failure(_):
                withError(nil)
            }
        }
    }
}
