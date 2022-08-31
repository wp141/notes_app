//
//  AuthView.swift
//  Info1111
//
//  Created by Will Polich on 5/5/2022.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject var sessionService : SessionService
    
    @State var selectedTab = 1

    @State var email = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var error = ""
    
    @State var submitting = false
    
    var body: some View {
        NavigationView {
            VStack (spacing: 20){
                Picker("AuthPicker", selection: $selectedTab) {
                    Text("Log In").tag(1)
                    Text("Register").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                if selectedTab == 1 {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10, style: .continuous).strokeBorder(Color.secondary.opacity(0.3), lineWidth: 1)
                        }
                    
                    SecureField("Password", text: $password)
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10, style: .continuous).strokeBorder(Color.secondary.opacity(0.3), lineWidth: 1)
                        }
                    
                    
                    
                } else {
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10, style: .continuous).strokeBorder(Color.secondary.opacity(0.3), lineWidth: 1)
                        }
                    
                    SecureField("Password", text: $password)
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10, style: .continuous).strokeBorder(Color.secondary.opacity(0.3), lineWidth: 1)
                        }
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .padding(10)
                        .overlay {
                            RoundedRectangle(cornerRadius: 10, style: .continuous).strokeBorder(Color.secondary.opacity(0.3), lineWidth: 1)
                        }
                }
                
                Spacer()
                
                Text(error)
                    .foregroundColor(Color.red)
                
                Button {
                    self.error = ""
        
                    if selectedTab == 1 {
                        if email == "" || password == "" {
                            self.error = "Please fill out all fields."
                            return
                        }
                        
                        submitting = true
                        sessionService.login(email: email, password: password) { error in
                            if let error = error {
                                self.error = error.localizedDescription
                            }
                            
                            submitting = false
                        }
                    } else {
                        if email == "" || password == "" || confirmPassword == "" {
                            self.error = "Please fill out all fields."
                            return
                        }
                        
                        if password != confirmPassword {
                            self.error = "Passwords don't match."
                            return
                        }
                        
                        submitting = true
                        sessionService.register(email: email, password: password) { error in
                            if let error = error {
                                self.error = error.localizedDescription
                            }
        
                            submitting = false
                        }
                    }
                        
                } label: {
                    HStack {
                        if submitting {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        } else {
                            Text("Submit")
                                .foregroundColor(Color.white)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width*0.9, height: 45)
                    .background(.blue)
                    .cornerRadius(10)
                }
                

            }
            .padding(.horizontal)
            .navigationBarTitle(selectedTab == 1 ? "Log In" : "Register")
        }
        .navigationBarHidden(true)
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
