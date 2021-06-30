//
//  CharacterDetailsViewController.swift
//  Test
//
//  Created by Eryk Chrustek on 30/06/2021.
//

import UIKit

final class CharacterDetailsViewController: UIViewController {
    
    // MARK: Properties
    
    var characterId: Int?
    var interactor: CharacterDetailsBusinessLogic?
    var router: CharacterDetailsRouting?
    
    // MARK: Subviews
    
    private var stackView = UIStackView()

    private var nameView = UIView()
    private var nameTitle = UILabel()
    private var nameValue = UILabel()
    
    private var genderView = UIView()
    private var genderTitle = UILabel()
    private var genderValue = UILabel()
    
    private var image = UIImageView()
    
    private var episodeListView = UIView()
    private var episodeListTitle = UILabel()
    private var episodeListValue = UILabel()
    
    private var button = UIButton()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator()
        setup()
        prepareContent()
        setupStackView()
        setupElements()
    }

    // MARK: Setup
    
    private func setup() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor(named: "background")
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
    
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func setupStackView() {
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .center
        
        [nameTitle, nameValue, genderTitle, genderValue, image, episodeListTitle, episodeListValue].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 200),
            image.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupElements() {
        let font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        nameTitle.font = font
        genderTitle.font = font
        episodeListTitle.font = font
        nameTitle.text = "Name:"
        genderTitle.text = "Gender:"
        episodeListTitle.text = "Appeared in episodes:"
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 15
    }

    // MARK: Private methods
    
    private func prepareContent() {
        guard let id = characterId else { return }
        interactor?.prepareContent(request: CharacterDetails.Content.Request(characterId: id))
    }
    
    private func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.main.async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            let image = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image.image = image
            }
        }
    }
    
    private func showError() {
        let alert = UIAlertController(title: "Error", message: "Incorrect ID entered", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}

extension CharacterDetailsViewController: CharacterDetailsDisplayLogic {
    func displayContent(viewModel: CharacterDetails.Content.ViewModel) {
        DispatchQueue.main.async {
            guard let data = viewModel.details else {
                self.showError()
                return
            }
                self.nameValue.text = data.name
                self.genderValue.text = data.gender
                self.episodeListValue.text = data.episodeList
                self.setImage(from: data.avatar)
        }
    }
}

extension CharacterDetailsViewController {
    func configurator() {
        let viewController = self
        let interactor = CharacterDetailsInteractor()
        let presenter = CharacterDetailsPresenter()
        let router = CharacterDetailsRouter()
        let gateway = GatewayInstance()

        viewController.interactor = interactor
        viewController.router = router
        viewController.router?.viewController = viewController
        viewController.router?.dataStore = viewController.interactor as? CharacterDetailsDataStore

        interactor.presenter = presenter
        interactor.gateway = gateway

        presenter.viewController = viewController
        presenter.attach(viewController: viewController)
    }
}
