import UIKit

class LevelListTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = String(describing: LevelListTableViewCell.self)
    
    lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "?"
        view.font = .systemFont(ofSize: 15)
        view.textAlignment = .center
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.cornerCurve = .continuous
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var question: Question! {
        didSet {
            titleLabel.text = question.number
            if question.number.contains("1 000") || question.number.contains("32 000") {
                titleLabel.backgroundColor = .blue
                titleLabel.textColor = .white
            } else {
                titleLabel.backgroundColor = .systemGray6
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension LevelListTableViewCell {
    func setup() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}
