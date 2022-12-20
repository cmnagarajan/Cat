//
//  CatViewModel.swift
//  Cat
//
//  Created Nags on 12/17/22.
//

import Foundation

// sourcery: AutoMockable
protocol CatViewModelProtocol {
    func fetchData()
    func didReceiveUISelect(object: Cat)
}

class CatViewModel {
    var view : CatViewProtocol!
    var object = Cat(catService: CatService())
    
    func fetchData() {
        object.didFetch(withSuccess: { (success) in
            self.view.viewWillPresent(data: success)
        }) { (err) in
            debugPrint("Error happened", err as Any)
        }
    }
    
    func didReceiveUISelect(object: Cat) {
        debugPrint("Did receive UI object", object)
    }
}


class CatViewModelProtocolMock: CatViewModelProtocol {

    //MARK: - fetchData

    var fetchDataCallsCount = 0
    var fetchDataCalled: Bool {
        return fetchDataCallsCount > 0
    }
    var fetchDataClosure: (() -> Void)?

    func fetchData() {
        fetchDataCallsCount += 1
        fetchDataClosure?()
    }

    //MARK: - didReceiveUISelect

    var didReceiveUISelectObjectCallsCount = 0
    var didReceiveUISelectObjectCalled: Bool {
        return didReceiveUISelectObjectCallsCount > 0
    }
    var didReceiveUISelectObjectReceivedObject: Cat?
    var didReceiveUISelectObjectReceivedInvocations: [Cat] = []
    var didReceiveUISelectObjectClosure: ((Cat) -> Void)?

    func didReceiveUISelect(object: Cat) {
        didReceiveUISelectObjectCallsCount += 1
        didReceiveUISelectObjectReceivedObject = object
        didReceiveUISelectObjectReceivedInvocations.append(object)
        didReceiveUISelectObjectClosure?(object)
    }

}
