import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let backgroundViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5 // Rounded corners
        return view
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.idFont
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.bodyFont
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        contentView.addSubview(backgroundViewContainer)
        backgroundViewContainer.addSubview(idLabel)
        backgroundViewContainer.addSubview(bodyLabel)
        selectionStyle = .none
        
        NSLayoutConstraint.activate([
            backgroundViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            backgroundViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            backgroundViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            backgroundViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            idLabel.topAnchor.constraint(equalTo: backgroundViewContainer.topAnchor, constant: 8),
            idLabel.leadingAnchor.constraint(equalTo: backgroundViewContainer.leadingAnchor, constant: 16),
            idLabel.trailingAnchor.constraint(equalTo: backgroundViewContainer.trailingAnchor, constant: -16),
            
            bodyLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: backgroundViewContainer.leadingAnchor, constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: backgroundViewContainer.trailingAnchor, constant: -16),
            bodyLabel.bottomAnchor.constraint(equalTo: backgroundViewContainer.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Configure Cell
    
    func configure(with post: PostDetailModel) {
        idLabel.text = post.identifier
        bodyLabel.text = post.title
        backgroundViewContainer.backgroundColor = post.color
    }
    
}
