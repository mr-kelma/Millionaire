//
//  ViewController.swift
//  Millionaire
//
//  Created by Valery Keplin on 31.10.22.
//

import UIKit

class StartViewController: UIViewController {
    
    //MARK: - UIElements
    
    private let backgroundView: UIImageView = {
        let image = UIImage(named: "background")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let logoView: UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 15
        button.setTitle("НАЧАТЬ ИГРУ", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var ruleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 15
        button.setTitle("ПРАВИЛА ИГРЫ", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(ruleButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHierarchy()
        setupStartButton()
        playSound(resource: "startApp")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - Setups
    
    private func setupHierarchy() {
        view.addSubview(backgroundView)
        view.addSubview(startButton)
        view.addSubview(ruleButton)
        view.addSubview(logoView)
    }

    private func setupStartButton() {
        NSLayoutConstraint.activate([
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -180),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            startButton.heightAnchor.constraint(equalToConstant: 60),

            ruleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            ruleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            ruleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            ruleButton.heightAnchor.constraint(equalToConstant: 60),

            logoView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            logoView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
            logoView.widthAnchor.constraint(equalToConstant: 300),
            logoView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }

    //MARK: - Actions

    @objc private func startButtonAction() {
        let gameViewController = GameViewController()
        self.navigationController?.pushViewController(gameViewController, animated: true)
        let gameBrain = GameBrain()
        gameViewController.gameBrain = gameBrain
        gameBrain.getQuestion()
        playSound(resource: "waitForResponse")
    }

    @objc private func ruleButtonAction() {
        let ruleViewController = RuleViewController()
        self.navigationController?.pushViewController(ruleViewController, animated: true)
    }

}
