//
//  BookTableViewCell.swift
//  ToDo
//
//  Created by Tatevik Brsoyan on 03.10.22.
//

import UIKit

protocol BookCellDelegate: AnyObject {
    func checkMarkTapped(sender: BookCell)
}

class BookCell: UITableViewCell {

    @IBOutlet var isCompleteButton: UIButton!
    @IBOutlet var nameLabel: UILabel!

    weak var delegate: BookCellDelegate?

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func completeButtonTapped(_ sender: Any) {
        delegate?.checkMarkTapped(sender: self)
    }
}
