//
//  AudioManager.swift
//  iMedidate
//
//  Created by Амир Кайдаров on 1/18/23.
//

import Foundation
import AVKit

final class AudioManager : ObservableObject {
    
    @Published var player : AVAudioPlayer?
    @Published private(set) var isPlaying : Bool = true
    @Published private(set) var isLooping : Bool = false
    
    func startPlayer(track : String) {
        guard let url = Bundle.main.url(forResource: track, withExtension: "mp3") else {
            print("resource not found: \(track)")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            self.player = try AVAudioPlayer(contentsOf: url)
            
            player?.play()
        } catch {
            print("Failed to initialize the player", error)
        }
    }
    
    func playPause() {
        guard let player = player else { return }
        if player.isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying = player.isPlaying
    }
    
    func stop() {
        guard let player = player else { return }
        
        if player.isPlaying {
            player.stop()
            isPlaying = false
        }
    }
    
    func toggleLoop() {
        guard let player = player else { return }
        
        player.numberOfLoops = player.numberOfLoops == 0 ? -1 : 0
        isLooping = player.numberOfLoops != 0
    }
}
