//
//  GenresView.swift
//  MyBooks
//
//  Created by Andy Chao on 2024/12/17.
//

import SwiftData
import SwiftUI

struct GenresView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @Bindable var book: Book
    @Query(sort: \Genre.name) var genres: [Genre]

	@State private var newGenre = false
    var body: some View {
		NavigationStack {
			Group {
				if genres.isEmpty {
					ContentUnavailableView {
						Image(systemName: "bookmark.fill")
							.font(.largeTitle)
					} description: {
						Text("You need to create some genres first.")
					} actions: {
						Button("Create genre") {
							newGenre = true
						}
						.buttonStyle(.borderedProminent)
					}
				} else {
					List {
						ForEach(genres) { genre in
							HStack {
								if let bookGenres = book.genres {
									if bookGenres.isEmpty {
										Button {
											addRemove(genre)
										} label: {
											Image(systemName: "circle")
										}
										.foregroundStyle(genre.hexColor)
									} else {
										Button {
											addRemove(genre)
										} label: {
											Image(systemName: bookGenres.contains(genre) ? "circle.fill" : "circle")
										}
										.foregroundStyle(genre.hexColor)
									}
								}
								Text(genre.name)
							}
						}
						.onDelete { indexSet in
							indexSet.forEach { index in
								if let bookGenres = book.genres,
								   bookGenres.contains(genres[index]),
								   let bookGenreIndex = bookGenres.firstIndex(where: { $0.id == genres[index].id }) {
									book.genres?.remove(at: bookGenreIndex)
								}
								modelContext.delete(genres[index])
							}
						}
						LabeledContent {
							Button {
								newGenre = true
							} label: {
								Image(systemName: "plus.circle.fill")
									.imageScale(.large)
							}
							.buttonStyle(.borderedProminent)
						} label: {
							Text("Create new genre")
								.font(.caption)
								.foregroundStyle(.secondary)
						}
					}
				}
			}
			.navigationTitle(book.title)
			.sheet(isPresented: $newGenre) {
				NewGenreView()
			}
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					Button("Back") {
						dismiss()
					}
				}
			}
		}
    }
	
	func addRemove(_ genre: Genre) {
		if let bookGenres = book.genres {
			if bookGenres.isEmpty {
				book.genres?.append(genre)
			} else {
				if bookGenres.contains(genre), let index = bookGenres.firstIndex(where: { $0.id == genre.id }) {
					book.genres?.remove(at: index)
				} else {
					book.genres?.append(genre)
				}
			}
		}
	}
}

#Preview {
    let preview = Preview(Book.self)
    let books = Book.sampleBooks
    let genres = Genre.sampleGenres
    preview.addExamples(books)
    preview.addExamples(genres)
	books[1].genres?.append(genres[0])
	return NavigationView {
		GenresView(book: books[1])
			.modelContainer(preview.container)
	}
}
