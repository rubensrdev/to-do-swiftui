//
//  NotesViewModel.swift
//  to-do
//
//  Created by Ruben on 25/3/24.
//

import Foundation
import SwiftUI

final class NotesViewModel: ObservableObject {
    // propiedad que enlazará con la vista, por eso la clase implementa el protocolo observableObject
    @Published var notes: [NoteModel] = []
    
    init() {
        notes = getAllNotes()
    }
    
    /*
     Método encargado de guardar la nota introducida desde la vista
     */
    func saveNote(content: String) {
        let newNote = NoteModel(content: content)
        notes.insert(newNote, at: 0)
        encodeAndSaveAllNotes()
    }
    
    /*
     Método que codifica y guarda todas las notas usando como "BD" UserDefaults
     */
    private func encodeAndSaveAllNotes() {
        if let encoded = try? JSONEncoder().encode(notes) {
            UserDefaults.standard.set(encoded, forKey: "notes")
        }
    }
    
    /*
     Método que recupera las notas que tengamos almacenadas en las UserDefaults
     */
    func getAllNotes() -> [NoteModel] {
        if let notesData = UserDefaults.standard.object(forKey: "notes") as? Data {
            if let notes = try? JSONDecoder().decode([NoteModel].self, from: notesData) {
                return notes
            }
        }
        return []
    }
    /*
     Método que elimina una nota
     */
    func removeNote(withId id: String) {
        notes.removeAll(where: { $0.id == id })
        encodeAndSaveAllNotes()
    }
    
    /*
     Actualiza el estado favorito de la nota
     */
    func updateFavoriteNote(note: Binding<NoteModel>) {
        note.wrappedValue.isFavorite = !note.wrappedValue.isFavorite
        encodeAndSaveAllNotes()
    }
    
    func getNumberOfNotes() -> Int {
        return notes.count
    }
    
}
