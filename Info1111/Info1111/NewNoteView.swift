//
//  NewNoteView.swift
//  Info1111
//
//  Created by Will Polich on 31/3/2022.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase


struct NewNoteView: View {
    @State var title : String = ""
    @State var text : String = ""
    
    @EnvironmentObject var notesManager: NotesManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ScrollView {
            TextField("Title", text: $title)
                .font(.largeTitle.bold())
            
            TextEditor(text: $text)
                .frame(minHeight: 700)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                .background(Color.secondary)
        
        }
        .navigationBarTitle("", displayMode: .inline)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(.horizontal)
        .toolbar {
            Button {
                let note = Note(id: nil, title: self.title, text: self.text, lastEdited: Timestamp.init())
                notesManager.createNote(note: note)
                presentationMode.wrappedValue.dismiss()
            } label : {
                Image(systemName: "checkmark")
            }
        }
        
    }
    
}

struct NewNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NewNoteView()
    }
}
