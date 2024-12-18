//
//  NewGenreView.swift
//  MyBooks
//
//  Created by Andy Chao on 2024/12/17.
//

import SwiftUI
import SwiftData

struct NewGenreView: View {
	@Environment(\.modelContext) private var modelContext
	@Environment(\.dismiss) private var dismiss
	
	@State private var name = ""
	@State private var color = Color.red
	
    var body: some View {
		NavigationStack {
			Form {
				TextField("Name", text: $name)
				ColorPicker("Set the genre color", selection: $color, supportsOpacity: false)
				Button("Create") {
					let newGenre = Genre(name: name, color: color.toHexString()!)
					modelContext.insert(newGenre)
					dismiss()
				}
				.buttonStyle(.borderedProminent)
				.frame(maxWidth: .infinity, alignment: .trailing)
				.disabled(name.isEmpty)
			}
			.padding()
			.navigationTitle("New Genre")
			.navigationBarTitleDisplayMode(.inline)
		}
    }
}

#Preview {
    NewGenreView()
}
