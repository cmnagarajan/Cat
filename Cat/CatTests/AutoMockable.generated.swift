// Generated using Sourcery 1.9.2 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT
// swiftlint:disable line_length
// swiftlint:disable variable_name

import Foundation
#if os(iOS) || os(tvOS) || os(watchOS)
import UIKit
#elseif os(OSX)
import AppKit
#endif






















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

