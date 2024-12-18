//
//  Book.swift
//  MyBooks
//
//  Created by Andy Chao on 2024/12/16.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Book {
    var title: String = ""
    var author: String = ""
	var dateAdded: Date = Date.now
	var dateStarted: Date = Date.distantPast
	var dateCompleted: Date = Date.distantFuture
//	@Attribute(originalName: "summary")
    var summary: String = ""
    var rating: Int?
	var status: Status.RawValue = Status.onShelf.rawValue
	var recommendedBy: String = ""
	@Relationship(deleteRule: .cascade)
	var quotes: [Quote]?
	@Relationship(inverse: \Genre.books)
	var genres: [Genre]?
	
	@Attribute(.externalStorage)
	var bookCover: Data?
//	@Attribute(.allowsCloudEncryption)
//	var sin: String
//	@Attribute(.unique)
//	var title: String
	
    init(
		title: String,
		author: String,
		dateAdded: Date = Date.now,
		dateStarted: Date = Date.distantPast,
		dateCompleted: Date = Date.distantPast ,
		summary: String = "",
		rating: Int? = nil,
		status: Status = .onShelf,
		recommendedBy: String,
		genres: [Genre]? = nil
	) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.summary = summary
        self.rating = rating
		self.status = status.rawValue
		self.recommendedBy = recommendedBy
		self.genres = genres
    }
	
	var icon: Image {
		switch Status(rawValue: status)! {
			case .onShelf:
				Image(systemName: "checkmark.diamond.fill")
			case .inProgress:
				Image(systemName: "book.fill")
			case .completed:
				Image(systemName: "books.vertical.fill")
		}
	}
}

enum Status: Int, Codable, Identifiable, CaseIterable {
    case onShelf, inProgress, completed
    var id: Self {
        self
    }

	var descr: LocalizedStringResource {
        switch self {
        case .onShelf:
            "On Shelf"
        case .inProgress:
            "In Progress"
        case .completed:
            "Completed"
        }
    }
}