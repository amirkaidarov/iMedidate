//
//  MeditationViewModel.swift
//  iMedidate
//
//  Created by Амир Кайдаров on 1/18/23.
//

import Foundation

struct Meditation {
    let id  = UUID()
    let title : String
    let description : String
    let duration : TimeInterval
    let track : String
    let image : String
    
    static let data = Meditation(title: "1 Minute Relaxing Meditation",
                                 description: "Calm your mind and dive into the sea of your inner thoughts",
                                 duration: 70,
                                 track: "meditation1",
                                 image: "image-guy")
}

final class MeditationViewModel : ObservableObject {
    private(set) var meditation : Meditation
    
    init(meditation : Meditation) {
        self.meditation = meditation
    }
    
    func getAbbreviatedDate() -> String {
        return DateComponentsFormatter.abbreviated.string(from: self.meditation.duration)
        ?? self.meditation.duration.formatted() + "S"
    }
}
