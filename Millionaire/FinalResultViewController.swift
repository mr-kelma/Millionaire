//
//  FourViewController.swift
//  Millionaire
//
//  Created by Sergio on 31.10.22.
//

import UIKit

class FinalResultViewController: UIViewController{
    
    //MARK: - UIElements
    
    private let backgroundView: UIImageView = {
        let image = UIImage(named: "background")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var result: UILabel = {
        let heading = UILabel()
        let myAttribute = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 45, weight: .semibold),NSAttributedString.Key.foregroundColor: UIColor.white,]
        let myString = NSMutableAttributedString(string:"Вы выиграли \n\n 1 000 000  \n\nрублей!", attributes: myAttribute)
        var anotherAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 45, weight: .bold),NSAttributedString.Key.foregroundColor: UIColor.yellow,]
        myString.addAttributes(anotherAttribute, range: myString.getRangeOfString(textToFind: "1 000 000"))
        heading.attributedText = myString
        heading.font = UIFont.systemFont(ofSize: 45, weight: .semibold)
        heading.numberOfLines = 5
        heading.textAlignment = .center
        heading.translatesAutoresizingMaskIntoConstraints = false
        return heading
    }()
    
    private lazy var backToMainScreenButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.layer.cornerRadius = 15
        button.setTitle("ГЛАВНОЕ МЕНЮ", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        button.addTarget(self, action: #selector(backToMainScreenButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        setupHierarchy()
        setupResult()
        setupBackToMainScreenButton()
        setupBackgroundView()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(playSoundOfVictory), userInfo: nil, repeats: false)
    }
    
    //MARK: - Setups
    
    private func setupHierarchy() {
        view.addSubview(backgroundView)
        view.addSubview(result)
        view.addSubview(backToMainScreenButton)
    }
    
    private func setupResult(){
        self.result.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        self.result.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120).isActive = true
        self.result.heightAnchor.constraint(equalToConstant: 300).isActive = true
        self.result.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
    
    private func setupBackToMainScreenButton() {
        self.backToMainScreenButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80).isActive = true
        self.backToMainScreenButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50).isActive = true
        self.backToMainScreenButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50).isActive = true
        self.backToMainScreenButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }

    private func setupBackgroundView() {
        self.backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    @objc private func playSoundOfVictory() {
        playSound(resource: "victoryMillion")
    }
    
    //MARK: - Actions
    
    @objc private func backToMainScreenButtonAction() {
        self.navigationController?.popToRootViewController(animated: true)
        player.stop()
   }
}
