//
//  iMedidateApp.swift
//  iMedidate
//
//  Created by Амир Кайдаров on 1/17/23.
//

import SwiftUI

@main
struct iMedidateApp: App {
    @StateObject var audioManager = AudioManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(audioManager)
        }
    }
}
