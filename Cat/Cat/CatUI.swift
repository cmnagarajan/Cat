//
//  CatUI.swift
//  Cat
//
//  Created Nags on 12/17/22.
//

import UIKit

protocol CatUIDelegate {
    func uiDidSelect(object: Cat)
    func onButtonTap()
}

class CatUI : UIView {
    var delegate: CatUIDelegate!
    
    var object : Cat?  {
        didSet {
            updateUI()
        }
    }
    
    var catImageView : UIImageView?
    var catFactLabel : UILabel?
    var catButton : UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    func makeLabel(withText text: String) -> UILabel {
        let label = PaddingLabel()
        label.padding(10, 10, 8, 8)
        label.translatesAutoresizingMaskIntoConstraints = false // important!
        label.numberOfLines = 0
        label.text = text
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = .init(red: 20, green: 0, blue: 100, alpha: 0.5)
        label.layer.cornerRadius = 15
        label.layer.isHidden = text.count == 0 ? true : false
        return label
    }
    
    func makeImage() -> UIImageView {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.layer.borderWidth = 1
        iv.layer.borderColor = .init(red: 20, green: 0, blue: 200, alpha: 0.25)
        iv.layer.cornerRadius = 15
        return iv
    }
    
    func makeButton() -> UIButton {
        let button = UIButton(type: .custom, primaryAction: UIAction(handler: { _ in
            self.delegate.onButtonTap()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tap", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .init(red: 20, green: 0, blue: 200, alpha: 1)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.contentEdgeInsets = UIEdgeInsets(
          top: 10,
          left: 20,
          bottom: 10,
          right: 20
        )
        return button
    }
    
    func updateUI() -> Void {
        guard let funFact = self.object?.fact else { return }
        guard let imageURL = self.object?.imageURL else { return }

        DispatchQueue.global(qos: .userInteractive).async {
                guard let url = URL(string: imageURL) else { return }
                let imageData = try? Data(contentsOf: url as URL)
                DispatchQueue.main.async { [weak self] in
                    self?.catFactLabel?.text = funFact
                    self?.catFactLabel?.layer.isHidden = false
                    guard let imageData = imageData else { return }
                    if let image = UIImage(data: imageData) {
                        self?.catImageView?.image = image
                        self?.catImageView?.sizeToFit()
                    }
                }
        }
    }
}

extension CatUI {

    private func setupUIElements() {
        // arrange subviews
        self.backgroundColor = .white
        
        catFactLabel = makeLabel(withText: "")
        catImageView = makeImage()
        catButton = makeButton()
        
        guard let catFactLabel = catFactLabel else { return }
        guard let catImageView = catImageView else { return }
        guard let catButton = catButton else { return }
        addSubview(catFactLabel)
        addSubview(catImageView)
        addSubview(catButton)

        NSLayoutConstraint.activate([
            catImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            catImageView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 5),
            catImageView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -5),
            catFactLabel.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 10),
            catFactLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor, constant: 5),
            catFactLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor, constant: -5),
            catButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -80),
            catButton.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

