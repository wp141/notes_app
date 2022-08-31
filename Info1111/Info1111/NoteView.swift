//
//  NoteView.swift
//  Info1111
//
//  Created by Will Polich on 31/3/2022.
//

import SwiftUI

struct NoteView: View {
    
    @EnvironmentObject var notesManager : NotesManager
    @Environment(\.presentationMode) var presentationMode
    
    @State var note : Note
    @State var deleteConfirmation = false
    
    var body: some View {
        VStack {
            TextField("Title", text: $note.title)
                    .font(.largeTitle.bold())
                
            TextEditor(text: $note.text)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background(Color.secondary)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(.horizontal)
        .navigationBarTitle("", displayMode: .inline)
        .onChange(of: note.title) { change in
            notesManager.updateNote(note: note)
        }
        .onChange(of: note.text) { change in
            notesManager.updateNote(note: note)
        }
        .toolbar {
            Button {
               deleteConfirmation = true
            } label : {
                Image(systemName: "trash")
            }
        }
        .alert("Are you sure you want to delete this note?", isPresented: $deleteConfirmation) {
            Button {
                deleteConfirmation = false
            } label: {
                Text("Cancel")
            }
            
            Button {
                notesManager.deleteNote(id: note.id ?? "")
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Confirm")
            }

            
        }
        
    }
}


