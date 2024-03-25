//
//  NoteModel.swift
//  to-do
//
//  Created by Ruben on 25/3/24.
//

import Foundation

struct NoteModel: Codable {
    let id: String
    var isFavorite: Bool
    let content: String
    
    init(id: String = UUID().uuidString, isFavorite: Bool = false, content: String) {
        self.id = id
        self.isFavorite = isFavorite
        self.content = content
    }
}
