import UIKit

protocol LevelListViewDelegate: AnyObject {
    func nextLevelButtonTapped()
    func getNumberOfQuestions() -> Int
    func getQuestion(_ indexPath: IndexPath) -> Question
    func getNumberOfCompletedQuestions() -> Int
}

class LevelListView: UIView {
    
    weak var delegate: LevelListViewDelegate!
    
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = UIImage(named: "background")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var tableView: LevelListTableView = {
        let tableView = LevelListTableView(frame: .zero, style: .plain)
        tableView.dataSourceDelegate = self
        return tableView
    }()
    private lazy var nextLevelButton: UIButton = {
        let view = UIButton()
        view.setTitle("Следующий вопрос", for: .normal)
        view.backgroundColor = .yellow
        view.setTitleColor(.black, for: .normal)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        view.layer.cornerCurve = .continuous
        view.addTarget(self, action: #selector(nextQuestionTapped(sender: )), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func nextQuestionTapped(sender: UIButton!) {
        delegate.nextLevelButtonTapped()
    }
}

private extension LevelListView {
    func setup() {
        backgroundColor = .systemPurple
        
        addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -50)
        ])
        
        addSubview(nextLevelButton)
        NSLayoutConstraint.activate([
            nextLevelButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 5),
            nextLevelButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nextLevelButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nextLevelButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension LevelListView: LevelListTableViewDataSourceDelegate {
    func numberOfCompletedQuestions() -> Int {
        return delegate.getNumberOfCompletedQuestions()
    }
    
    func numberOfRowsInSection() -> Int {
        delegate.getNumberOfQuestions()
    }
    
    func cellForRowAt(_ indexPath: IndexPath) -> Question {
        return delegate.getQuestion(indexPath)
    }
}
