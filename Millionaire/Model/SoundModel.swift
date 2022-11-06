//
//  SoundModel.swift
//  Millionaire
//
//  Created by Valery Keplin on 31.10.22.
//

import AVFoundation

var player: AVAudioPlayer!

func playSound(resource: String) {
    let url = Bundle.main.url(forResource: resource, withExtension: "mp3")
    player = try! AVAudioPlayer(contentsOf: url!)
    player.play()
}
