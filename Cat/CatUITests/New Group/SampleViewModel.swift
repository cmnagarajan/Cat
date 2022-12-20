//
//  SampleViewModel.swift
//  Cat
//
//  Created Nags on 12/18/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//  Generated using MVVM Module Generator by Mohamad Kaakati
//  https://github.com/Kaakati/MVVM-Template-Generator
//

import Foundation

protocol SampleViewModelProtocol {
    func fetchData()
    func didReceiveUISelect(object: Sample)
}

class SampleViewModel {
    var view : SampleViewProtocol!
    var object = Sample()
    
    func fetchData() {
        object.didFetch(withSuccess: { (success) in
            self.view.viewWillPresent(data: success)
        }) { (err) in
            debugPrint("Error happened", err as Any)
        }
    }
    
    func didReceiveUISelect(object: Sample) {
        debugPrint("Did receive UI object", object)
    }
}