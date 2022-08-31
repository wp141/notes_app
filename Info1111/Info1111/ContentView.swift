//
//  ContentView.swift
//  Info1111
//
//  Created by Will Polich on 31/3/2022.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @EnvironmentObject var sessionService : SessionService
    @StateObject var notesManager = NotesManager()
    
    @State var confirmLogout = false
    @State var logoutFailed = false
    @State var logoutError = ""
    
    let formatter = DateFormatter()
    
    var body: some View {
        NavigationView {

            List (notesManager.notes) { note in
                VStack (alignment: .leading) {
                    NavigationLink(destination: NoteView(note: note)
                                    .environmentObject(notesManager), label: {
    
                        VStack (alignment: .leading) {
                            Spacer()
                            Text(note.title)
                            

                            Text(formatter.string(from: note.lastEdited.dateValue()))
                                .foregroundColor(Color.secondary)
                                .font(.system(size: 10))
                                
                            
                            Spacer()
                
                            
                        }
                        
                        
                    })
                    
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        confirmLogout.toggle()
                    } label: {
                        Image(systemName: "person.crop.circle.badge.xmark")
                    }

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: NewNoteView()
                                    .environmentObject(notesManager), label : {
                        Image(systemName: "plus")
                    })
                }
                
            }
            .alert("Error logging out", isPresented: $logoutFailed, actions: {
                Button {
                    logoutFailed.toggle()
                    logoutError = ""
                } label: {
                    Text("Ok")
                }
                
            }, message: {
                Text(self.logoutError)
            })
            .alert("Are you sure you want to log out?", isPresented: $confirmLogout) {
                Button {
                    confirmLogout.toggle()
                } label: {
                    Text("Cancel")
                }
                
                Button {
                    confirmLogout.toggle()
                    sessionService.logout(completion: {error in
                        if let error = error {
                            logoutError = error.localizedDescription
                            logoutFailed.toggle()
                        }
                    })
                } label: {
                    Text("Confirm")
                }

                
            }
            .refreshable {
                notesManager.getNotes()
            }
        }
       
        
        .onAppear {
            formatter.dateFormat = "EEEE, dd MMMM"
            notesManager.getNotes()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
