import UIKit

protocol LevelListViewControllerDelegate: AnyObject {
    func nextLevel()
}

class LevelListViewController: UIViewController {
    
    let delegate: LevelListViewControllerDelegate!
    let questions: [Question]
    let numberOfCompletedQuestions: Int
    
    init(delegate: LevelListViewControllerDelegate!, questions: [Question] = Question.questions, numberOfCompletedQuestions: Int) {
        self.delegate = delegate
        self.questions = questions
        self.numberOfCompletedQuestions = numberOfCompletedQuestions
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = LevelListView()
        view.delegate = self
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension LevelListViewController {
    func setup() {
        
    }
}

extension LevelListViewController: LevelListViewDelegate {
    func getNumberOfCompletedQuestions() -> Int {
        return numberOfCompletedQuestions
    }
    
    func nextLevelButtonTapped() {
        delegate.nextLevel()
        dismiss(animated: true)
    }
    
    func getNumberOfQuestions() -> Int {
        return questions.count
    }
    
    func getQuestion(_ indexPath: IndexPath) -> Question {
        return questions.reversed()[indexPath.row]
    }
}
