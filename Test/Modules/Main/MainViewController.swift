//
//  MainViewController.swift
//  Test
//
//  Created by Eryk Chrustek on 30/06/2021.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: Properties
    
    var interactor: MainBusinessLogic?
    var router: MainRouting?
    
    // MARK: Subviews

    private var textField = UITextField()
    private var button = UIButton()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator()
        setup()
        setupButton()
        setupTextField()
        hideKeyboard()
    }

    // MARK: Setup
    
    private func setup() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        [textField, button].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 200),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTextField() {
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(string: "Enter ID", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        textField.textColor = .white
        textField.keyboardType = UIKeyboardType.numberPad
        textField.textAlignment = .center
        
        textField.layer.cornerRadius = 15
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.cyan.cgColor
    }
    
    private func setupButton() {
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .cyan.withAlphaComponent(0.7)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(searchButtonAction), for: .touchUpInside)
    }
    
    // MARK: Actions
    
    @objc
    private func searchButtonAction() {
        searchCharacter(for: Int(textField.text ?? "1") ?? 1)
        textField.text = ""
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Private methods
    
    private func searchCharacter(for id: Int) {
        interactor?.searchCharacter(request: Main.Search.Request(characterId: id))
    }
    
    private func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
}

extension MainViewController: MainDisplayLogic {
    func displayCharacter(viewModel: Main.Search.ViewModel) {
        router?.routeToCharacter()
    }
}

extension MainViewController {
    func configurator() {
        let viewController = self
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        let router = MainRouter()
        let gateway = GatewayInstance()
        
        viewController.interactor = interactor
        viewController.router = router
        viewController.router?.dataStore = viewController.interactor as? MainDataStore
        viewController.router?.viewController = viewController
        
        interactor.presenter = presenter
        interactor.gateway = gateway
        
        presenter.viewController = viewController
        presenter.attach(viewController: viewController)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
            textField.resignFirstResponder()
            return true;
        }
}
