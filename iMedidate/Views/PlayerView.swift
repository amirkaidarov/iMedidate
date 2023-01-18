//
//  PlayerView.swift
//  iMedidate
//
//  Created by Амир Кайдаров on 1/17/23.
//

import SwiftUI

struct PlayerView: View {
    
    @State private var value : Double = 0.0
    @Environment(\.presentationMode) var presentatinoMode
    var meditationVM : MeditationViewModel
    
    var body: some View {
        ZStack {
            Image(meditationVM.meditation.image)
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .ignoresSafeArea()
            
            Rectangle()
                .background(.thinMaterial)
                .opacity(0.25)
                .ignoresSafeArea()
            
            VStack (spacing: 32){
                HStack {
                    Button {
                        presentatinoMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 36))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                
                Text(meditationVM.meditation.title)
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack (spacing: 5) {
                    Slider(value: $value,
                           in: 0...60)
                    .accentColor(.white)
                    
                    HStack {
                        Text("0:00")
                        Spacer()
                        Text("1:00")
                    }
                    .font(.caption)
                    .foregroundColor(.white)
                }
                
                HStack {
                    PlaybackControllerButton(systemName: "repeat") {
                        //
                    }
                    Spacer()
                    PlaybackControllerButton(systemName: "gobackward.10") {
                        //
                    }
                    Spacer()
                    PlaybackControllerButton(systemName: "play.fill", fontSize: 44) {
                        //
                    }
                    Spacer()
                    PlaybackControllerButton(systemName: "goforward.10") {
                        //
                    }
                    Spacer()
                    PlaybackControllerButton(systemName: "stop.fill") {
                        //
                    }
                }
                
            }
            .padding(20)
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static let meditationVM = MeditationViewModel(meditation: Meditation.data)
    static var previews: some View {
        PlayerView(meditationVM: meditationVM)
    }
}
