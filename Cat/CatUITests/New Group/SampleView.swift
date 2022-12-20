//
//  SampleView.swift
//  Cat
//
//  Created Nags on 12/18/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//  Generated using MVVM Module Generator by Mohamad Kaakati
//  https://github.com/Kaakati/MVVM-Template-Generator
//

import UIKit

protocol SampleViewProtocol {
    func viewWillPresent(data: Sample)
}

class SampleView: UIViewController, SampleViewProtocol {
    
    private var ui = SampleUI()
    var viewModel : SampleViewModel! {
        willSet {
            newValue.view = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.fetchData()
    }
    
    override func loadView() {
        ui.delegate = self
        view = ui
    }
    
    func viewWillPresent(data: Sample) {
        ui.object = data
    }
}

extension SampleView : SampleUIDelegate {
    func uiDidSelect(object: Sample) {
        viewModel.didReceiveUISelect(object: object)
    }
}
