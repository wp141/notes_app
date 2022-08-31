//
//  NotesManager.swift
//  Info1111
//
//  Created by Will Polich on 31/3/2022.
//

import Foundation
import FirebaseFirestore

class NotesManager : ObservableObject {
    
    let db = Firestore.firestore()
    
    @Published var notes : [Note] = []
    
    func getNotes() {
        db.collection("notes").addSnapshotListener { (querySnapshot, error) in
            if let error = error {
                print("failed to get documents: \(error)")
                return
            }
            
            guard let documents = querySnapshot?.documents else {
                  print("No documents")
                  return
            }
            
            self.notes = documents.compactMap { queryDocumentSnapshot -> Note? in
                return try? queryDocumentSnapshot.data(as: Note.self)
                
            }
            
        }
    }
    
    func createNote(note: Note) {
        
        do {
            let _ = try db.collection("notes").addDocument(from: note)
        
          }
          catch {
            print("Error creating note: \(error)")
          }
    }
    
    func deleteNote(id: String) {
        
        if id == "" {
            print("Could not get document id from Note")
            return
        }
        
        db.collection("notes").document(id).delete(completion: { error in
            if let error = error {
                print("Error deleting note: \(error)")
                return
            }
        })
        
    }
    
    func updateNote(note: Note) {
        if let documentId = note.id {
            do {
              try db.collection("notes").document(documentId).setData(from: note)
            }
            catch {
                print("Error updating note: \(error)")
            }
        }
    }
}

