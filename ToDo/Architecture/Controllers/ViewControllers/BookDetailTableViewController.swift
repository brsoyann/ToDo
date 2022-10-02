//
//  BookDetailTableViewController.swift
//  ToDo
//
//  Created by Tatevik Brsoyan on 01.10.22.
//

import UIKit

final class BookDetailTableViewController: UITableViewController {

    var book: Book?

    // MARK: - Subviews

    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private  var isCompleteButton: UIButton!
    @IBOutlet private var authorTextField: UITextField!
    @IBOutlet private var readDateLabel: UILabel!
    @IBOutlet private var readDateDatePicker: UIDatePicker!
    @IBOutlet private var notesTextView: UITextView!
    @IBOutlet private var saveButton: UIBarButtonItem!

    // MARK: - Guts

    var isDatePickerHidden = true
    let dateLabelIndexPath = IndexPath(row: 0, section: 1)
    let datePickerIndexPath = IndexPath(row: 1, section: 1)
    let notesIndexPath = IndexPath(row: 0, section: 2)

    // MARK: - <##>LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        readDateDatePicker.date = Date().addingTimeInterval(24*3600)
        updateDueDateLabel(date: readDateDatePicker.date)
        updateSaveButtonState()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath where isDatePickerHidden == true:
            return 0
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case datePickerIndexPath:
            return 216
        case notesIndexPath:
            return 200
        default:
            return UITableView.automaticDimension
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == dateLabelIndexPath {
            isDatePickerHidden.toggle()
            updateDueDateLabel(date: readDateDatePicker.date)
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        guard segue.identifier ==  "saveUnwind" else { return }

        guard
            let title = titleTextField.text,
            let author = authorTextField.text
        else { return }
        let isComplete = isCompleteButton.isSelected
        let readDate = readDateDatePicker.date
        let notes = notesTextView.text

        book = Book(title: title, author: author, readDate: readDate, notes: notes, isComplete: isComplete)
    }

    // MARK: - <##>Helpers

    func updateSaveButtonState() {
        let shouldEnableSaveButton = (titleTextField.text?.isEmpty == false && authorTextField.text?.isEmpty == false)
        saveButton.isEnabled = shouldEnableSaveButton
    }

    func updateDueDateLabel(date: Date) {
        readDateLabel.text = date.formatted(.dateTime.month(.defaultDigits).day().year(.twoDigits).hour().minute())
    }

    // MARK: - <##>CallBacks

    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }

    @IBAction func returnPressed(_ sender: UITextField) {
        sender.resignFirstResponder()
    }

    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected.toggle()
    }

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: sender.date)
    }

}
