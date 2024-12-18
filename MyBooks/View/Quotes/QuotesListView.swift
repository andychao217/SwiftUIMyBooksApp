//
//  QuotesListView.swift
//  MyBooks
//
//  Created by Andy Chao on 2024/12/17.
//

import SwiftUI

struct QuotesListView: View {
	@Environment(\.modelContext) private var modelContent
	let book: Book
	@State private var text = ""
	@State private var page = ""
	@State private var selectedQuote: Quote?
	var isEditing: Bool {
		selectedQuote != nil
	}
	
    var body: some View {
		GroupBox {
			HStack {
				LabeledContent("Page") {
					TextField("Page #", text: $page)
						.autocorrectionDisabled()
						.textFieldStyle(.roundedBorder)
						.frame(width: 150)
					Spacer()
				}
				if isEditing {
					Button("Cancel") {
						resetState()
					}
					.buttonStyle(.bordered)
				}
				Button(isEditing ? "Update" : "Create") {
					if isEditing {
						selectedQuote?.text = text
						selectedQuote?.page = page.isEmpty ? nil : page
						resetState()
					} else {
						let quote = page.isEmpty ? Quote(text: text) : Quote(text: text, page: page)
						book.quotes?.append(quote)
						resetState()
					}
				}
				.buttonStyle(.borderedProminent)
				.disabled(text.isEmpty)
			}
			TextEditor(text: $text)
				.border(Color.secondary)
				.frame(height: 100)
		}
		.padding(.horizontal)
		
		List {
			let sortedQuotes = book.quotes?.sorted(using: KeyPathComparator(\Quote.creationDate)) ?? []
			ForEach(sortedQuotes) { quote in
				VStack(alignment: .leading) {
					Text(quote.creationDate, format: .dateTime.month().day().year())
						.font(.caption)
						.foregroundStyle(.secondary)
					Text(quote.text)
					HStack {
						Spacer()
						if let page = quote.page, !page.isEmpty {
							Text("Page: \(page)")
						}
					}
				}
				.background(selectedQuote == quote ? Color.gray : Color.white)
				.contentShape(Rectangle())
				.onTapGesture {
					selectedQuote = quote
					text = quote.text
					page = quote.page ?? ""
				}
			}
			.onDelete { indexSet in
				withAnimation {
					indexSet.forEach { index in
						let quote = sortedQuotes[index]
						book.quotes?.forEach({ bookQuote in
							if quote.id == bookQuote.id {
								modelContent.delete(quote)
							}
						})
						resetState()
					}
				}
			}
		}
		.listStyle(.plain)
		.navigationTitle("Quotes")
    }
	
	private func resetState() -> Void {
		page = ""
		text = ""
		selectedQuote = nil
	}
}

#Preview {
	let preview = Preview(Book.self)
	let books = Book.sampleBooks
	preview.addExamples(books)
	return NavigationStack {
		QuotesListView(book: books[1])
			.navigationBarTitleDisplayMode(.inline)
			.modelContainer(preview.container)
	}
}
