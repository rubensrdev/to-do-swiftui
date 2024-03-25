//
//  ContentView.swift
//  to-do
//
//  Created by Ruben on 21/3/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var noteContent: String = ""
    @StateObject var notesViewModel = NotesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Añade una nota")
                    .underline()
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 16)
                TextEditor(text: $noteContent)
                    .foregroundStyle(.gray)
                    .frame(height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.green, lineWidth: 2)
                    )
                    .padding(.horizontal, 12)
                    .cornerRadius(3.0)
                Button("Crear") {
                    if !noteContent.isEmpty {
                        notesViewModel.saveNote(content: noteContent)
                    }
                }
                .buttonStyle(.bordered)
                .tint(.green)
                Spacer()
                List {
                    ForEach($notesViewModel.notes, id: \.id) { $note in
                        HStack {
                            if note.isFavorite {
                                Text("⭐️")
                            }
                            Text(note.content)
                        }
                        .swipeActions(edge: .trailing) {
                            Button {
                                notesViewModel.updateFavoriteNote(note: $note)
                            } label: {
                                Label("FAV", systemImage: "star.fill")
                            }
                            .tint(.yellow)
                        }
                        .swipeActions(edge: .leading) {
                            Button {
                                notesViewModel.removeNote(withId: note.id)
                            } label: {
                                Label("Borrar", systemImage: "trash.fill")
                            }
                            .tint(.yellow)
                        }
                    }
                }
            }
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Text("\(notesViewModel.getNumberOfNotes())")
            }
        }
    }
}

#Preview {
    ContentView()
}
