//
//  PlaybackButton.swift
//  iMedidate
//
//  Created by Амир Кайдаров on 1/17/23.
//

import SwiftUI

struct PlaybackControllerButton: View {
    var systemName : String = "play"
    var fontSize : CGFloat = 24
    var color : Color = .white
    var action : () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .font(.system(size: fontSize))
                .foregroundColor(color)
        }
        
    }
}

struct PlaybackButton_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackControllerButton(action: {})
            .preferredColorScheme(.dark)
    }
}
