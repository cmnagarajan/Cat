//
//  CatView.swift
//  Cat
//
//  Created Nags on 12/17/22.
//

import UIKit

protocol CatViewProtocol {
    func viewWillPresent(data: Cat)
}

class CatView: UIViewController, CatViewProtocol {
    
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var catFactLabel: UILabel!
    
    private var ui = CatUI()
    var viewModel : CatViewModel! {
        willSet {
            newValue.view = self
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel = CatViewModel()
        viewModel?.fetchData()
    }
    
    override func loadView() {
        ui.delegate = self
        self.view = ui
    }
    
    func viewWillPresent(data: Cat) {
        ui.object = data
    }
}

extension CatView : CatUIDelegate {
    func uiDidSelect(object: Cat) {
        viewModel.didReceiveUISelect(object: object)
    }
    
    func onButtonTap(){
        viewModel?.fetchData()
    }
}
