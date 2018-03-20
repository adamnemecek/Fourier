//
//  AudioManager.swift
//  Fourier
//
//  Created by Blocry Glass on 3/16/18.
//  Copyright © 2018 Blocry Glass. All rights reserved.
//

import Foundation
import AVFoundation
import Accelerate

class AudioManager {
    private let audioEngine = AVAudioEngine()
    private let audioNode = AVAudioPlayerNode()
    weak var delegate: AudioManagerDelegate?
    private let fftHelper = FFTHelper()
    
    init() {
        audioEngine.attach(audioNode)
    }
    
    func play(fileWithURL url: URL) {
        if let inputFile = try? AVAudioFile(forReading: url) {
            let buffer = AVAudioPCMBuffer(pcmFormat: inputFile.processingFormat, frameCapacity: AVAudioFrameCount(inputFile.length))!
            try? inputFile.read(into: buffer)
            audioEngine.connect(audioNode, to: audioEngine.mainMixerNode, format: buffer.format)
            audioNode.scheduleBuffer(buffer, at: nil, options: .loops, completionHandler: nil)
            
            // Install tap
            let bufferSize: UInt32 = 4000
            let mixerNode = audioEngine.mainMixerNode
            mixerNode.installTap(onBus: 0, bufferSize: bufferSize, format: mixerNode.outputFormat(forBus: 0)) { (buffer, time) in
                buffer.frameLength = bufferSize
                self.fftHelper.fourierTransform(buffer: buffer, audioManager: self) // possible memory cycle
            }
            
            // Start Playing
            try? audioEngine.start()
            audioNode.play()
        }
    }
}
