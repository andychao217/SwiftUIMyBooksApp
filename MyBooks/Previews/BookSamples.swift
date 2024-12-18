//
//  BookSamples.swift
//  MyBooks
//
//  Created by Andy Chao on 2024/12/16.
//

import Foundation

extension Book {
	static let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date.now)!
	static let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date.now)!
	static var sampleBooks: [Book] {
		[
			Book(title: "QBVII", author: "Leon Uris", recommendedBy: ""),
			Book(
				title: "Macbeth",
				author: "William Shakespear",
				dateAdded: lastWeek,
				dateStarted: Date.now,
				status: Status.inProgress,
				recommendedBy: "Elon Musk"
			),
			Book(
				title: "Silence of the Grave",
				author: "Arnuldur Indrason, Bernard Scudder",
				dateAdded: lastMonth,
				dateStarted: lastWeek,
				summary: "Inheriting Ian Fleming's long-lost account of his spy activities during World War II",
				rating: 4,
				status: Status.completed,
				recommendedBy: ""
			),
		]
	}
}
