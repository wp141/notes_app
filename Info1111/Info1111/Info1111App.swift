//
//  Info1111App.swift
//  Info1111
//
//  Created by Will Polich on 31/3/2022.
//

import SwiftUI
import UIKit
import Firebase

@main
struct Info1111App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var sessionService = SessionService()

    var body: some Scene {
        WindowGroup {
                let signedIn = sessionService.signedIn()
                if signedIn {
                    ContentView()
                        .environmentObject(sessionService)
                } else {
                    AuthView()
                        .environmentObject(sessionService)
                }
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
                   [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      
    FirebaseApp.configure()

    return true
  }
}
