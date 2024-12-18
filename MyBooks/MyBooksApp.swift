//
//  MyBooksApp.swift
//  MyBooks
//
//  Created by Andy Chao on 2024/12/16.
//

import SwiftUI
import SwiftData

@main
struct MyBooksApp: App {
	let container: ModelContainer
	
    var body: some Scene {
        WindowGroup {
            BookListView()
        }
		.modelContainer(container)
    }
	
	init() {
		let schema = Schema([Book.self])
		let config = ModelConfiguration("MyBooks", schema: schema)
		do {
			container = try ModelContainer(for: schema, configurations: config)
		} catch {
			fatalError("Could not configure the container")
		}
//		let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "MyBooks.store"))
//		do {
//			container = try ModelContainer(for: Book.self, configurations: config)
//		} catch {
//			fatalError("Could not configure the container")
//		}
		
		print(URL.documentsDirectory.path())
	}
}
