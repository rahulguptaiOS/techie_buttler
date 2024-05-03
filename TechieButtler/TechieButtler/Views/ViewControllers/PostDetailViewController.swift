//
//  PostDetailViewController.swift
//  TechieButtler
//
//  Created by Rahul Gupta on 03/05/24.
//

import UIKit
import Combine

class PostDetailViewController: UIViewController {

    @IBOutlet weak var postId: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postBody: UILabel!
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var table: UITableView!
    
    private var headerView: UIView = {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        let headerLabel = UILabel(frame: CGRect(x: 16, y: 0, width: 320 - 32, height: 50))
        headerLabel.text = Titles.comments
        headerLabel.textColor = UIColor.black
        headerLabel.font = UIFont.titleFont
        headerView.addSubview(headerLabel)
        return headerView
    }()
    
    private var items: [Comment] = []
    private var viewModel: CommentViewModel?
    private var subscriptions = Set<AnyCancellable>()
    var post: PostDetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPostView()
        setupTableView()
        loader.startAnimating()
        viewModel?.loadComments(id: post?.id)
    }
    
    private func setUpPostView() {
        postLabel.preferredMaxLayoutWidth = 300
        postLabel.numberOfLines = .zero
        postView.layer.cornerRadius = 5.0
        postView.backgroundColor = post?.color
        postLabel.text = post?.title
        postBody.text = post?.body
        postId.text = post?.identifier
        postLabel.sizeToFit()
        postBody.sizeToFit()
        title = "\(Titles.userId)\(post?.userIdentifier ?? "")"
    }
    
    private func setupTableView() {
        table.rowHeight = UITableView.automaticDimension
        table.dataSource = self
        table.tableHeaderView = headerView
        let nib = UINib(nibName: Identifier.commentTableViewCell, bundle: nil)
        table.register(nib, forCellReuseIdentifier: Identifier.commentTableViewCell)
        viewModel = DependencyInjector.shared.container.resolve(CommentViewModel.self)
        setupBindings()
    }
    
    private func setupBindings() {
        viewModel?.dataSubject.sink { [weak self] data in
                self?.updateTableView(with: data)
            }
            .store(in: &subscriptions) 

        viewModel?.errorSubject.sink { [weak self] error in
                self?.loader.stopAnimating()
                self?.presentErrorAlert(with: error)
            }
            .store(in: &subscriptions)
    }
    
}

// MARK: - UITableViewDataSource

extension PostDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.commentTableViewCell, for: indexPath) as? CommentTableViewCell {
            let item = items[indexPath.row]
            cell.configure(with: item)
            return cell
        }
        
        return UITableViewCell()
    }
}

extension PostDetailViewController {
    private func presentErrorAlert(with error: Error) {
        present(Utilities.presentErrorAlert(with: error), animated: true)
    }
    
    private func updateTableView(with data: [Comment]) {
        items.append(contentsOf: data)
        table.reloadData()
    }
}
