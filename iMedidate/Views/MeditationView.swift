//
//  MeditationView.swift
//  iMedidate
//
//  Created by Амир Кайдаров on 1/17/23.
//

import SwiftUI

struct MeditationView: View {
    @State private var showPlayer = false
    
    var body: some View {
        VStack (spacing: 0){
            Image("image-guy")
                .resizable()
                .scaledToFill()
                .frame(
                    height: UIScreen.main.bounds.height / 3)
            
            ZStack {
                Color(red: 24/255, green: 23/255, blue: 22/255)
                
                VStack(alignment: .leading, spacing: 24) {
                    VStack (alignment: .leading, spacing: 8) {
                        Text("Music")
                        Text("0s")
                    }
                    .font(.subheadline)
                    .textCase(.uppercase)
                    .opacity(0.7)
                    
                    Text("1 Minute Relaxing Meditation")
                        .font(.title)
                    
                    Button {
                        showPlayer = true
                    } label: {
                        Label("Play", systemImage: "play.fill")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(20)
                    }

                    
                    Text("Calm your mind and dive into the sea of your inner thoughts")
                    
                    Spacer()
                }
                .foregroundColor(.white)
                .padding(20)
            }
            .frame(height: UIScreen.main.bounds.height * 2 / 3)
        }
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $showPlayer) {
            PlayerView()
        }
    }
}

struct MeditationView_Previews: PreviewProvider {
    static var previews: some View {
        MeditationView()
    }
}
