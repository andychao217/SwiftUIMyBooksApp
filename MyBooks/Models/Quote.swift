//
//  Quote.swift
//  MyBooks
//
//  Created by Andy Chao on 2024/12/17.
//

import Foundation
import SwiftData

@Model
class Quote {
	var creationDate: Date = Date.now
	var text: String = ""
	var page: String?
	
	init(text: String, page: String? = nil) {
		self.text = text
		self.page = page
	}
	
	var book: Book?
}
