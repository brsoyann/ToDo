//
//  BooksToReadTableViewController.swift
//  ToDo
//
//  Created by Tatevik Brsoyan on 28.09.22.
//

import UIKit

final class BooksToReadTableViewController: UITableViewController {

    var books = [Book]()

    @IBAction func unwindToBookListSegue (_ sender: UIStoryboardSegue ) {

    }

    @IBSegueAction func editBook(
        _ coder: NSCoder,
        sender: Any?)
    -> BookDetailTableViewController? {
        let detailController = BookDetailTableViewController(coder: coder)
        guard let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else {
                  return detailController
              }
        tableView.deselectRow(at: indexPath, animated: true)
        detailController?.book = books[indexPath.row]
        return detailController
    }

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem

        if let savedBooks = Book.loadBooks() {
            books = savedBooks
        } else {
            books = Book.loadSampleBooks()
        }
    }

    // MARK: - Table view data source

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int)
    -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
    -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "BookCellIdentifier",
            for: indexPath)
                as? BookCell else { fatalError() }

        let book = books[indexPath.row]
        cell.titleLabel?.text = book.title
        cell.isCompleteButton.isSelected = book.isComplete
        cell.delegate = self

        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        canEditRowAt indexPath: IndexPath)
    -> Bool {
        return true
    }

    override func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            books.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    @IBAction func unwindToBooksToReadList (segue: UIStoryboardSegue ) {
        guard segue.identifier == "saveUnwind" else { return }
        guard let sourceViewController = segue.source as? BookDetailTableViewController else { return }

        if let book = sourceViewController.book {
            if let indexOfExistingBook = books.firstIndex(of: book) {
                books[indexOfExistingBook] = book
                tableView.reloadRows(at: [IndexPath(row: indexOfExistingBook, section: 0)], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: books.count, section: 0)
                books.append(book)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }

        }
    }

}

extension BooksToReadTableViewController: BookCellDelegate {
    func checkMarkTapped(sender: BookCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            var book = books[indexPath.row]
            book.isComplete.toggle()
            books[indexPath.row] = book
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}
