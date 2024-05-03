//
//  ViewController.swift
//  TechieButtler
//
//  Created by Rahul Gupta on 03/05/24.
//

import UIKit
import Combine

class PostViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var defaultLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    private var items: [PostDetailModel] = []
    private var viewModel: PostViewModel?
    private var subscriptions = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Titles.posts
        defaultLabel.text = Titles.noPost;
        setupViews()
        loader.isHidden = false
        loader.startAnimating()
        viewModel?.loadNextPage()
    }
    
    private func setupViews() {
        table.rowHeight = UITableView.automaticDimension
        table.delegate = self
        table.dataSource = self
        table.register(PostTableViewCell.self, forCellReuseIdentifier: Identifier.postTableViewCell)
        viewModel = DependencyInjector.shared.container.resolve(PostViewModel.self)
        setupBindings()
    }
  
    
    private func setupBindings() {
        viewModel?.dataSubject.sink { [weak self] data in
                self?.loader.stopAnimating()
                self?.updateTableView(with: data)
            }
            .store(in: &subscriptions) // Keep track of subscriptions for later disposal

        viewModel?.errorSubject.sink { [weak self] error in
                self?.loader.stopAnimating()
                self?.presentErrorAlert(with: error)
            }
            .store(in: &subscriptions)
    }
    
    private func showDetailViewController(for post: PostDetailModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: Identifier.postDetailViewController) as? PostDetailViewController else {
            return
        }
        
        detailViewController.post = post
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    deinit {
        subscriptions.forEach { $0.cancel() }
    }
}

// MARK: - UITableViewDataSource

extension PostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.postTableViewCell, for: indexPath) as! PostTableViewCell
        let item = items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension PostViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            loader.isHidden = false
            loader.startAnimating()
            viewModel?.loadNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailViewController(for: items[indexPath.row])
    }
}

// MARK: - Update UI

extension PostViewController {
    private func presentErrorAlert(with error: Error) {
        present(Utilities.presentErrorAlert(with: error), animated: true)
    }
    
    private func updateTableView(with data: [PostDetailModel]) {
        items.append(contentsOf: data)
        table.reloadData()
    }
}
