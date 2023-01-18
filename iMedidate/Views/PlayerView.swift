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
    @EnvironmentObject var audioManager : AudioManager
    @State private var isEditing : Bool = false
    
    let timer = Timer
        .publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
    
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
                cancelButton
                
                Text(meditationVM.meditation.title)
                    .font(.title)
                    .foregroundColor(.white)
                
                Spacer()
                
                audioSlider
                
                optionButtons
                
            }
            .padding(20)
        }
        .onAppear {
            audioManager.startPlayer(track: meditationVM.meditation.track)
        }
        .onReceive(timer) { _ in
            guard let player = audioManager.player, !isEditing else { return }
            
            value = player.currentTime
        }
    }
}

extension PlayerView {
    private var cancelButton : some View {
        HStack {
            Button {
                audioManager.stop()
                presentatinoMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 36))
                    .foregroundColor(.white)
            }
            Spacer()
        }
    }
    
    @ViewBuilder private var audioSlider : some View {
        if let player = audioManager.player {
            VStack (spacing: 5) {
                Slider(value: $value,
                       in: 0...player.duration,
                       onEditingChanged: { editing in
                    isEditing = editing
                    if !editing {
                        player.currentTime = value
                    }
                })
                .accentColor(.white)
                
                HStack {
                    Text(DateComponentsFormatter.positional.string(from: player.currentTime) ?? "0:00")
                    Spacer()
                    Text(DateComponentsFormatter.positional.string(from: player.duration - player.currentTime) ?? "0:00")
                }
                .font(.caption)
                .foregroundColor(.white)
            }
        }
    }
    
    @ViewBuilder private var optionButtons : some View {
        if let player = audioManager.player {
            HStack {
                let color : Color = audioManager.isLooping ? .teal : .white
                PlaybackControllerButton(systemName: "repeat",
                                         color: color) {
                    audioManager.toggleLoop()
                }
                Spacer()
                PlaybackControllerButton(systemName: "gobackward.10") {
                    player.currentTime -= 10
                }
                Spacer()
                PlaybackControllerButton(systemName: audioManager.isPlaying
                                         ? "pause.circle.fill"
                                         : "play.circle.fill",
                                         fontSize: 44) {
                    audioManager.playPause()
                }
                Spacer()
                PlaybackControllerButton(systemName: "goforward.10") {
                    player.currentTime += 10
                }
                Spacer()
                PlaybackControllerButton(systemName: "stop.fill") {
                    audioManager.stop()
                    presentatinoMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct PlayerView_Previews: PreviewProvider {
    static let meditationVM = MeditationViewModel(meditation: Meditation.data)
    static var previews: some View {
        PlayerView(meditationVM: meditationVM)
            .environmentObject(AudioManager())
    }
}
