//
//  ContentView.swift
//  MyBooks
//
//  Created by Andy Chao on 2024/12/16.
//

import SwiftData
import SwiftUI

enum SortOrder: LocalizedStringResource, Identifiable, CaseIterable {
    case status, title, author
    var id: Self {
        self
    }
}

struct BookListView: View {
    @State private var createNewBook = false
    @State private var sortOrder = SortOrder.status
    @State private var filter = ""

    var body: some View {
        NavigationStack {
            Picker("", selection: $sortOrder) {
                ForEach(SortOrder.allCases) { sortOrder in
                    Text("Sort by \(sortOrder.rawValue)").tag(sortOrder)
                }
            }
            .buttonStyle(.bordered)

            BookList(sortOrder: sortOrder, filterString: filter)
                .searchable(text: $filter, prompt: Text("Filter on title or author"))
                .navigationTitle("My Books")
                .toolbar {
                    Button {
                        withAnimation {
                            createNewBook = true
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
                .sheet(isPresented: $createNewBook) {
                    NewBookView()
                        .presentationDetents([.medium])
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
    return BookListView()
        .modelContainer(preview.container)
		.environment(\.locale, Locale(identifier: "zh-cn"))
}
