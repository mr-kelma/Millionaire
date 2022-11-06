//
//  TwoViewController.swift
//  Millionaire
//
//  Created by Sergio on 31.10.22.
//

import UIKit

class GameViewController: UIViewController {
    
    //MARK: - Properties
    
    var gameBrain: GameBrain?
    private let aButton = CustomButton()
    private let bButton = CustomButton()
    private let cButton = CustomButton()
    private let dButton = CustomButton()
    var currentTitleAnswerButton: String?
    var tagButton: Int?
    var check: Bool?
    var gameTimer = Timer()
    var durationGAmeTimer = 30
    
    var fiftyFifty: Bool = true
    var helpHall: Bool = true
    var possibleError: Bool = true
    var isRepeatedAnswerAllowed: Bool = false
    var answeredSecondTime: Bool = false
    
    //MARK: - UIElements
    
    private let backgroundView: UIImageView = {
        let image = UIImage(named: "background")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private func helpButton(text: String, action: Selector) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .yellow
        button.setImage(UIImage(named: text), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        button.setTitleColor(.black, for: .normal)
        button.clipsToBounds = true
        button.addTarget(self, action: action, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
    
    private lazy var fiftyButton = helpButton(text: "dices.png", action: #selector(fiftyButtonAction))
    private lazy var hallHelpButton = helpButton(text: "people.png", action: #selector(hallHelpButtonAction))
    private lazy var possibleErrorButton = helpButton(text: "mistake.png", action: #selector(possibleErrorButtonAction))
    
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "30"
        label.font = .systemFont(ofSize: 60)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var questionsLabel: UILabel = {
        let label = UILabel()
        label.text = gameBrain?.currentQuestion
        label.numberOfLines = 7
        label.font = label.font.withSize(28)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startTimer()
        setupHierarchy()
        setupLayout()
        answerButton()
        setNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Вопрос на \(gameBrain?.numberOfQuestionText ?? "")"
        updateAnswerButtons()
        durationGAmeTimer = 30
        setNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        fiftyButton.layer.cornerRadius = fiftyButton.frame.width / 2
        possibleErrorButton.layer.cornerRadius = fiftyButton.frame.width / 2
        hallHelpButton.layer.cornerRadius = fiftyButton.frame.width / 2
    }
    
    private func answerButton() {
        aButtonTapped()
        bButtonTapped()
        cButtonTapped()
        dButtonTapped()
    }
    
    private func aButtonTapped() {
        aButton.tag = 1
        aButton.setTitle(gameBrain?.currentAnswerA, for: .normal)
        aButton.setTitleColor(.black, for: .normal)
        aButton.addTarget(self, action: #selector(aButtonAction), for: .touchUpInside)
    }
    
    private func bButtonTapped() {
        bButton.tag = 2
        bButton.setTitle(gameBrain?.currentAnswerB, for: .normal)
        bButton.setTitleColor(.black, for: .normal)
        bButton.addTarget(self, action: #selector(bButtonAction), for: .touchUpInside)
    }
    
    private func cButtonTapped() {
        cButton.tag = 3
        cButton.setTitle(gameBrain?.currentAnswerC, for: .normal)
        cButton.setTitleColor(.black, for: .normal)
        cButton.addTarget(self, action: #selector(cButtonAction), for: .touchUpInside)
    }
    
    private func dButtonTapped() {
        dButton.tag = 4
        dButton.setTitle(gameBrain?.currentAnswerD, for: .normal)
        dButton.setTitleColor(.black, for: .normal)
        dButton.addTarget(self, action: #selector(dButtonAction), for: .touchUpInside)
        
    }
    
    //MARK: - Setups
    
    private func setupHierarchy() {
        view.addSubview(backgroundView)
        view.addSubview(questionsLabel)
        view.addSubview(fiftyButton)
        view.addSubview(hallHelpButton)
        view.addSubview(possibleErrorButton)
        view.addSubview(timeLabel)
        view.addSubview(aButton)
        view.addSubview(bButton)
        view.addSubview(cButton)
        view.addSubview(dButton)
    }
    
    private func updateAnswerButtons() {
        aButton.backgroundColor = .yellow
        bButton.backgroundColor = .yellow
        cButton.backgroundColor = .yellow
        dButton.backgroundColor = .yellow
        (aButton.isEnabled, bButton.isEnabled, cButton.isEnabled, dButton.isEnabled) = (true, true, true, true)
        (fiftyButton.isEnabled, hallHelpButton.isEnabled, possibleErrorButton.isEnabled) = (true, true, true)
    }
    
    private func startTimer() {
        gameTimer = Timer.scheduledTimer(timeInterval: 1,
                                         target: self,
                                         selector: (#selector(updateTimer)),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    private func setNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "xmark.circle"),
            style: .done,
            target: self,
            action: #selector(gameOver))
        if gameBrain!.numberOfQuestion > 1 {
            let userInfoButton = createCustomButton(selector: #selector(tachMoneyButton))
            navigationItem.rightBarButtonItem = userInfoButton
        }
    }
    
    private func hideNavigationBarItems() {
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func checkAnswer() {
        check = gameBrain?.checkAnswer(currentTitleAnswerButton!)
        switch tagButton {
        case 1:
            if check! {
                aButton.backgroundColor = .green
                playSound(resource: "correctAnswer")
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(goToLevelListViewController), userInfo: nil, repeats: false)
            } else {
                aButton.backgroundColor = .red
                if !answeredSecondTime && !possibleError{
                    startTimer()
                }
                playSound(resource: "wrongAnswer")
                if possibleError || (!possibleError && answeredSecondTime){
                    showAlertWrongAnswer()
                }
            }
        case 2:
            if check! {
                bButton.backgroundColor = .green
                playSound(resource: "correctAnswer")
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(goToLevelListViewController), userInfo: nil, repeats: false)
            } else {
                bButton.backgroundColor = .red
                if !answeredSecondTime && !possibleError{
                    startTimer()
                }
                playSound(resource: "wrongAnswer")
                if possibleError || (!possibleError && answeredSecondTime){
                    showAlertWrongAnswer()
                }
            }
        case 3:
            if check! {
                cButton.backgroundColor = .green
                playSound(resource: "correctAnswer")
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(goToLevelListViewController), userInfo: nil, repeats: false)
            } else {
                cButton.backgroundColor = .red
                if !answeredSecondTime && !possibleError{
                    startTimer()
                }
                playSound(resource: "wrongAnswer")
                if possibleError || (!possibleError && answeredSecondTime){
                    showAlertWrongAnswer()
                }
            }
        case 4:
            if check! {
                dButton.backgroundColor = .green
                playSound(resource: "correctAnswer")
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(goToLevelListViewController), userInfo: nil, repeats: false)
            } else {
                dButton.backgroundColor = .red
                if !answeredSecondTime && !possibleError{
                    startTimer()
                }
                playSound(resource: "wrongAnswer")
                if possibleError || (!possibleError && answeredSecondTime){
                    showAlertWrongAnswer()
                }
            }
        default:
            print("Error")
        }
    }
    
    @objc func goToLevelListViewController() {
        if gameBrain!.numberOfQuestion < 15 {
            let levelListViewController = LevelListViewController(delegate: self, questions: gameBrain?.questions ?? [], numberOfCompletedQuestions: gameBrain?.numberOfQuestion ?? 0)
            navigationController?.pushViewController(levelListViewController, animated: true)
        } else {
            let finalResultViewController = FinalResultViewController()
            navigationController?.pushViewController(finalResultViewController, animated: true)
        }
    }
    
    //MARK: - Button Action
    
    @objc func updateTimer() {
        durationGAmeTimer -= 1
        timeLabel.text = "\(durationGAmeTimer)"
        if durationGAmeTimer == 0 {
            gameTimer.invalidate()
            timeLabel.text = ""
            showAlertEndOfTime()
        }
    }
    
    // MARK: - 50/50
    
    @objc func fiftyButtonAction() {
        if fiftyFifty{
            fiftyButton.backgroundColor = .white
            let correctAnswer = gameBrain?.currentAnswerCA
            let wrongAnswers = [gameBrain?.currentAnswerA,
                                gameBrain?.currentAnswerB,
                                gameBrain?.currentAnswerC,
                                gameBrain?.currentAnswerD]
            var randomWrongAnswer = wrongAnswers.randomElement()
            while (randomWrongAnswer == correctAnswer) {
                randomWrongAnswer = wrongAnswers.randomElement()
            }
            aButton.setTitle(" ", for: .normal)
            bButton.setTitle(" ", for: .normal)
            cButton.setTitle(" ", for: .normal)
            dButton.setTitle(" ", for: .normal)
            (aButton.isEnabled, bButton.isEnabled, cButton.isEnabled, dButton.isEnabled) = (false, false, false, false)
            switch correctAnswer?.prefix(1){
            case "A":
                aButton.setTitle(correctAnswer, for: .normal)
                aButton.isEnabled = true
            case "B":
                bButton.setTitle(correctAnswer, for: .normal)
                bButton.isEnabled = true
            case "C":
                cButton.setTitle(correctAnswer, for: .normal)
                cButton.isEnabled = true
            case "D":
                dButton.setTitle(correctAnswer, for: .normal)
                dButton.isEnabled = true
            case .none:
                print("some error occured")
            case .some(_):
                print("some error occured")
            }
            switch randomWrongAnswer!!.prefix(1){
            case "A":
                aButton.setTitle(randomWrongAnswer!!, for: .normal)
                aButton.isEnabled = true
            case "B":
                bButton.setTitle(randomWrongAnswer!!, for: .normal)
                bButton.isEnabled = true
            case "C":
                cButton.setTitle(randomWrongAnswer!!, for: .normal)
                cButton.isEnabled = true
            case "D":
                dButton.setTitle(randomWrongAnswer!!, for: .normal)
                dButton.isEnabled = true
            default:
                print("some error occured")
            }
            fiftyFifty = false
        } else {
            showAlertHint()
        }
    }
    
    // MARK: - Help hall
    
    @objc func hallHelpButtonAction() {
        if helpHall {
            showInfoHelpHall()
            helpHall = false
            hallHelpButton.backgroundColor = .white
        } else {
            showAlertHint()
        }
    }
    
    func showInfoHelpHall() {
        let alert = UIAlertController(title: "Результат опроса зала",
                                      message: messageForAlertOfHelpHall(),
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func messageForAlertOfHelpHall() -> String {
        let correctAnswer = gameBrain?.currentAnswerCA
        switch correctAnswer?.prefix(1){
        case "A":
            return """
                    
                    A▫️▫️▫️▫️▫️▫️▫️70%
                    B▫️▫️▫️___________15%
                    C▫️_________________5%
                    D▫️▫️_____________10%
                    """
        case "B":
            return """
                    
                    A▫️▫️▫️___________15%
                    B▫️▫️▫️▫️▫️▫️▫️70%
                    C▫️_________________5%
                    D▫️▫️_____________10%
                    """
        case "C":
            return """
                    
                    A▫️_________________5%
                    B▫️▫️▫️___________15%
                    C▫️▫️▫️▫️▫️▫️▫️70%
                    D▫️▫️_____________10%
                    """
        case "D":
            return """
                    
                    A▫️▫️_____________10%
                    B▫️▫️▫️___________15%
                    C▫️_________________5%
                    D▫️▫️▫️▫️▫️▫️▫️70%
                    """
        case .none:
            print("some error occured")
        case .some(_):
            print("some error occured")
        }
        return ""
    }
    
    // MARK: - Possible error
    
    @objc func possibleErrorButtonAction() {
        if possibleError {
            possibleError = false
            isRepeatedAnswerAllowed = true
            possibleErrorButton.backgroundColor = .white
        } else {
            showAlertHint()
        }
    }
    
    //MARK: - Handle buttons
    
    func handleButtons(){
        if possibleError {
            (aButton.isEnabled, bButton.isEnabled, cButton.isEnabled, dButton.isEnabled) = (false, false, false, false)
        } else if isRepeatedAnswerAllowed {
            (aButton.isEnabled, bButton.isEnabled, cButton.isEnabled, dButton.isEnabled) = (true, true, true, true)
            isRepeatedAnswerAllowed = false
            answeredSecondTime = false
        } else {
            (aButton.isEnabled, bButton.isEnabled, cButton.isEnabled, dButton.isEnabled) = (false, false, false, false)
            answeredSecondTime = true
        }
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            fiftyButton.bottomAnchor.constraint(equalTo: questionsLabel.topAnchor, constant: -50),
            fiftyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            fiftyButton.widthAnchor.constraint(equalToConstant: 60),
            fiftyButton.heightAnchor.constraint(equalToConstant: 60),
            
            hallHelpButton.bottomAnchor.constraint(equalTo: questionsLabel.topAnchor, constant: -50),
            hallHelpButton.leadingAnchor.constraint(equalTo: fiftyButton.trailingAnchor, constant: 40),
            hallHelpButton.widthAnchor.constraint(equalToConstant: 60),
            hallHelpButton.heightAnchor.constraint(equalToConstant: 60),
            
            possibleErrorButton.bottomAnchor.constraint(equalTo: questionsLabel.topAnchor, constant: -50),
            possibleErrorButton.leadingAnchor.constraint(equalTo: hallHelpButton.trailingAnchor, constant: 40),
            possibleErrorButton.widthAnchor.constraint(equalToConstant: 60),
            possibleErrorButton.heightAnchor.constraint(equalToConstant: 60),
            
            timeLabel.bottomAnchor.constraint(equalTo: questionsLabel.topAnchor, constant: 50),
            timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeLabel.widthAnchor.constraint(equalToConstant: 80),
            timeLabel.heightAnchor.constraint(equalToConstant: 80),
            
            questionsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            questionsLabel.widthAnchor.constraint(equalToConstant: 330),
            questionsLabel.heightAnchor.constraint(equalToConstant: 300),
            
            aButton.topAnchor.constraint(equalTo: questionsLabel.bottomAnchor, constant: 0),
            aButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            aButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            aButton.heightAnchor.constraint(equalToConstant: 50),
            
            bButton.topAnchor.constraint(equalTo: aButton.bottomAnchor, constant: 20),
            bButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            bButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            bButton.heightAnchor.constraint(equalToConstant: 50),
            
            cButton.topAnchor.constraint(equalTo: bButton.bottomAnchor, constant: 20),
            cButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            cButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            cButton.heightAnchor.constraint(equalToConstant: 50),
            
            dButton.topAnchor.constraint(equalTo: cButton.bottomAnchor, constant: 20),
            dButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            dButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            dButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    //MARK: - Actions after answer
    
    @objc func aButtonAction() {
        aButton.shake()
        aButton.backgroundColor = .white
        handleButtons()
        gameTimer.invalidate()
        hideNavigationBarItems()
        playSound(resource: "waitForInspection")
        tagButton = aButton.tag
        currentTitleAnswerButton = aButton.currentTitle
        (fiftyButton.isEnabled, hallHelpButton.isEnabled, possibleErrorButton.isEnabled) = (false, false, false)
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(checkAnswer), userInfo: nil, repeats: false)
    }
    
    @objc func bButtonAction() {
        bButton.shake()
        bButton.backgroundColor = .white
        handleButtons()
        gameTimer.invalidate()
        hideNavigationBarItems()
        playSound(resource: "waitForInspection")
        tagButton = bButton.tag
        currentTitleAnswerButton = bButton.currentTitle
        (fiftyButton.isEnabled, hallHelpButton.isEnabled, possibleErrorButton.isEnabled) = (false, false, false)
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(checkAnswer), userInfo: nil, repeats: false)
    }
    
    @objc func cButtonAction() {
        cButton.shake()
        cButton.backgroundColor = .white
        handleButtons()
        gameTimer.invalidate()
        hideNavigationBarItems()
        playSound(resource: "waitForInspection")
        tagButton = cButton.tag
        currentTitleAnswerButton = cButton.currentTitle
        (fiftyButton.isEnabled, hallHelpButton.isEnabled, possibleErrorButton.isEnabled) = (false, false, false)
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(checkAnswer), userInfo: nil, repeats: false)
    }
    
    @objc func dButtonAction() {
        dButton.shake()
        dButton.backgroundColor = .white
        handleButtons()
        gameTimer.invalidate()
        hideNavigationBarItems()
        playSound(resource: "waitForInspection")
        tagButton = dButton.tag
        currentTitleAnswerButton = dButton.currentTitle
        (fiftyButton.isEnabled, hallHelpButton.isEnabled, possibleErrorButton.isEnabled) = (false, false, false)
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(checkAnswer), userInfo: nil, repeats: false)
    }
    
    @objc func tachMoneyButton() {
            gameTimer.invalidate()
            gameBrain?.numberOfQuestion -= 1
            goToLevelListViewController()
            playSound(resource: "tachMoney")
            Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(showAlertOfTachMoney), userInfo: nil, repeats: false)
    }
    
    @objc func gameOver() {
        self.navigationController?.popToRootViewController(animated: true)
        player.stop()
        gameBrain?.numberOfQuestion = 0
    }
    
    func showAlertEndOfTime() {
        let alert = UIAlertController(
            title: "ВРЕМЯ ВЫШЛО",
            message: gameBrain?.wonAmountWhenEndTime(),
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ВЫЙТИ", style: .cancel, handler: { event in
            if let navigator = self.navigationController {
                navigator.popToRootViewController(animated: true)
            }
        }))
        self.present(alert, animated: true)
    }
    
    func showAlertHint() {
        let alert = UIAlertController(title: "Упс...",
                                      message: "\nВы уже использовали эту подсказку 😕",
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertWrongAnswer() {
        let alert = UIAlertController(
            title: "НЕПРАВИЛЬНО",
            message: gameBrain?.wonAmountWhenEndTime(),
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ВЫЙТИ", style: .cancel, handler: { event in
            if let navigator = self.navigationController {
                navigator.popToRootViewController(animated: true)
            }
            self.gameBrain?.numberOfQuestion = 0
        }))
        self.present(alert, animated: true)
    }
    
    @objc func showAlertOfTachMoney() {
        let alert = UIAlertController(
            title: "ВАШ ВЫИГРЫШ",
            message: "\n\(gameBrain?.wonAmountWhenTachMoney() ?? "0 рублей")",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ВЫЙТИ", style: .cancel, handler: { event in
            if let navigator = self.navigationController {
                navigator.popToRootViewController(animated: true)
            }
            player.stop()
        }))
        self.present(alert, animated: true)
    }
}

//MARK: - Extensions

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat, distribution: UIStackView.Distribution) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension GameViewController: LevelListViewControllerDelegate {
    func nextLevel() {
        gameBrain?.getQuestion()
        startTimer()
        answerButton()
        timeLabel.text = "30"
        questionsLabel.text = gameBrain?.currentQuestion
        playSound(resource: "waitForResponse")
    }
}
