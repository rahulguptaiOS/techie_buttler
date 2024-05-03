//
//  CommentTableViewCell.swift
//  TechieButtler
//
//  Created by Rahul Gupta on 03/05/24.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var commentorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentView.layer.cornerRadius = 10
    }
    
    // MARK: - Configure Cell
    
    func configure(with comment: Comment) {
        commentorName.text = comment.name
        self.comment.text = comment.body
    }

}
