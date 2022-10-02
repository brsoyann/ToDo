//
//  ToDo.swift
//  ToDo
//
//  Created by Tatevik Brsoyan on 28.09.22.
//

import UIKit

struct Book: Equatable {

    let id = UUID()
    var title: String
    var author: String
    var readDate: Date
    var notes: String?
    var isComplete: Bool

    static func loadBooks() -> [Book]? {
        return nil
    }

    static func loadSampleBooks() -> [Book] {
        let book1 = Book(
            title: "Tree Comrades",
            author: "Erich Maria Remarque",
            readDate: Date(),
            notes: "novel, 1936",
            isComplete: true)
        let book2 = Book(
            title: "Fahrenheit 451",
            author: "Ray Bradbury",
            readDate: Date(),
            notes: "dystopian novel, 1953",
            isComplete: true)
        let book3 = Book(
            title: "Jane Eyre",
            author: "CHarlotter Bronte",
            readDate: Date(),
            notes: "novel, 1847",
            isComplete: false)
        return [book1, book2, book3]
    }

    static func == (lhs: Book, rhs: Book ) -> Bool {
        return lhs.id == rhs.id
    }
}
