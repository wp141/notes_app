//
//  NoteModel.swift
//  Info1111
//
//  Created by Will Polich on 31/3/2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Note : Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var text: String
    var lastEdited: Timestamp
}
