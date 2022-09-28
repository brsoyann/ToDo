//
//  BooksToReadTableViewController.swift
//  ToDo
//
//  Created by Tatevik Brsoyan on 28.09.22.
//

import UIKit

class BooksToReadTableViewController: UITableViewController {

    var books = [Books]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedBooks = Books.loadBooks() {
            books = savedBooks
        } else {
            books = Books.loadSampleBooks()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCellIdentifier", for: indexPath)

        let book = books[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = book.title
        cell.contentConfiguration = content
        return cell
    }
}
